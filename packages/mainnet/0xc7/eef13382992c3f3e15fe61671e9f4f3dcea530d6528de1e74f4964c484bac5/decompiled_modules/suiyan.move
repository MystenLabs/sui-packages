module 0xc7eef13382992c3f3e15fe61671e9f4f3dcea530d6528de1e74f4964c484bac5::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"SUPER SUIYAN by SuiAI", b"It's the super $suiyan cycle ( https://linktr.ee/suiyan )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ge3_B_Np_Nb_UA_Ao_PO_0_43b54e7ef0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIYAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

