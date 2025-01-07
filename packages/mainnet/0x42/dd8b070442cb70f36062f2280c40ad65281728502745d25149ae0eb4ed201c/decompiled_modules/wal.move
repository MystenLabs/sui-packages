module 0x42dd8b070442cb70f36062f2280c40ad65281728502745d25149ae0eb4ed201c::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 6, b"WAL", b"Walrus", b"Welcome to the next generation of data storage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731500292791.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

