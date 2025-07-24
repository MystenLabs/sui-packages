module 0x387256d80262c14f66ef2474bc8385962bc0e10e93db4b3497dbdf81d7910da::b_n0do {
    struct B_N0DO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_N0DO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_N0DO>(arg0, 9, b"bN0DO", b"bToken N0DO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_N0DO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_N0DO>>(v1);
    }

    // decompiled from Move bytecode v6
}

