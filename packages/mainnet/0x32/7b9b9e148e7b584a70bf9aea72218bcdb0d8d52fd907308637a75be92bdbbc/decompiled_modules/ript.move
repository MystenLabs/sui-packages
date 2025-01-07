module 0x327b9b9e148e7b584a70bf9aea72218bcdb0d8d52fd907308637a75be92bdbbc::ript {
    struct RIPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPT>(arg0, 6, b"RIPT", b"RIPTos", b"Now that Aptos $APT is dead and buried, can we resurrect and save RIPTos $RIPT from its gloomy fate? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_necromancer_resurrecting_a_digital_coin_from_the_grave_coming_out_of_the_ground_green_black_ne_vdywsi65oeeoy6gckvju_2_5c3f6f6d11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

