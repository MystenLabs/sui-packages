module 0xf05a696f35af0a608cd20fd06396073d309decb9c4d5d5a0f9c0e8d7331f1d88::b_par {
    struct B_PAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAR>(arg0, 9, b"bPAR", b"bToken PAR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

