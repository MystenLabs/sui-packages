module 0xcbc377267d5c359be1b02a83fc813cb16a53d0747220cb1b61e7d10414079261::bstd {
    struct BSTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSTD>(arg0, 6, b"BSTD", b"BABY SUITARD", x"53756974617264202d20697320746865206d656d65636f696e206f6e207375692074686174206d6164652034305820666f72206f6e65206461792e200a426162792053756974617264202d20746869732069732068697320626162792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABY_SUITARD_91461fc67c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

