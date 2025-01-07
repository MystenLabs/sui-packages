module 0x3c3382ceff8df84a0db246d549cdd4867a0e591b62f0b59ab6e20a7c4eec4a17::twh {
    struct TWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWH>(arg0, 6, b"TWH", b"Trump Wif Hat", b"$TWH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731025429270.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

