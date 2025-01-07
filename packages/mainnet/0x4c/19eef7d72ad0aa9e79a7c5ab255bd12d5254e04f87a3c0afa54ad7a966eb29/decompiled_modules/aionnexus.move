module 0x4c19eef7d72ad0aa9e79a7c5ab255bd12d5254e04f87a3c0afa54ad7a966eb29::aionnexus {
    struct AIONNEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIONNEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIONNEXUS>(arg0, 6, b"AIOnNexus", b"AION", b"AION is an innovative token built on the Sui blockchain, designed to drive the deep integration of AI technology and blockchain. The core narrative of AION revolves around \"AI Empowering the Future,\" providing developers, innovators, and creators with a decentralized", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_28_16_13_56_A_logo_design_for_the_AION_AI_On_Nexus_token_representing_the_fusion_of_AI_technology_and_blockchain_The_logo_should_have_a_sleek_modern_look_wit_ffd7afea17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIONNEXUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIONNEXUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

