module 0xd62adfa1e4980099fe029b1edd2f89c6279b9c177a29ab105b40c33e7374b861::borca {
    struct BORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORCA>(arg0, 6, b"BORCA", b"BLUE ORCA", b"Surfing the waves of innovation, our blue orca brings big moves and even bigger smiles to the crypto ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_18_20_36_30_A_vibrant_and_whimsical_illustration_of_a_blue_orca_riding_ocean_waves_designed_to_be_used_as_a_profile_picture_for_a_crypto_project_The_orca_is_dyn_ace89f87e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

