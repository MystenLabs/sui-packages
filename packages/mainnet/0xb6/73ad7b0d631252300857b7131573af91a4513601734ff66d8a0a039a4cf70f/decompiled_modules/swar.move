module 0xb673ad7b0d631252300857b7131573af91a4513601734ff66d8a0a039a4cf70f::swar {
    struct SWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAR>(arg0, 6, b"SWAR", b"Sui Army", b"Fight Fight Fight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005810629.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

