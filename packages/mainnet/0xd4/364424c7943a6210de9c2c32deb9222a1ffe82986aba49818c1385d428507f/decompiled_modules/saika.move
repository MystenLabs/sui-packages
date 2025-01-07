module 0xd4364424c7943a6210de9c2c32deb9222a1ffe82986aba49818c1385d428507f::saika {
    struct SAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIKA>(arg0, 6, b"SAIKA", b"Saika Kawakita with hat", b"Saika the Famous GIF on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAIKA_SANTA_c71b08fc3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

