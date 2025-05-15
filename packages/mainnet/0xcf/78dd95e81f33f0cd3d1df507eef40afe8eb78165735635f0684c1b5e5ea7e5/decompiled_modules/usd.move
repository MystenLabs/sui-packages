module 0xcf78dd95e81f33f0cd3d1df507eef40afe8eb78165735635f0684c1b5e5ea7e5::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 9, b"USD", b"USDx", b"USD Stablecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.seeklogo.com/logo-png/32/1/tether-usdt-logo-png_seeklogo-323175.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USD>>(v1);
    }

    // decompiled from Move bytecode v6
}

