module 0x59c759fb7f138388fa1dba19685f3b24c5bb191f5db773b0999b8319012a97ad::pacu_jalur {
    struct PACU_JALUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACU_JALUR, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 823 || 0x2::tx_context::epoch(arg1) == 824, 1);
        let (v0, v1) = 0x2::coin::create_currency<PACU_JALUR>(arg0, 9, b"PAJL", b"Pacu Jalur", b"Pacu jalur is a traditional rowing boat racing tradition originating from Riau Province, Indonesia. This tradition is usually held in celebration of major holidays or specific cultural events. In pacu jalur, the boats used have a special and elongated design, and are equipped with a crew consisting of rowers and a helmsman. The speed and strength of the rowers are crucial in reaching the finish line first. Pacu jalur is not just a competition, but also embodies cultural values such as teamwork, cooperation, and the preservation of traditions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmYYsNEZPxFXMTNK4YsLquS9EuBzWkjZZdTCnFPFJh3f6M"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PACU_JALUR>(&mut v2, 1000000000000000000, @0x48aa9f9495a5c3cefa6c63ba5f530e3a8833297d2fa3d23a346f26b74369a6f5, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACU_JALUR>>(v2, @0x48aa9f9495a5c3cefa6c63ba5f530e3a8833297d2fa3d23a346f26b74369a6f5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PACU_JALUR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

