module 0xea11304cea48065df1f30e31a298a2a913aac9f3d9ccb33ff857211c778ca0a::b_mc {
    struct B_MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MC>(arg0, 9, b"bMC", b"bToken MC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MC>>(v1);
    }

    // decompiled from Move bytecode v6
}

