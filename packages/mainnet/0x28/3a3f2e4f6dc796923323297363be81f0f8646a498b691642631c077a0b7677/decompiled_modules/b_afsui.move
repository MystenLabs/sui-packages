module 0x283a3f2e4f6dc796923323297363be81f0f8646a498b691642631c077a0b7677::b_afsui {
    struct B_AFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AFSUI>(arg0, 9, b"bAFSUI", b"bToken AFSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

