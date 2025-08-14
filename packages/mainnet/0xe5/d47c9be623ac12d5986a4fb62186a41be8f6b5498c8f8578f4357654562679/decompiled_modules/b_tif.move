module 0xe5d47c9be623ac12d5986a4fb62186a41be8f6b5498c8f8578f4357654562679::b_tif {
    struct B_TIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TIF>(arg0, 9, b"bTIF", b"bToken TIF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

