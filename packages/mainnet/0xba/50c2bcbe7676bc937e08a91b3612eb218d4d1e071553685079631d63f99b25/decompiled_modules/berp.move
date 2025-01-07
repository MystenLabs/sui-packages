module 0xba50c2bcbe7676bc937e08a91b3612eb218d4d1e071553685079631d63f99b25::berp {
    struct BERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERP>(arg0, 6, b"BERP", b"BERP SUI", b"Derp memecoins are a playful and humorous category of cryptocurrencies inspired by internet memes and characterized by their light-hearted nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeu_Lr_N_Kcxe_GN_Bzguhu_D2_Djo_T_Kch8_Hcc_Wrc_Dk_Zi_Eh_No_Z7b_78c0145528.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

