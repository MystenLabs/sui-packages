module 0x80ad406667c728627daaacd6b1ba1d2c6c46e7628b32235d0947d4670547623f::drew {
    struct DREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREW>(arg0, 6, b"DREW", b"Drew Sui", b"Some of us came for the art, most of us stayed because of it. $drew is a cat with a mission: to support artists and change lives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732019981321.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

