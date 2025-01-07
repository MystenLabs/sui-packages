module 0xbd05c9aab2a8741afd7e93a97f67f226edb2f03199a96990325b2cda50de537e::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 6, b"BBC", b"Big Black Cod", b"Biggest BBC on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730465910573.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

