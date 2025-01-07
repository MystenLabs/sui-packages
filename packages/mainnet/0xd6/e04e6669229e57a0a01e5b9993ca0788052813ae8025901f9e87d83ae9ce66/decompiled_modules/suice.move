module 0xd6e04e6669229e57a0a01e5b9993ca0788052813ae8025901f9e87d83ae9ce66::suice {
    struct SUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICE>(arg0, 6, b"SUICE", b"SUI SUICE", b"GOT THAT SUICE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_25_20_49_28_A_soy_sauce_bottle_with_the_logo_Sui_Suice_in_blue_incorporating_the_SUI_crypto_chain_logo_prominently_on_the_label_and_cap_The_bottle_itself_is_s_399af1d0c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

