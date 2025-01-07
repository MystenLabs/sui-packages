module 0x11f592098be17d971e1a37d4bb5faa4cf2bdbd84e380846edf35a250255727d8::killthepet {
    struct KILLTHEPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLTHEPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLTHEPET>(arg0, 6, b"Killthepet", b"Swapxyinu", b"yoxd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i1541106051949927_34e5c47e76.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLTHEPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLTHEPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

