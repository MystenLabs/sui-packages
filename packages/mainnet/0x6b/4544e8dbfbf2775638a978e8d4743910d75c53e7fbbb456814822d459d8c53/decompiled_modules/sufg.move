module 0x6b4544e8dbfbf2775638a978e8d4743910d75c53e7fbbb456814822d459d8c53::sufg {
    struct SUFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUFG>(arg0, 6, b"Sufg", b"Sufrog", x"225768656e20796f75277265206a757374206368696c6c696e27206f6e2061206c696c79207061642c206c6f6f6b696e6720637574652c20616e64206c657474696e67206c69666520736f727420697473656c66206f75742e220a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_11_22_12_22_A_cute_cartoon_style_blue_frog_sitting_on_a_lily_pad_in_a_calm_lake_with_water_gently_rippling_around_The_sky_is_clear_and_some_cattails_and_lily_f_88b636bf93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

