module 0x14bee276a4633774bc44707f1674ba267a096f02de731fc4b16342772ee46a86::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"FartChick", b"Introducing FartChick. The AI-driven powerhouse with an innovative AI Farts Generator!  It's set to fuel your portfolio with both giggles and gains. Ready for a financial blast thats smart, stinky, and lucrative? Join the fart revolution today! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_C2_F4082_8_B9_C_45_CF_B610_882_EFB_506_DBC_320f12e386.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FART>>(v1);
    }

    // decompiled from Move bytecode v6
}

