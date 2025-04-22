module 0xd49ced279c227ed6bbb8ecb1e48e57ac40ede250497676e47c12763135cd898d::vcxv {
    struct VCXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCXV>(arg0, 9, b"VCXV", b"cvxv", b"dsfgsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCXV>>(v1);
    }

    // decompiled from Move bytecode v6
}

