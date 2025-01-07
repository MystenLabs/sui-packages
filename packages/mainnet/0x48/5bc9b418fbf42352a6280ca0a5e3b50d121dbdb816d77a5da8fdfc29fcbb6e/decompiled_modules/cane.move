module 0x485bc9b418fbf42352a6280ca0a5e3b50d121dbdb816d77a5da8fdfc29fcbb6e::cane {
    struct CANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANE>(arg0, 6, b"Cane", b"Cane Toad", b"Scientific name of aquarium toad ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Tgopp_DKY_Uw_Yu6_Rbfekotk6_En7s_Ac_Pdig_Sqd_Jxf_Zpz_Zq_ded337e683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

