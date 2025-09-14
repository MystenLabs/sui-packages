module 0xf1880cac25e35736a1224c46fc6c365f902324be8f38687e96bef3f11fcdc29d::b_euro {
    struct B_EURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EURO>(arg0, 9, b"bEURO", b"bToken EURO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

