module 0x5419311d2a17447ea1a3cf909bef16cf73979651e1dd4194f0c6a2f2edebc5b2::bite {
    struct BITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITE>(arg0, 6, b"BITE", b"BITE.", x"496d6167696e652074686520736861726b20696e207468652063727970746f2e204e6f7720796f7520776f756c64206e6f742c2062656361757365206974e28099732024424954452074696d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731274874976.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

