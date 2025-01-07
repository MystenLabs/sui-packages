module 0x9842cb78cad51e842494048cd9d708e09e4fb7906237f851dbcc4727635a2570::ads {
    struct ADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADS>(arg0, 6, b"ads", b"asdh", b"2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"2"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADS>(&mut v2, 2000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

