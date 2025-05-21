module 0x3524ab299f4daab2b3399f7cdda7d6a0d78f7f9ceec13bf7c637dbd6f082e81f::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 6, b"SD", b"Sadboy", b"My son ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747856116638.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

