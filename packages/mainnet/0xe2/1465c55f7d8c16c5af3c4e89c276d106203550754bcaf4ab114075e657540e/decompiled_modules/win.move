module 0xe21465c55f7d8c16c5af3c4e89c276d106203550754bcaf4ab114075e657540e::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 9, b"WIN", b"WinX", b"Licensed Casino with no KYC & Instant Cash Out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchpad.turbos.finance/wintoken.254e43002babf5b30d3151a09cb56115.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WIN>>(0x2::coin::mint<WIN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

