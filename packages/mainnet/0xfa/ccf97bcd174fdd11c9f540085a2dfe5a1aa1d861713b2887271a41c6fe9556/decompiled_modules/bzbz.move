module 0xfaccf97bcd174fdd11c9f540085a2dfe5a1aa1d861713b2887271a41c6fe9556::bzbz {
    struct BZBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZBZ>(arg0, 9, b"BZBZ", b"bzbz", b"zbzb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

