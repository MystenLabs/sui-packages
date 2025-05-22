module 0x11a0770501522ed67b5b879fe04159ec7d92c6ee050137eabfdb1339d56dd743::b_wwal {
    struct B_WWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WWAL>(arg0, 9, b"bwWAL", b"bToken wWAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

