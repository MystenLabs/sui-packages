module 0xcd2dfadc7683108f1d88f9beddee2bd33a3c94892fe9f4679d6a430188444248::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 9, 0x1::string::utf8(b"WAL-SUI Vault LPT"), 0x1::string::utf8(b"WAL-SUI Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, WAL-SUI Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/_h1_8hbQ54gZiijV2RUUv1QzySZbeI2ptLYkJ5ogGkg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

