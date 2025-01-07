module 0x41226e09816029db9e208e8bc3a3536bd6cff46e1d1294d10d49075b61fca4d::zerobro {
    struct ZEROBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEROBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEROBRO>(arg0, 6, b"ZEROBRO", b"Zerobro on sui", b"Come join us,,, we r going to zerobro..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_121641_524_2c34190acd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEROBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEROBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

