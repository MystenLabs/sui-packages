module 0x7df95913303f94ca3d07ac769bc3e50f370d2a2546b430903ec4b17a2adc1260::amts {
    struct AMTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMTS>(arg0, 6, b"AMTS", b"AmateraSUI", x"416d61746572615355492069732066756e20746f6b656e207375692077686f206c696b652075636869686120636c616e73200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/desktop_wallpaper_210_sharingan_eye_ideas_blue_sharingan_af47c5dd02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

