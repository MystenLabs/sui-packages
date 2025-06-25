module 0xae0775fbe70b25466d75a2037c2488aa4bd644fb8700ded06c6f751824ffa734::b_asui {
    struct B_ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ASUI>(arg0, 9, b"baSUI", b"bToken aSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

