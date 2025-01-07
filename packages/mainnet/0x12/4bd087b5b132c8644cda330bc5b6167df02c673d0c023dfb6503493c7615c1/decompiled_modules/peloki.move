module 0x124bd087b5b132c8644cda330bc5b6167df02c673d0c023dfb6503493c7615c1::peloki {
    struct PELOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELOKI>(arg0, 6, b"PELOKI", b"Peloki Coin", x"50656c6f6b693a20576865726520466c6f6b697320537069726974204d656574732050657065732046756e20556e6c65617368696e67204d656d65204d61676963210a0a68747470733a2f2f696e7374616772616d2e636f6d2f70656c6f6b69636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727603839048_ab23499e82f8bcb25eb6bfc91cf7d0b3_d2194dd2ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

