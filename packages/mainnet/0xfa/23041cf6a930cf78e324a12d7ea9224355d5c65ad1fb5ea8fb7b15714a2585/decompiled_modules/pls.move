module 0xfa23041cf6a930cf78e324a12d7ea9224355d5c65ad1fb5ea8fb7b15714a2585::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 9, b"PLS", b"Pulsechain", b"Pulsechain Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.gopulsechain.com/files/LogoTransparent.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

