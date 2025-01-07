module 0x462cd57c345b68f8580e695aef950395318325d09f1a148183e8a7d31c8bebd8::usui {
    struct USUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUI>(arg0, 6, b"USUI", b"Eagle USUI", x"636f6d65206a6f696e20757320696e20746865206c6172676573742053756920636f6d6d756e6974790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013480_94e9743ac9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

