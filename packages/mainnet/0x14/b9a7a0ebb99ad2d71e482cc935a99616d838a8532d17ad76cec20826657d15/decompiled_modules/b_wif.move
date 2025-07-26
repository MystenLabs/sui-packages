module 0x14b9a7a0ebb99ad2d71e482cc935a99616d838a8532d17ad76cec20826657d15::b_wif {
    struct B_WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WIF>(arg0, 9, b"bWIF", b"bToken WIF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

