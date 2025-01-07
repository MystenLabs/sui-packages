module 0x472699f5360721ff5c1411e7d69c943e80da3f55efe0b9743331a6d02afec3e0::sui690o {
    struct SUI690O has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI690O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI690O>(arg0, 6, b"SUI690O", b"SUI69O0", b"ticker: Sui690O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af8284e70a6abf864deb123ab05c8dc_aed1ed394a_e7ca093dc6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI690O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI690O>>(v1);
    }

    // decompiled from Move bytecode v6
}

