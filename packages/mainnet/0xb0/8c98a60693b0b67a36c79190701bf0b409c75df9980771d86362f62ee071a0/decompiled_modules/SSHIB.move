module 0xb08c98a60693b0b67a36c79190701bf0b409c75df9980771d86362f62ee071a0::SSHIB {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SSHIB", b"1000000000000", b"1000000", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

