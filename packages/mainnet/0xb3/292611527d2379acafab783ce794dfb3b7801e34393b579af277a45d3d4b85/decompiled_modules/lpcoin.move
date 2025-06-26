module 0xb3292611527d2379acafab783ce794dfb3b7801e34393b579af277a45d3d4b85::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 9, b"WAL-SUI Vault LPT", b"WAL-SUI Haedal Vault LP Token", b"Haedal Vault LP Token, WAL-SUI Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/_h1_8hbQ54gZiijV2RUUv1QzySZbeI2ptLYkJ5ogGkg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

