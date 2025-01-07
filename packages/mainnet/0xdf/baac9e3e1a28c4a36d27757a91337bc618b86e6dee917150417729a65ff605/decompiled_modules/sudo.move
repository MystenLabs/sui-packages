module 0xdfbaac9e3e1a28c4a36d27757a91337bc618b86e6dee917150417729a65ff605::sudo {
    struct SUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDO>(arg0, 6, b"SUDO", b"Sui Dolphin", b"SuDo, the swift and friendly token, brings agility and charm to the SUI blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_29_22_56_36_A_3_D_animated_cartoon_style_depiction_of_a_dolphin_designed_as_a_mascot_for_a_cryptocurrency_The_dolphin_has_a_cheerful_and_friendly_expression_wit_56cae02747.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

