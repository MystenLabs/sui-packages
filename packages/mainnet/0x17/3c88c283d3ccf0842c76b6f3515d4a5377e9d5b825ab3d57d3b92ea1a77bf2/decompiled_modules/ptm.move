module 0x173c88c283d3ccf0842c76b6f3515d4a5377e9d5b825ab3d57d3b92ea1a77bf2::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 6, b"PTM", b"PHANTOM SUI COIN", b"PHANTOM X SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_pxs1_9da7c260e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

