module 0xce42e616281a947f52ca16dbe2ba639fa4c070b7bf314581479e86de2a84b432::SSHIB {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SSHIBA", b"1000000000000", b"1000000", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

