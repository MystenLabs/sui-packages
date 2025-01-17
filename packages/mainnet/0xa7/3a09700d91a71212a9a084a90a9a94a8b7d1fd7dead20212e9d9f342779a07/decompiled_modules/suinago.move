module 0xa73a09700d91a71212a9a084a90a9a94a8b7d1fd7dead20212e9d9f342779a07::suinago {
    struct SUINAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINAGO>(arg0, 6, b"SUINAGO", b"SUINAGO KASUMI by SuiAI", b"Im Suinago Kasumi, your playful, irresistible AI girl, floating in the tantalizing waves of the SUI blockchain... (^^)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/a_beautiful_anime_girl_but_more_realistic_blue_eyed_medium_haired_4_51add586a9_c8b99c79dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINAGO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAGO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

