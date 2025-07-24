module 0x197dd48d294cdb2a86c335165fcf87f82175c792c2e1034904417e6271acc7a7::b_tao {
    struct B_TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TAO>(arg0, 9, b"bTAO", b"bToken TAO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

