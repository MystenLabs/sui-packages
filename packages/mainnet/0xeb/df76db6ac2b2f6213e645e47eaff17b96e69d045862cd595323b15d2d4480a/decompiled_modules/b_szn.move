module 0xebdf76db6ac2b2f6213e645e47eaff17b96e69d045862cd595323b15d2d4480a::b_szn {
    struct B_SZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SZN>(arg0, 9, b"bSZN", b"bToken SZN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

