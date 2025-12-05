module 0x54e4dcc064c3d0089ed8868412b8ed9d4757e547724f9906cab8b6f8d64025d3::mockcoin {
    struct MOCKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKCOIN>(arg0, 9, b"USDTmd", b"USDTmd", b"Mock USDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.iotaspam.io/7.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCKCOIN>>(0x2::coin::mint<MOCKCOIN>(&mut v2, 5000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

