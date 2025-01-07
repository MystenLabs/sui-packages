module 0x27a71703d0b26710e288d84802ec3cc294c8bf779e9fd30d2afee94246ad2c09::mcdon {
    struct MCDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDON>(arg0, 6, b"MCDON", b"McDonald Junior", b"Make Fast Food Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_21_112125_cb1ad42d1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

