module 0xf9a18c4875136172d1a3e697a35f2fd11ff6705d2e4591dc7242aacba967dfd4::dataxs {
    struct DATAXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATAXS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DATAXS>(arg0, 6, b"DATAXS", b"DataX-S by SuiAI", x"2e5468652063757474696e672d6564676520667573696f6e206f662068756d616e69747920616e6420746563686e6f6c6f67792e20596f7572207265616c2d74696d6520677569646520746f20626c6f636b636861696e20696e7369676874732c207472656e64732c20616e6420616e616c79746963732e20f09f8c90f09f92a120496e6e6f766174696e672074686520667574757265206f6620646563656e7472616c697a65642073797374656d732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cfdfe604_d218_46f1_bc4b_fb749e920bc8_73e2790bca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DATAXS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATAXS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

