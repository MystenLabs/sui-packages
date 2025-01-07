module 0x48e3475b2ebc23eabc58232c74f894d2f1f953b918bb45ca51d986c8378ba472::fily {
    struct FILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILY>(arg0, 6, b"FILY", b"Fily", b"I know I'm psycho but red candles make me tweak out even more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_10_T224129_231_2dbb81bd88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

