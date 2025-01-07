module 0x122911d8396deb29452b8092d7119b514b06ca3dbc08aa68d4dc994abe629089::yosi {
    struct YOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOSI>(arg0, 6, b"YOSI", b"Yosisui", b"yosi loves you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_023458_766_2b1cfe8e5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

