module 0x484a9162669957e1c1883fc2da59e3cce9afdc1eec3c72c983898dbc9e92b91::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 6, b"haSUI-USDC Vault LPT", b"haSUI-USDC Haedal Vault LP Token", b"Haedal Vault LP Token, haSUI-USDC Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/uPsVdR-uVDtGW-FMwvSm4PV123RnHBzAYb2S9nO923E")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

