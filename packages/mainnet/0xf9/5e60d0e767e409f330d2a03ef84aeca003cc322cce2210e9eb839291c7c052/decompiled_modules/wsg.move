module 0xf95e60d0e767e409f330d2a03ef84aeca003cc322cce2210e9eb839291c7c052::wsg {
    struct WSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSG>(arg0, 6, b"WSG", b"WAL Staking Guy", x"546f7373696e67206669736820696e746f20686973206d6f757468206c696b652074686f756768747320696e746f2074686520636861696e2c0a686520646f65736ee2809974206d6f766520666173742c20686520646f65736ee2809974206e65656420746f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743873162888.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

