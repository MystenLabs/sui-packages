module 0x1b572a2680dc40de0deb18ca3f0e2fb3a966a89f796767fb0609a0a48678fd88::b_ads {
    struct B_ADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ADS>(arg0, 9, b"bADS", b"bToken ADS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ADS>>(v1);
    }

    // decompiled from Move bytecode v6
}

