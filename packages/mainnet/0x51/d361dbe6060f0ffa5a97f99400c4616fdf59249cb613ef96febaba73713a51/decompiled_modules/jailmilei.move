module 0x51d361dbe6060f0ffa5a97f99400c4616fdf59249cb613ef96febaba73713a51::jailmilei {
    struct JAILMILEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILMILEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILMILEI>(arg0, 6, b"JAILMILEI", b"Jail Javier Milei", b"DeepBook was built from the ground up to power the Sui ecosystem with unparalleled liquidity. From its inception, it has provided developers with reliable, composable on-chain applications, and enabled market makers and liquidity pools to operate seamlessly within the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Bu_XJ_Du_A8dnq_Upyt_Spnyx_Ny9ymuch_Z_Fb_Wx_Fcs_Rg_Fpump_7731ee7786.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILMILEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILMILEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

