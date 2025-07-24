module 0x86aed1d889e69242f6f59ae4a9561f02ec0443b30a46be2c333cfbf5f6d037ef::b_uncbot {
    struct B_UNCBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UNCBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UNCBOT>(arg0, 9, b"bUNCBOT", b"bToken UNCBOT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UNCBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UNCBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

