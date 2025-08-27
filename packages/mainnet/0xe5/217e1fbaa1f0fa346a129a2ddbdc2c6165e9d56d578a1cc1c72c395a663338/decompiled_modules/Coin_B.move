module 0xe5217e1fbaa1f0fa346a129a2ddbdc2c6165e9d56d578a1cc1c72c395a663338::Coin_B {
    struct COIN_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_B>(arg0, 9, b"COINB", b"Coin B", b"Coin B Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3PGW70HCMYVX40SFDEN2VA0.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_B>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

