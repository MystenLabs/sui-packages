module 0x847906a1c995e43a407ca254869381ffd82be3df8bb104a3603c9e976e724253::sow {
    struct SOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOW>(arg0, 6, b"SOW", b"Sowelie", x"546865207265616c20536f77656c69652024534f570a57616e6e6120476574205355493f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_23_19_09_21_A_blue_cartoon_character_inspired_by_Towelie_from_South_Park_but_with_a_different_look_in_the_same_light_blue_color_as_the_SUI_logo_The_character_i_1_ba4de69668.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

