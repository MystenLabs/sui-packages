module 0xc817b0d7963e9b0782aeb803c598b8d686025e3ddefc7da43480406752e359d::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"DSUI", b"Dolphsuisui", b"\"When life gets too deep, just keep swimming like Dolphsui!  With bubbles rising and a carefree vibe, this dolphins living its best underwater life. Keep it cool, keep it playful  thats the Dolphsui way!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_19_00_39_A_playful_dolphin_swimming_in_the_ocean_surrounded_by_air_bubbles_rising_through_the_clear_blue_water_The_dolphin_looks_cheerful_with_bubbles_float_74d6d4abe9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

