module 0x18ecf374b88adf6d202a76723275a8fd376c8fd800cc978dcf00dee605d44cfd::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/d23ca493-6583-429e-8cf9-171c7f357eb3/Goldengoat.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/d23ca493-6583-429e-8cf9-171c7f357eb3/Goldengoat.png"))
        };
        let v1 = b"aGOAT";
        let v2 = b"bGolden Goat";
        let v3 = b"cA mystical creature said to wander hidden valleys, leaving trails of gold dust and secrets. Some say catching a glimpse brings fortune, but only the brave dare to seek its golden glow!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

