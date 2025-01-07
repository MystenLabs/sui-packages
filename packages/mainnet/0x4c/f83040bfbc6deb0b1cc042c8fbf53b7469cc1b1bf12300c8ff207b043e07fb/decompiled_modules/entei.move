module 0x4cf83040bfbc6deb0b1cc042c8fbf53b7469cc1b1bf12300c8ff207b043e07fb::entei {
    struct ENTEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTEI>(arg0, 6, b"ENTEI", b"Entei", b"Along withSuicune, it is one of theLegendary beast said to be resurrected byHo-Ohon Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026601_259e7a8fb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENTEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

