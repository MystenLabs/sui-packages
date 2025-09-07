module 0x977778d3075f10dbf795990111d7dfd7c268e6dbde909505a2a8a5eb347ce201::b_stsui {
    struct B_STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STSUI>(arg0, 9, b"bstSUI", b"bToken stSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

