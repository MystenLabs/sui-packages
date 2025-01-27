module 0x51a0479c6357a84191a379d0cd1a8df081e6b81a9861925e44dfe356ddfb4f12::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP>(arg0, 6, b"PPP", b"Pandaman", b"Who needs utility when you have unmatched sarcasm?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738014000497.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

