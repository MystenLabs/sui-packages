module 0xd3f193f48891f35ba8491c1885bc7e532da833f7820932c2fc6c382baf597bda::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", b"Inspired by the legendary Sonic, Suinic is swift and full of energy, speeding through blocks and transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_15_25_14_Create_an_image_similar_to_the_one_provided_featuring_a_character_inspired_by_Sonic_for_a_token_called_Suinic_The_character_should_be_dynamic_pla_29ddf8d9e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

