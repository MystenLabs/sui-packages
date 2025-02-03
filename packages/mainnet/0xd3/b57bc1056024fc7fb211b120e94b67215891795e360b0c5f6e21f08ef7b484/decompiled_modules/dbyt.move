module 0xd3b57bc1056024fc7fb211b120e94b67215891795e360b0c5f6e21f08ef7b484::dbyt {
    struct DBYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBYT>(arg0, 6, b"DBYT", b"Don't buy", b"LET'go fight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738500917110.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBYT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBYT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

