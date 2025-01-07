module 0x98f79a20dfdd1cfb86102601f2cfeaba9c8e2441189b582785f2ef4e6e78c134::tontoba {
    struct TONTOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONTOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONTOBA>(arg0, 6, b"TONTOBA", b"Tontoba Coin on SUI", x"546f6e746f6261206973206d7920636174210a49206c6f766520546f6e746f6261", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_25_14_06_37_6875099e98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONTOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONTOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

