module 0xab947a13d0fd8e4aa3b9c1aeb2736fa5343932ba46f741297a485af8bad1e657::nikkei {
    struct NIKKEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKKEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKKEI>(arg0, 6, b"Nikkei", b"JPX Nikkei 777", b"Introducing JPX Nikkei 777, a memecoin that draws its inspiration from the rich tapestry of Japanese mythology, specifically echoing the revered status of the number seven through its connection to the Seven Gods of Fortune. In Japanese culture, the number seven holds a special significance, often symbolizing luck, prosperity, and cosmic order. This is reflected in various aspects of life, from the seven musical notes to the seven days of the week, and most notably, in the Shichi Fukujin, or Seven Gods of Fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_10_28_13_d3001a7698.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKKEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKKEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

