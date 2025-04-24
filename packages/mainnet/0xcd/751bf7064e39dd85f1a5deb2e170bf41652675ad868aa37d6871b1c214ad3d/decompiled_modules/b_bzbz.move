module 0xcd751bf7064e39dd85f1a5deb2e170bf41652675ad868aa37d6871b1c214ad3d::b_bzbz {
    struct B_BZBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BZBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BZBZ>(arg0, 9, b"bBZBZ", b"bToken BZBZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BZBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BZBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

