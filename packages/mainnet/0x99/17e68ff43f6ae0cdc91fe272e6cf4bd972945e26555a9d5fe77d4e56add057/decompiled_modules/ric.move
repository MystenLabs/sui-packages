module 0x9917e68ff43f6ae0cdc91fe272e6cf4bd972945e26555a9d5fe77d4e56add057::ric {
    struct RIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIC>(arg0, 6, b"Ric", b"Ricardo Milos", b"This coin is inspired  by a Brazilian adult model known for his erotic dance video.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731886751415.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

