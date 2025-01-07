module 0xe344b2251f4d206c7095db429f5ca22735ed4c777f9cc408f916bc20024a4e02::squirrel {
    struct SQUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRREL>(arg0, 6, b"Squirrel", b"squirrel", b"hazelnut hazelnut hazelnuthazelnut hazelnut hazelnuthazelnut hazelnut hazelnut hazelnut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cute_happy_squirrel_isolated_white_background_wearing_cold_weather_winter_outfit_cartoon_character_mascot_331346217_91b26e1dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

