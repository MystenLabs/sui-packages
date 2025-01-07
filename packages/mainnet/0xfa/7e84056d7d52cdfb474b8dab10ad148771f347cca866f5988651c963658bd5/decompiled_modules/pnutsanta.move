module 0xfa7e84056d7d52cdfb474b8dab10ad148771f347cca866f5988651c963658bd5::pnutsanta {
    struct PNUTSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTSANTA>(arg0, 6, b"PNUTSANTA", b"Peanut Santa", b"Peanut Santa is an adorable squirrel dressed as Santa, spreading joy and festive cheer! With a playful and cheerful spirit, Peanut brings laughter and happiness wherever he goes, making every day feel like a holiday season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_L_Yy_CR_Dp_R_Mhgww7jb_N2e_PG_2w_JYF_25jnypno_DH_1bopump_1_073bcd12aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

