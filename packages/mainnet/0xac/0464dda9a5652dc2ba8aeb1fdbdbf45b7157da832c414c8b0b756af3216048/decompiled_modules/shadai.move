module 0xac0464dda9a5652dc2ba8aeb1fdbdbf45b7157da832c414c8b0b756af3216048::shadai {
    struct SHADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHADAI>(arg0, 6, b"SHADAI", b"Shadow agent", b"Lord shadow himself in the AI world... I AM ATOMIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/55dc0e87afd1dc711b39ddbc793d77a7_6a64b96661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHADAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

