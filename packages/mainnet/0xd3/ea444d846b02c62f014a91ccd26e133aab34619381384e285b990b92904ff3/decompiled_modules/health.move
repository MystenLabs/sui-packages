module 0xd3ea444d846b02c62f014a91ccd26e133aab34619381384e285b990b92904ff3::health {
    struct HEALTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEALTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEALTH>(arg0, 6, b"HEALTH", b"DODGE HEALTH", x"436f6e636570743a2041206d656d6520636f696e2070726f6d6f74696e67206865616c746820616e642077656c6c6e65737320696e6974696174697665732c2077697468206120706f7274696f6e206f66207472616e73616374696f6e206665657320676f696e6720746f206865616c74682d72656c6174656420636861726974696573206f722072657365617263682e20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_03_59_05_A_playful_and_eye_catching_logo_for_a_meme_coin_named_Doge_Health_The_design_features_a_cartoon_dog_wearing_a_stethoscope_symbolizing_health_and_we_0b25048808.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEALTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEALTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

