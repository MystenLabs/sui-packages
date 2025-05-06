module 0x6a7b0935e77807ae8b2ad6b23165f89bae9f6fa886857e20113fe84b050c39f3::b_frtw {
    struct B_FRTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FRTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FRTW>(arg0, 9, b"bFRTW", b"bToken FRTW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FRTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FRTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

