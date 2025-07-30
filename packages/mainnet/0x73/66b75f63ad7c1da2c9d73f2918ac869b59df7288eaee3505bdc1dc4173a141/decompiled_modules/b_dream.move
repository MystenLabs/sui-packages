module 0x7366b75f63ad7c1da2c9d73f2918ac869b59df7288eaee3505bdc1dc4173a141::b_dream {
    struct B_DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DREAM>(arg0, 9, b"bDREAM", b"bToken DREAM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

