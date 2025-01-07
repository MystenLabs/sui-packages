module 0x7f2b30092d36fdea7df6187c219be3623b132c866b488cf245828d30a8bace3b::wrct {
    struct WRCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRCT>(arg0, 6, b"WRCT", b"WARCAT", b"A cat who has been trained by the secret elite mafia to win the world battle royale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732059004584.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

