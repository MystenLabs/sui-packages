module 0x30287a68f1ea10ca36ad89331a3787e9092d305dccf965b8a4b0feeb81b93d16::sow {
    struct SOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOW>(arg0, 6, b"SOW", b"SOWELIE", x"546865207265616c20536f77656c6965206f6e20245355490a57616e6e6120476574205355493f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_23_19_09_21_A_blue_cartoon_character_inspired_by_Towelie_from_South_Park_but_with_a_different_look_in_the_same_light_blue_color_as_the_SUI_logo_The_character_i_1_f1b522ad3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

