module 0x455632cca4fda8e17d908fec553229ffc7d5281a5279d4b017651bcea67f662e::case {
    struct CASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASE>(arg0, 6, b"CASE", b"SUItcase", b"Suitcase is very well", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B28338_E8_BEEB_4_F0_E_AB_9_D_C1_BBAB_4_CE_010_11491069b2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

