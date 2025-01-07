module 0x2284fa4b1e145f77c4d193d8d7991d633c162320c9585380af1f521c1245bbb9::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 6, b"PEACE", b"PEACE COIN", b"No war, only peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peace_sign_blue_white_watery_style_logo_0h5stci6jqn0tdoesxhh_1_e6396630c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

