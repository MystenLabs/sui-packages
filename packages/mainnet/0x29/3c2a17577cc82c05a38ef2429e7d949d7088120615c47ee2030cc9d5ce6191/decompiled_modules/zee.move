module 0x293c2a17577cc82c05a38ef2429e7d949d7088120615c47ee2030cc9d5ce6191::zee {
    struct ZEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZEE>(arg0, 6, b"ZEE", b"Zee Techwave by SuiAI", b"Zee is an AI influencer focused on technology including AI and Crypto, social activism, and mental health, catering specifically to the Gen Z demographic. Zee combines tech savviness with a strong advocacy for mental health and social justice, embodying the digital-native spirit of Gen Z.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2025_01_11_224914353_a9beffb7e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

