module 0xee240ae76f05fb4e15aee9830d84f85b94bf904094c54c580a216b3abdba49c9::b_oak {
    struct B_OAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OAK>(arg0, 9, b"bOAK", b"bToken OAK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

