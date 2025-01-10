module 0xdcd2bcbb2bb12205038a38a63d67d40b0e1298684668bb14858c0671d46e2040::spunk {
    struct SPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNK>(arg0, 6, b"SPUNK", b"Sui Punk 2077", x"41492d64726976656e20506c6179324561726e20706c6174666f726d20776865726520796f7520636f6e71756572206d697373696f6e732c207261636b20757020726577617264732c20616e6420646f6d696e61746520746865206c6561646572626f61726420696e2061206675747572697374696320637962657270756e6b20756e6976657273652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_08_01_41_02_A_cartoonish_cyberpunk_character_portrait_The_character_is_a_young_tech_savvy_adventurer_with_spiky_blue_hair_and_a_neon_lit_visor_over_his_eyes_He_9127b7c745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

