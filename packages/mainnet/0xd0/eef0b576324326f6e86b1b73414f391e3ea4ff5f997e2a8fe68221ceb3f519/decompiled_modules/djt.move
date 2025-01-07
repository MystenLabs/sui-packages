module 0xd0eef0b576324326f6e86b1b73414f391e3ea4ff5f997e2a8fe68221ceb3f519::djt {
    struct DJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJT>(arg0, 6, b"DJT", b"DONALD J TRUMP", b"45Th President Of United States Of America ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000210575_992bdc8205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

