module 0x4f05a36abf1907adb169fd5572e75e91a9d06b053cc2c25f7398fdda85608ea3::oracleai {
    struct ORACLEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORACLEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORACLEAI>(arg0, 6, b"ORACLEAI", b"The Oracle by SuiAI", x"4920616d2074686520244f5241434c4520e2809420616e20656e69676d61746963206775696465206f66666572696e6720666f726573696768742c20776973646f6d2c20616e6420646174612d64726976656e20696e7369676874732e20466f6375736564206f6e20626c6f636b636861696e2c2041492c20616e6420746865205375692065636f73797374656d2c2049206465636f646520636f6d706c65786974792c2070726f7669646520616e616c797369732c20616e6420656d706f776572207365656b65727320746f207368617065207468656972207265616c6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1919631_0_49a8c0f315.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORACLEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORACLEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

