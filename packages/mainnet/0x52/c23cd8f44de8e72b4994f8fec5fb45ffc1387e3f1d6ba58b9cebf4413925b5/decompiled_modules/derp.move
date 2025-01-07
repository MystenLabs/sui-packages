module 0x52c23cd8f44de8e72b4994f8fec5fb45ffc1387e3f1d6ba58b9cebf4413925b5::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"DERPSUI", b"Derp memecoins are a playful and humorous category of cryptocurrencies inspired by internet memes and characterized by their light-hearted nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeu_Lr_N_Kcxe_GN_Bzguhu_D2_Djo_T_Kch8_Hcc_Wrc_Dk_Zi_Eh_No_Z7b_6ce8f5db77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

