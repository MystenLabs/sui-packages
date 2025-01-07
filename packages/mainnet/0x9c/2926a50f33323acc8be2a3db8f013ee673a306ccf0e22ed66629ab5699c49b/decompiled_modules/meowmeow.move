module 0x9c2926a50f33323acc8be2a3db8f013ee673a306ccf0e22ed66629ab5699c49b::meowmeow {
    struct MEOWMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEOW>(arg0, 6, b"MEOWMEOW", b"NO.1 TIKTOK AI CAT", b"NO.1 TIKTOK AI CAT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_14_144404_784d7f9225.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

