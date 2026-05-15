module 0x982962b6d694238acfbbf21e817b907124892bd1ff1ed2c7ae2e324230b327be::b_golda {
    struct B_GOLDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GOLDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GOLDA>(arg0, 9, b"bGOLDA", b"bToken GOLDA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GOLDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GOLDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

