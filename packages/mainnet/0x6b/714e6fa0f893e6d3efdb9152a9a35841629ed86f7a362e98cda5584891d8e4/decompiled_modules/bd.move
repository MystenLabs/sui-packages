module 0x6b714e6fa0f893e6d3efdb9152a9a35841629ed86f7a362e98cda5584891d8e4::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"BLACK DUDE (NIGGER)", b"I LOVE NIGGERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752179562715.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

