module 0xf6027dbb05cbc4221b1fe1316bee4ca8a59fea7a8fc5481d14ce8c5298910120::jbag {
    struct JBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBAG>(arg0, 6, b"JBAG", b"JellyBag", x"48656c6c6f2c2065766572796f6e652120496d204a656c6c794261672066726f6d20746865206465657065737420636f726e657273206f6620746865206f6365616e2e204920646f6e742062656c6f6e6720686572652e2041207473756e616d6920686173206a75737420737461727465642c20616e64206269672077617665732061726520636f6d696e672e20506c656173652073706974206d65206f7574206f6e746f20746865206c616e6420617320796f7520706173732062792e200a285765627369746520736f6f6e2129", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_17_22_15_51_A_detailed_and_centered_cartoon_character_that_looks_like_a_jellyfish_but_is_clearly_made_of_a_plastic_bag_symbolizing_an_environmental_movement_agai_vmake_9_ccaf842774.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

