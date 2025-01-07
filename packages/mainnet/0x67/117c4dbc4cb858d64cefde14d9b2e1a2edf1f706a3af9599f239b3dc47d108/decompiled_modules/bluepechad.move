module 0x67117c4dbc4cb858d64cefde14d9b2e1a2edf1f706a3af9599f239b3dc47d108::bluepechad {
    struct BLUEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPECHAD>(arg0, 6, b"BLUEPECHAD", b"BLUE PEPE CHAD", b"PEPE CHAD SUI, the nex MILLION on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_E71_BC_11_F36_C_41_E5_A1_DF_D6_D0_DE_906_DD_0_bbfd1e5824.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

