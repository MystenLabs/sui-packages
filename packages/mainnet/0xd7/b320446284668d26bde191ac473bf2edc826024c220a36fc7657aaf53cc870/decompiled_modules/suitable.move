module 0xd7b320446284668d26bde191ac473bf2edc826024c220a36fc7657aaf53cc870::suitable {
    struct SUITABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITABLE>(arg0, 6, b"Suitable", b"SUI The Stable Coin", b"Finally sui reached 1$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789984618254.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITABLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITABLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

