module 0xdd61ff0ab011b9fbdd267ff49efa416bf61247826c7ab1aa2deb65c07a61f701::b_ikamdrop {
    struct B_IKAMDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_IKAMDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_IKAMDROP>(arg0, 9, b"bIKAMDROP", b"bToken IKAMDROP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_IKAMDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_IKAMDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

