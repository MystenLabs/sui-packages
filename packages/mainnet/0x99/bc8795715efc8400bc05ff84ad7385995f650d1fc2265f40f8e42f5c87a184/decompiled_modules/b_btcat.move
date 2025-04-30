module 0x99bc8795715efc8400bc05ff84ad7385995f650d1fc2265f40f8e42f5c87a184::b_btcat {
    struct B_BTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BTCAT>(arg0, 9, b"bBTCat", b"bToken BTCat", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

