module 0xb269f4c1b9686d590859bbc001b4e558cb87a998d2810b47ef97656d95901d97::b_sss {
    struct B_SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SSS>(arg0, 9, b"bSSS", b"bToken SSS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

