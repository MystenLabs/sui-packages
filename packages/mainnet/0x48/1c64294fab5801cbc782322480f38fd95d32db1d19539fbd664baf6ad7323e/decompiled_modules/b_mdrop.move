module 0x481c64294fab5801cbc782322480f38fd95d32db1d19539fbd664baf6ad7323e::b_mdrop {
    struct B_MDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MDROP>(arg0, 9, b"bMDROP", b"bToken MDROP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

