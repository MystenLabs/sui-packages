module 0xcb9faa456d0c475bada346561091c0a240f7e12a9ccf199c2db0ff85eb18040f::EarsoftheGentleCurse {
    struct EARSOFTHEGENTLECURSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFTHEGENTLECURSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFTHEGENTLECURSE>(arg0, 0, b"COS", b"Ears of the Gentle Curse", b"A soft sound... an unknown consequence... listen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_the_Gentle_Curse.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFTHEGENTLECURSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFTHEGENTLECURSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

