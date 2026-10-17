import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,
  ]);
  runApp(const KurdistanApp());
}
class Channel {
  final String name, url, category;
  const Channel(this.name,this.url,this.category);
}
const channels=<Channel>[
 Channel('RUDAW TV','https://live.rudaw.net/hls/rudaw-tv/master.m3u8','News'),
 Channel('AVA MEDIA TV','https://ava002.xyz/upload/images/1080.m3u8','General'),
 Channel('KURDISTAN 24 TV','https://hlspackager.akamaized.net/live/DB/K24/HLS/K24.m3u8','News'),
 Channel('SPEDA TV HD','https://www.speda2.site/upload/images/spedahd.m3u8','General'),
 Channel('GALI KURDISTAN TV','https://live.host247.net/gk/gksat/chunklist_w1879482920.m3u8','General'),
 Channel('KURDSAT NEWS TV','https://hlspackager.akamaized.net/live/DB/KURDSAT_NEWS/HLS/KURDSAT_NEWS.m3u8','News'),
 Channel('NUÇÊ TV','https://hlspackager.akamaized.net/live/DB/NU_TV/HLS/NU_TV.m3u8','News'),
 Channel('NRT TV HD','https://hlspackager.akamaized.net/live/DB/NRT_HD/HLS/NRT_HD-avc1_2500000=10002,mp4a_128000=20000.m3u8','News'),
 Channel('CHANNEL 8','https://live.channel8.com/Channel8-Kurdish/index.m3u8','General'),
 Channel('MMN NEWS TV','http://mmn.mypsx.net:1935/live/mmnhdnews/playlist.m3u8','News'),
 Channel('AFARIN TV HD','https://65f16f0fdfc51.streamlock.net/afarinTV/livestream/chunklist_w187911945.m3u8','General'),
 Channel('KURDISTAN TV HD','https://5a3ed7a72ed4b.streamlock.net/live/SMIL:myStream.smil/playlist.m3u8','General'),
 Channel('SHAR TV HD','http://avrstream.com:1935/live/SHARTV/playlist.m3u8','General'),
 Channel('AVAR TV HD','https://avr.host247.net/live/AvarTv/playlist.m3u8','General'),
 Channel('KURDSAT TV HD','https://hlspackager.akamaized.net/live/DB/KURDSAT_HD/HLS/KURDSAT_HD.m3u8','General'),
 Channel('WELAT TV HD','https://stream.badinan.xyz/welat/tv/playlist.m3u8','General'),
 Channel('BASK TV HD','http://baskhd.ddns.net:40/live/baskhd/playlist.m3u8','General'),
 Channel('EURO KURD TV','http://baskhd.ddns.net:40/live/Eurokurd/index.m3u8','General'),
 Channel('GK+ TV HD','https://live.host247.net/gk/gkplus/playlist.m3u8','General'),
 Channel('PESHANG TV HD','https://stream.forcaroo.com/stream/hls/desktop.m3u8','General'),
 Channel('RED TV HD','http://avrstream.com:1935/live/REDTV/playlist.m3u8','General'),
 Channel('KURD7 TV HD','http://avrstream.com:1935/live/Kurd7HD/playlist.m3u8','General'),
 Channel('GEWHER TV HD','https://cdn.karwan.tv/gewher-tv/index.m3u8','General'),
 Channel('AVA FAMILY TV','https://familyhls.avatv.live/hls/stream.m3u8','Family'),
 Channel('BARIN MOVIES TV','https://cdn.karwan.tv/barin-movies/index.m3u8','Movies'),
 Channel('NEW FAMILY TV','https://cdn.karwan.tv/bnar-family/index.m3u8','Family'),
 Channel('NEW MOVIES TV','https://cdn.karwan.tv/bnar-movies/index.m3u8','Movies'),
 Channel('ZAROK TV HD','https://zindisorani.zaroktv.com.tr/hls/0/stream.m3u8','Kids'),
 Channel('GEWHER KIDS TV','https://cdn.karwan.tv/gewher-kids/index.m3u8','Kids'),
 Channel('WALLA QURAN TV','http://cdn.karwan.tv/WALAQURAN/index.m3u8','Religion'),
 Channel('GEWHER SPORT TV','https://cdn.karwan.tv/gewher-sport/index.m3u8','Sports'),
 Channel('QATAR TV HD','https://qatartv.akamaized.net/hls/live/20000609/qtv1/master.m3u8','Arabic'),
 Channel('ZAGROS 24 TV HD','https://hlspackager.akamaized.net/live/DB/ZAGROS_24/HLS/ZAGROS_24.m3u8','News'),
 Channel('BBC EARTH TV','https://amg00793-amg00793c6-xumo-us-2669.playouts.now.amagi.tv/BBCStudios-BBCEarthA-hls/playlist.m3u8','Documentary'),
 Channel('TRT KURDI TV','https://tv-trtkurdi.medya.trt.com.tr/master.m3u8','General'),
 Channel('SKY NEWS TV','https://stream.skynewsarabia.com/hls/sna.m3u8','News'),
 Channel('CNN TV HD','https://turnerlive.warnermediacdn.com/hls/live/586495/cnngo/cnn_slate/VIDEO_0_3564000.m3u8','News'),
 Channel('IRAQIA KURDISH','https://imn-live.esite-lab.com/hls/iraqia-kurdish.m3u8','News'),
 Channel('IRAQIA NEWS','https://imn-live.esite-lab.com/hls/iraqia-news.m3u8','News'),
 Channel('IRAQIA SPORT','https://imn-live.esite-lab.com/hls/iraqia-sports-1.m3u8','Sports'),
 Channel('JAZZIRA TV HD','https://live-hls-web-aja2-gcp.thehlive.com/AJA2/01.m3u8','News'),
 Channel('Bahrain TV','https://5c7b683162943.streamlock.net/live/bahraintvmain/playlist.m3u8','Arabic'),
 Channel('MBC IRAQ TV','https://shd-gcp-live.edgenextcdn.net/live/bitmovin-mbc-iraq/e38c44b1b43474e1c39cb5b90203691e/index.m3u8','Arabic'),
 Channel('DUHOK TV HD','http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129835.m3u8','General'),
 Channel('KIRKUK TV HD','http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/29289.m3u8','General'),
];
class KurdistanApp extends StatelessWidget {
 const KurdistanApp({super.key});
 @override Widget build(BuildContext context)=>MaterialApp(
  debugShowCheckedModeBanner:false,title:'KURDISTAN IPTV',
  theme:ThemeData(useMaterial3:true,brightness:Brightness.dark,
   scaffoldBackgroundColor:const Color(0xFF070D18),
   colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFFFFC928),brightness:Brightness.dark)),
  home:const Home());
}
class Home extends StatefulWidget {const Home({super.key}); @override State<Home> createState()=>_HomeState();}
class _HomeState extends State<Home>{
 String category='All',query='';
 final cats=['All','News','General','Sports','Movies','Kids','Religion','Arabic','Family','Documentary'];
 @override Widget build(BuildContext context){
  final list=channels.where((c)=>(category=='All'||c.category==category)&&c.name.toLowerCase().contains(query.toLowerCase())).toList();
  return Scaffold(appBar:AppBar(title:const Text('KURDISTAN IPTV',style:TextStyle(fontWeight:FontWeight.w900)),backgroundColor:const Color(0xFF0B1424),
   actions:[IconButton(onPressed:()=>showSearch(context:context,delegate:SearchChannels(channels)).then((v){if(v!=null)setState(()=>query=v);}),icon:const Icon(Icons.search))]),
   body:Column(children:[
    Container(margin:const EdgeInsets.all(14),padding:const EdgeInsets.all(18),width:double.infinity,
     decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[Color(0xFF123A68),Color(0xFF111B30),Color(0xFF5C4210)])),
     child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text('LIVE TV • KURDISTAN',style:TextStyle(color:Color(0xFFFFD54F),fontWeight:FontWeight.bold)),
      SizedBox(height:8),Text('هەموو کەناڵەکان لە یەک شوێن',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
      Text('Kurdish • Arabic • Live HLS',style:TextStyle(color:Colors.white70))])),
    SizedBox(height:42,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:12),
     children:cats.map((c)=>Padding(padding:const EdgeInsets.only(right:8),child:ChoiceChip(label:Text(c),selected:category==c,onSelected:(_)=>setState(()=>category=c)))).toList())),
    Padding(padding:const EdgeInsets.all(14),child:Row(children:[const Text('LIVE CHANNELS',style:TextStyle(fontWeight:FontWeight.bold)),const Spacer(),Text('${list.length} channels')])),
    Expanded(child:LayoutBuilder(builder:(context,box)=>GridView.builder(padding:const EdgeInsets.all(12),
     gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:box.maxWidth>600?3:2,childAspectRatio:1.55,crossAxisSpacing:10,mainAxisSpacing:10),
     itemCount:list.length,itemBuilder:(context,i){final c=list[i];return InkWell(borderRadius:BorderRadius.circular(18),
      onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>PlayerPage(channel:c))),
      child:Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:const Color(0xFF101B2D),borderRadius:BorderRadius.circular(18),border:Border.all(color:const Color(0xFF23334B))),
       child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:const Color(0xFFFFD54F),borderRadius:BorderRadius.circular(12)),child:const Icon(Icons.live_tv,color:Color(0xFF101827))),const Spacer(),const Icon(Icons.circle,color:Colors.redAccent,size:8),const SizedBox(width:4),const Text('LIVE',style:TextStyle(color:Colors.redAccent,fontSize:10))]),
        const Spacer(),Text(c.name,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:12)),
        Text(c.category.toUpperCase(),style:const TextStyle(color:Color(0xFFFFD54F),fontSize:9))])) ;})))
   ]));
 }
}
class SearchChannels extends SearchDelegate<String>{
 final List<Channel> items;SearchChannels(this.items);
 @override List<Widget>? buildActions(BuildContext c)=>[IconButton(onPressed:()=>query='',icon:const Icon(Icons.clear))];
 @override Widget? buildLeading(BuildContext c)=>IconButton(onPressed:()=>close(c,''),icon:const Icon(Icons.arrow_back));
 @override Widget buildResults(BuildContext c)=>_results();
 @override Widget buildSuggestions(BuildContext c)=>_results();
 Widget _results()=>ListView(children:items.where((e)=>e.name.toLowerCase().contains(query.toLowerCase())).map((e)=>ListTile(title:Text(e.name),onTap:()=>close(context,query))).toList());
}
class PlayerPage extends StatefulWidget{final Channel channel;const PlayerPage({super.key,required this.channel});@override State<PlayerPage> createState()=>_PlayerPageState();}
class _PlayerPageState extends State<PlayerPage>{
 VideoPlayerController? player;String? error;
 @override void initState(){super.initState();_start();}
 Future<void> _start()async{try{final p=VideoPlayerController.networkUrl(Uri.parse(widget.channel.url));player=p;await p.initialize();await p.play();if(mounted)setState((){});}catch(_){if(mounted)setState(()=>error='کەناڵەکە کار ناکات یان لینکی پەخش گۆڕاوە.');}}
 @override void dispose(){player?.dispose();super.dispose();}
 @override Widget build(BuildContext context){final p=player;return Scaffold(appBar:AppBar(title:Text(widget.channel.name),actions:[IconButton(icon:const Icon(Icons.screen_rotation),onPressed:()async{final land=MediaQuery.of(context).orientation==Orientation.portrait;await SystemChrome.setPreferredOrientations(land?[DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]:[DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);})]),
 body:Column(children:[AspectRatio(aspectRatio:16/9,child:Container(color:Colors.black,child:error!=null?Center(child:Text(error!,textAlign:TextAlign.center)):p==null||!p.value.isInitialized?const Center(child:CircularProgressIndicator()):Stack(alignment:Alignment.center,children:[AspectRatio(aspectRatio:p.value.aspectRatio,child:VideoPlayer(p)),IconButton(iconSize:58,icon:Icon(p.value.isPlaying?Icons.pause_circle:Icons.play_circle),onPressed:()=>setState(()=>p.value.isPlaying?p.pause():p.play()))]))),
 ListTile(leading:const Icon(Icons.circle,color:Colors.red,size:12),title:Text(widget.channel.name),subtitle:Text('${widget.channel.category} • LIVE'))]));}
}