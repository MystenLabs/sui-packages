module 0x1ed610fcd5a8a60dc1b660f771fd35f998efe1469a36828f12eee2c82b4589ab::aaafish {
    struct AAAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFISH>(arg0, 6, b"aaaFish", b"aaa fish", b"Can't stop won't stop (thinking about Sui) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_0d1117c6bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

