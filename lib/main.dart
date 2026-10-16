import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const KurdistanIPTVApp());
}

class KurdistanIPTVApp extends StatelessWidget {
  const KurdistanIPTVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KURDISTAN IPTV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF040B1E),
        primaryColor: const Color(0xFF0051FF),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class Channel {
  final String name;
  final String url;
  final String category;

  const Channel({
    required this.name,
    required this.url,
    required this.category,
  });
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  String selectedCategory = 'هەموو';
  String searchQuery = '';

  // لیستا هەمی 177 کەناڵان ب پۆلێن وان ڤە
  final List<Channel> allChannels = const [
    // --- نووچە و گشتی ---
    Channel(name: 'KU | RUDAW TV', url: 'https://live.rudaw.net/hls/rudaw-tv/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | AVA MEDIA TV', url: 'https://ava002.xyz/upload/images/1080.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDISTAN 24 TV', url: 'https://hlspackager.akamaized.net/live/DB/K24/HLS/K24.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SPEDA TV HD', url: 'https://www.speda2.site/upload/images/spedahd.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | GALI KURDISTAN TV', url: 'https://live.host247.net/gk/gksat/chunklist_w1879482920.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDSAT NEWS TV', url: 'https://hlspackager.akamaized.net/live/DB/KURDSAT_NEWS/HLS/KURDSAT_NEWS.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | NUÇÊ TV', url: 'https://hlspackager.akamaized.net/live/DB/NU_TV/HLS/NU_TV.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | NRT TV HD', url: 'https://hlspackager.akamaized.net/live/DB/NRT_HD/HLS/NRT_HD-avc1_2500000=10002,mp4a_128000=20000.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | CHANNEL 8', url: 'https://live.channel8.com/Channel8-Kurdish/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | MMN NEWS TV', url: 'http://mmn.mypsx.net:1935/live/mmnhdnews/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | AFARIN TV HD', url: 'https://65f16f0fdfc51.streamlock.net/afarinTV/livestream/chunklist_w187911945.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDISTAN TV HD', url: 'https://5a3ed7a72ed4b.streamlock.net/live/SMIL:myStream.smil/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SHAR TV HD', url: 'http://avrstream.com:1935/live/SHARTV/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | AVAR TV HD', url: 'https://avr.host247.net/live/AvarTv/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDSAT TV HD', url: 'https://hlspackager.akamaized.net/live/DB/KURDSAT_HD/HLS/KURDSAT_HD.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | WELAT TV HD', url: 'https://stream.badinan.xyz/welat/tv/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | BASK TV HD', url: 'http://baskhd.ddns.net:40/live/baskhd/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | EURO KURD TV', url: 'http://baskhd.ddns.net:40/live/Eurokurd/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | GK+ TV HD', url: 'https://live.host247.net/gk/gkplus/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | PESHANG TV HD', url: 'https://stream.forcaroo.com/stream/hls/desktop.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | RED TV HD', url: 'http://avrstream.com:1935/live/REDTV/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURD7 TV HD', url: 'http://avrstream.com:1935/live/Kurd7HD/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | HOMZHYAR TV HD', url: 'http://avrstream.com:1935/live/HormzyarHD/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | GEWHER TV HD', url: 'https://cdn.karwan.tv/gewher-tv/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | WAAR TV HD', url: 'https://live.kwikmotion.com/waarmedialive/waarmedia.smil/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | AVA FAMILY TV', url: 'https://familyhls.avatv.live/hls/stream.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KHAK TV HD', url: 'http://bblserver.ddns.net:1935/stream/khakhd/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | PAYAM TV HD', url: 'https://media2.streambrothers.com:1936/8218/8218/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | 4KURD TV HD', url: 'https://4kuhls.persiana.live/hls/stream.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | CAN TV HD', url: 'https://livetv.canbroadcast.com:7443/canlican/tv.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | CIRA TV HD', url: 'https://hlspackager.akamaized.net/live/DB/CIRA_TV/HLS/CIRA_TV.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | JIN TV HD', url: 'https://live.jintv.org/medialive/jintv.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURD CHANNEL TV', url: 'https://kurdchhls.wns.live/hls/stream.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | MMN DOCUMENTARY TV', url: 'http://mmn.mypsx.net:1935/live/mmnhddocumentary/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SHNA TV HD', url: 'http://shnatv.ddns.net:1935/live/shnatv/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | MIX TV HD', url: 'http://avrstream.com:1935/live/Mix-kurdy/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | NAQSHI MEDIA TV', url: 'http://naqshi-media.com:1935/live/NaqshiMedia/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | REHBER TV HD', url: 'https://cdn4.yayin.com.tr/rehbertv/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SORAN ENTERTAIMENT TV', url: 'http://avrstream.com:1935/live/SoranEntertainment/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | BAHA TV HD', url: 'http://baskhd.ddns.net:40/live/baskhd/yusfstore.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SADA TV HD', url: 'http://sada-hd.ddns.net:40/live/sadatv/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | QATAR TV HD', url: 'https://qatartv.akamaized.net/hls/live/20000609/qtv1/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | QATAR TV 2', url: 'https://qatartv.akamaized.net/hls/live/20000611/qtv2/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | WATAN TV HD', url: 'https://rp.tactivemedia.com/watantv_source/live/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | ZAGROS 24 TV HD', url: 'https://hlspackager.akamaized.net/live/DB/ZAGROS_24/HLS/ZAGROS_24.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | ALGHAD TV HD', url: 'https://eazyvwqssi.erbvr.com/alghadtv/alghadtv.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'AR | AL ARABIA NEWS', url: 'https://live.kwikmotion.com/alaraby1live/alaraby_abr/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | TRT 1 TV', url: 'https://tv-trt1.medya.trt.com.tr/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | TRT NEWS/HABER TV', url: 'https://tv-trthaber.medya.trt.com.tr/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | TRT MUSIC TV', url: 'https://tv-trtmuzik.medya.trt.com.tr/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | TRT KURDI TV', url: 'https://tv-trtkurdi.medya.trt.com.tr/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | TRT ARABIC TV', url: 'https://tv-trtarabi.medya.trt.com.tr/master.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SKY NEWS TV', url: 'https://stream.skynewsarabia.com/hls/sna.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | CNN TV HD', url: 'https://turnerlive.warnermediacdn.com/hls/live/586495/cnngo/cnn_slate/VIDEO_0_3564000.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | IRAQIA KURDISH', url: 'https://imn-live.esite-lab.com/hls/iraqia-kurdish.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | IRAQIA NEWS', url: 'https://imn-live.esite-lab.com/hls/iraqia-news.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | PESHMARGA TV HD', url: 'https://live20.bozztv.com/giatv/giatv-Shawkat/peshmerge/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | DIGLAH TV HD', url: 'https://ghaasiflu.online/Dijlah/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | BEFRIN TV HD', url: 'https://cdn.karwan.tv/befrin-tv/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ATV HD', url: 'https://b.livev.xyz/aytv/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | SHOW TV HD', url: 'https://b.livev.xyz/kanald/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | BINER TV HD', url: 'https://live20.bozztv.com/giatv/giatv-Shawkat/Biner_HD/chunks.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ALHADATH TV', url: 'https://live.alarabiya.net/alarabiapublish/alhadath.smil/alarabiapublish/alhadath_1080p/chunks.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | IRAQ 24 TV HD', url: 'https://ghaasiflu.online/Iraq24/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDMAX SORANI TV HD', url: 'https://kurdtv.org/api/public/hls?u=https%3A%2F%2Fstream.kurdmax.tv%2Fapp%2Fkurdmax-sorani1%2Fmedialist_917977731947844006_hls.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KURDMAX KURMANJI TV HD', url: 'https://kurdtv.org/api/public/hls?u=https%3A%2F%2Fstream.kurdmax.tv%2Fapp%2Fkurdmax-kurmanji2%2Fmedialist_917977731947844006_hls.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | JAZZIRA TV HD', url: 'https://live-hls-web-aja2-gcp.thehlive.com/AJA2/01.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | JAZZIRA TV HD 2', url: 'https://live-hls-apps-ajm2-fa.getaj.net/AJM2/01.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | STV OREMAR TV', url: 'https://lbgo.bozztv.com/ssh101/live/stv-oremar/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | Bahrain Sports 1', url: 'https://5c7b683162943.streamlock.net/live/sportsone/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | Bahrain Sports 2', url: 'https://5c7b683162943.streamlock.net/live/bahrainsportstwo/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | Bahrain TV', url: 'https://5c7b683162943.streamlock.net/live/bahraintvmain/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | Bahrain International', url: 'https://5c7b683162943.streamlock.net/live/bahraininternational/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | RANYA CITY TV', url: 'https://avr.host247.net/Ranya/RanyaCity/tracks-v1a1/mono.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | QELLAT TV HD', url: 'http://213.32.255.86:1935/live/Qellat_tv/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ARABIA TV HD', url: 'https://live.alarabiya.net/alarabiapublish/alarabiya.smil/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KELGA TV HD', url: 'https://lbgo.bozztv.com/ssh101/live/Kelga/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | RASHHED TV HD', url: 'https://media1.livaat.com/static/AL-RASHEED-HD/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ZAGROS TV HD', url: 'https://hlspackager.akamaized.net/live/DB/ZAGROS_TV/HLS/ZAGROS_TV.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | LD NUJEN TV', url: 'http://stap2025.me:8080/live/nsbp46qijx/ukbyu5668f/312666.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | DERIN TV HD', url: 'http://baskhd.ddns.net:40/live/Derin/playlist.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | BBC NEWS TV', url: 'https://vs-hls-push-ww-live.akamaized.net/x=4/i=urn:bbc:pips:service:bbc_news_channel_hd/t=3840/v=pv14/b=5070016/main.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | DUHOK TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129835.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KIRKUK TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/29289.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ASMAN TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280455.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | NRT 4 TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129975.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | MBC IRAQ TV', url: 'https://shd-gcp-live.edgenextcdn.net/live/bitmovin-mbc-iraq/e38c44b1b43474e1c39cb5b90203691e/index.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | ZAXO TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280432.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | XABIR TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/456279.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | QALLAM TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312553.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | NRT 2 TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129977.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | KANI TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/150570.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | DASINYA TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312579.m3u8', category: 'نووچە و گشتی'),
    Channel(name: 'KU | MINARA TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129888.m3u8', category: 'نووچە و گشتی'),

    // --- فیلم و دراما ---
    Channel(name: 'KU | BARIN MOVIES TV', url: 'https://cdn.karwan.tv/barin-movies/index.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | BARIN FAMILY TV', url: 'http://baskhd.ddns.net:40/live/BarinfamilyHD/mono.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NEW FAMILY TV', url: 'https://cdn.karwan.tv/bnar-family/index.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NEW MOVIES TV', url: 'https://cdn.karwan.tv/bnar-movies/index.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NEW ACTION TV', url: 'https://cdn.karwan.tv/bnar-action/index.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | ZHIN FILM TV', url: 'https://183.bozztv.com/giatv/giatv-zhintv/zhintv/playlist.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | MMN ART TV', url: 'http://mmn.mypsx.net:1935/live/mmnhdmovies/playlist.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | MMN ACTION TV', url: 'http://mmn.mypsx.net:1935/live/mmnhdaction/playlist.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | SPEDA DRAMA TV', url: 'https://www.speda2.site/upload/images/spedadrama.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'AR | BBC EARTH TV', url: 'https://amg00793-amg00793c6-xumo-us-2669.playouts.now.amagi.tv/BBCStudios-BBCEarthA-hls/playlist.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | ACTION HOLLYWOOD TV', url: 'https://cdn-apse1-prod.tsv2.amagi.tv/linear/amg01076-lightningintern-actionhollywood-samsungnz/playlist.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX ACTION HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487989.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX ACTION 2 HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487986.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX ACTION 3 HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487985.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX ANIME HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/488002.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX COMEDY HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487974.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX DRAMA 1 HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487994.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX DRAMA 2 HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487993.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NETFLIX KIDS HD', url: 'http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487967.m3u8', category: 'فیلم و دراما'),
    Channel(name: 'KU | NATURE TIME TV', url: 'https://amg00090-blueantmedia-naturetime-samsungse-axgcn.amagi.tv/playlist/amg00090-blueantmedia-naturetime-samsungse/playlist.m3u8', category: 'فیلم و دراما'),

    // --- زارۆکان ---
    Channel(name: 'KU | ZAROK TV KURMANJI', url: 'https://zindikurmanci.zaroktv.com.tr/hls/stream.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | ZAROK TV HD', url: 'https://zindisorani.zaroktv.com.tr/hls/0/stream.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | GEWHER KIDS TV', url: 'https://cdn.karwan.tv/gewher-kids/index.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | KIDCO TV HD', url: 'http://avrstream.com:1935/live/kidcohd/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | ZOOMOO TV HD', url: 'https://zoomoo-samsungau.amagi.tv/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | TOM AND JERRY TV', url: 'https://live20.bozztv.com/giatvplayout7/giatv-208314/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | RYAN AND FREINDS TV', url: 'https://ryanandfriends-samsungau.amagi.tv/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | ABC KIDS TV', url: 'https://c.mjh.nz/abc-kids.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | BABY SHARK TV', url: 'https://c0c65b821b3542c3a4dca92702f59944.mediatailor.us-east-1.amazonaws.com/v1/master/04fd913bb278d8775298c26fdca9d9841f37601f/RakutenTV-eu_BabySharkTV/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | MARAYA KIDS TV', url: 'https://live.kwikmotion.com/smckidslive/tjkids1.smil/smckidspublish/tjkids1_source/chunks.m3u8', category: 'زارۆکان'),
    Channel(name: 'AR | SPACETOON TV HD', url: 'https://live-uae-next.spacetoongo.com/ST_MENA_NEXT/hls/r9p2hjipmw2kl.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | MRBEAN TV HD', url: 'https://amg00627-amg00627c31-rakuten-fr-3991.playouts.now.amagi.tv/playlist/amg00627-banijayfast-mrbeanfrcc-rakutenfr/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | ZNAR KIDS TV', url: 'https://live20.bozztv.com/giatv/giatv-znarkids/znarkids/chunks.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | 3ABN KIDS TV', url: 'https://3abn.bozztv.com/3abn2/Kids_live/smil:Kids_live.smil/playlist.m3u8', category: 'زارۆکان'),
    Channel(name: 'KU | TAHA KIDS TV HD', url: 'https://stream.starmenajo.com/hls/app/live/ts:fhd.m3u8', category: 'زارۆکان'),

    // --- ئایینی ---
    Channel(name: 'KU | BANGAWAZ TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129958.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | AMOZHGARI TV HD', url: 'https://app-live.org/live/3268334b/index.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | ACADEMY AMOZHGARI TV', url: 'https://app-live.org/live/a267c1b3/index.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | EMAN TV HD', url: 'https://avr.host247.net/live/emantv/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | FARMOODA TV HD', url: 'https://avr.host247.net/live/FarmodaTV/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | WALLA QURAN TV', url: 'http://cdn.karwan.tv/WALAQURAN/index.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | IMK TV HD', url: 'http://imkhd.ddns.net:1935/live/imkhd/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | IMK QURAN TV', url: 'http://avrstream.com:1935/live/IMKQURANHD/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SPI QURAN TV', url: 'https://183.bozztv.com/giatv/giatv-spi_quran_hd/spi_quran_hd/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | MMN QURAN TV', url: 'http://mmn.mypsx.net:1935/live/mmnhdquran/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | ASHTI QURAN TV', url: 'http://avrstream.com:1935/live/AshtiTV/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | MIHRAB TV HD', url: 'http://baskhd.ddns.net:40/live/MihrabTV/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | MIHRAB FM HD', url: 'http://bblserver.ddns.net:1935/live/mihrabfm/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SOZ QURAN TV', url: 'http://live20.bozztv.com/giatv/giatv-sozquran/sozquran/chunks.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SOZ TV HD', url: 'https://live20.bozztv.com/giatv/giatv-sozetv/sozetv/chunks.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | RAWSHAN TV HD', url: 'http://rawshan.ddns.net:1935/live/rawshantv/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SAUDI QURAN TV', url: 'https://cdn-globecast.akamaized.net/live/eds/saudi_quran/hls_roku/index.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SAUDI SUNNAH TV', url: 'https://cdn-globecast.akamaized.net/live/eds/saudi_sunnah/hls_roku/index.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | ISLAMIC MEDIA LIVE 1', url: 'https://media2.streambrothers.com:1936/8122/8122/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | KSA QURAN RADIO', url: 'https://live.kwikmotion.com/sbrksaquranradiolive/srpksaquranradio/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | SUNNAH DENG', url: 'https://live20.bozztv.com/akamaissh101/ssh101/oneplussunnattv/chunks.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | Bahrain Quran', url: 'https://5c7b683162943.streamlock.net/live/bahrainquran/playlist.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | TASAWF TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280441.m3u8', category: 'ئایینی'),
    Channel(name: 'KU | QALLAM AYINI TV HD', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312672.m3u8', category: 'ئایینی'),

    // --- وەرزشی ---
    Channel(name: 'KU | GEWHER SPORT TV', url: 'https://cdn.karwan.tv/gewher-sport/index.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | MMN SPORT TV', url: 'http://mmn.mypsx.net:1935/live/mmnhdsport/playlist.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | IRAQIA SPORT', url: 'https://imn-live.esite-lab.com/hls/iraqia-sports-1.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | UFC TV HD', url: 'https://linear-893.frequency.stream/dist/xumo/893/hls/master/playlist.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DAZN 1 TV HD', url: 'http://50.7.120.34:8080/DAZN1/tracks-v1a1/mono.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DAZN 2 TV HD', url: 'http://23.237.104.106:8080/DAZN_2/tracks-v1a1/mono.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DAZN 3 TV HD', url: 'http://23.237.104.106:8080/DAZN_3/tracks-v1a1/mono.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DAZN 4 TV HD', url: 'http://23.237.104.106:8080/DAZN_4/tracks-v1a1/mono.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | ALWAN SPORT 1 TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/1641618.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | LD SPORT 1 TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/280502.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | NRT SPORT TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/280437.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | ASO SPORT TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/456256.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DUHOK SPORT TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/689913.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | DASINYA SPORT TV', url: 'http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/689911.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | ZAXO SPORT TV', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280431.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | ALWAN SPORT 2 TV', url: 'http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/1641619.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | BEIN SPORT 1 TV', url: 'http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/110.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | BEIN SPORT 2 TV', url: 'http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/111.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | BEIN SPORT 3 TV', url: 'http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/112.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | BEIN SPORT 4 TV', url: 'http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/113.m3u8', category: 'وەرزشی'),
    Channel(name: 'KU | BEIN SPORT 5 TV', url: 'http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/114.m3u8', category: 'وەرزشی'),

    // --- پەروەردەیی ---
    Channel(name: 'KU | PARWARDAYI SLEMANI TV', url: 'https://parwarda.unitedmixmedia.tv/Parwarda/tracks-v2a1/mono.m3u8', category: 'پەروەردەیی'),
    Channel(name: 'KU | PARWARDAYI DUHOK TV', url: 'https://parwarda.unitedmixmedia.tv/Parwardayi_Duhok/tracks-v2a1/mono.m3u8', category: 'پەروەردەیی'),
    Channel(name: 'KU | PARWARDAYI HEWLER TV', url: 'https://parwarda.unitedmixmedia.tv/Parwardayi_Hawler/tracks-v2a1/mono.m3u8', category: 'پەروەردەیی'),
  ];

  List<String> get categories => [
        'هەموو',
        'نووچە و گشتی',
        'فیلم و دراما',
        'زارۆکان',
        'ئایینی',
        'وەرزشی',
        'پەروەردەیی',
      ];

  @override
  Widget build(BuildContext context) {
    final filteredChannels = allChannels.where((channel) {
      final matchesCategory = selectedCategory == 'هەموو' || channel.category == selectedCategory;
      final matchesSearch = channel.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.live_tv, color: Color(0xFF3B82F6), size: 28),
            SizedBox(width: 10),
            Text(
              'KURDISTAN IPTV',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A1128),
        elevation: 6,
      ),
      body: Column(
        children: [
          // بەشی گەڕان (Search Box)
          Container(
            padding: const EdgeInsets.all(14.0),
            color: const Color(0xFF070E22),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'گەڕان ل ناڤ ١٧٧ کەناڵان...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF3B82F6)),
                filled: true,
                fillColor: const Color(0xFF101935),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // لیستی پۆلان (Categories Horizontal List)
          Container(
            height: 55,
            color: const Color(0xFF070E22),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: const Color(0xFF2563EB),
                    backgroundColor: const Color(0xFF101935),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (_) => setState(() => selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1, color: Color(0xFF1A264E)),

          // بەشی پیشاندانی کەناڵان (Grid View)
          Expanded(
            child: filteredChannels.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.tv_off, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text('هیچ کەناڵەک نەهاتە دیتن!', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2.3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredChannels.length,
                    itemBuilder: (context, index) {
                      final channel = filteredChannels[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(channel: channel),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 1),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            channel.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final Channel channel;
  const VideoPlayerScreen({super.key, required this.channel});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.channel.url),
      );

      await _videoPlayerController.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        isLive: true,
        allowFullScreen: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'خەلەت د پەخشکرنا ڤی کەناڵی دا هەیە!',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      );
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.channel.name),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.blueAccent),
                  SizedBox(height: 15),
                  Text('پەخش دهێتە بارکرن...', style: TextStyle(color: Colors.grey)),
                ],
              )
            : _errorMessage != null
                ? Text('ئاریشە هەی: $_errorMessage', style: const TextStyle(color: Colors.red))
                : _chewieController != null && _videoPlayerController.value.isInitialized
                    ? Chewie(controller: _chewieController!)
                    : const Text('پەخش نەهاتە دیتن', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
