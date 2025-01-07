module 0x29eb9cfb2fe7f32a97b7c80445d21540d61692b9a643ea03ac656cc4c348653a::entei {
    struct ENTEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTEI>(arg0, 6, b"ENTEI", b"Entei Sui", b"Along withSuicune, it is one of theLegendary beast said to be resurrected byHo-Ohon Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026601_8a24f61cdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENTEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

