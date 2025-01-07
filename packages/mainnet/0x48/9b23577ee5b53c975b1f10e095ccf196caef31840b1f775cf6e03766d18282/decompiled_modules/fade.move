module 0x489b23577ee5b53c975b1f10e095ccf196caef31840b1f775cf6e03766d18282::fade {
    struct FADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADE>(arg0, 6, b"FADE", b"FADE APOCALYPSE", b"An Apocalypse Themed Memecoin aiming to redefine the ethos of memes by a Fair Aesthetic DeFi Experiment , an Experiment to reformat the system and wipe off the corrupt virus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_10_27_59_PM_540248f33b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

