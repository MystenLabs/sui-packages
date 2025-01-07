module 0xd1eab15195c15fb0aeae7075612dc29d099b5a665b11332a61a1d34f154c2b8f::iykyk {
    struct IYKYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYKYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYKYK>(arg0, 6, b"IYKYK", b"iYKYK", x"49594b594b0a0a49594b594b0a0a49594b594b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734216161405.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IYKYK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYKYK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

