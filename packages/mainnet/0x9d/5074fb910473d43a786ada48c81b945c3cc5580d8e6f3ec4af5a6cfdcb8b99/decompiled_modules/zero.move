module 0x9d5074fb910473d43a786ada48c81b945c3cc5580d8e6f3ec4af5a6cfdcb8b99::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO>(arg0, 9, b"ZERO", b"Zero", b"ZERO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://popularsui.xyz/media/62af62b8f29bbb463376d61726e592a7f965887387fb86f39e6eb06c5cb436ce.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ZERO>>(0x2::coin::mint<ZERO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

