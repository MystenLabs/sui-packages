module 0xccd8609796c76a03146ec065bad37b5a9f5e457e25c3def7377592e2ad9a697d::scake {
    struct SCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCAKE>(arg0, 6, b"SCAKE", b"SuiCake", b"Just a Cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000260487_d098dfbb33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCAKE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAKE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

