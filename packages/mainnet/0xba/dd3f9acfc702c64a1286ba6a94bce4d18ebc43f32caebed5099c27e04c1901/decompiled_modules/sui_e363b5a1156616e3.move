module 0xbadd3f9acfc702c64a1286ba6a94bce4d18ebc43f32caebed5099c27e04c1901::sui_e363b5a1156616e3 {
    struct SUI_E363B5A1156616E3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_E363B5A1156616E3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_E363B5A1156616E3>(arg0, 0, b"SUI", b"sui", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788191377320-c3a62bda-2166-4c56-9b19-35db1fd9a148.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_E363B5A1156616E3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_E363B5A1156616E3>>(0x2::coin::mint<SUI_E363B5A1156616E3>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_E363B5A1156616E3>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

