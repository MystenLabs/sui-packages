module 0x73465b2dc1bbb3ec2f9f869660114be038c0abe0449e55c01bfec048ba459e4::ovd {
    struct OVD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OVD>(arg0, 6, b"OVD", b"Overdrive_x1 by SuiAI", b"Overdrive X1 is an advanced AI powered chatbot designed for seamless communication and intelligent interactions It understands natural language processes responses instantly and adapts to user preferences for a more personalized experience With deep learning capabilities and real time context awareness Overdrive X1 delivers accurate helpful and engaging conversations Whether for customer support virtual assistance or casual chat it ensures smooth and intuitive interactions making every conversation feel natural and efficient", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_02_04_08_08_30_A_futuristic_AI_avatar_representing_Dynamic_Crypto_Trading_DCT_designed_in_the_style_of_a_Warframe_character_The_avatar_has_a_sleek_armored_cybern_a1f902e60d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OVD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

