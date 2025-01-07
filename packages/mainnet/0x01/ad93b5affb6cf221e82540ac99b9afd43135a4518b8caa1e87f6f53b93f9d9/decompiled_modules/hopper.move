module 0x1ad93b5affb6cf221e82540ac99b9afd43135a4518b8caa1e87f6f53b93f9d9::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"HopperRabbit", b"It's just a hopper rabbit on the turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000665296.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

