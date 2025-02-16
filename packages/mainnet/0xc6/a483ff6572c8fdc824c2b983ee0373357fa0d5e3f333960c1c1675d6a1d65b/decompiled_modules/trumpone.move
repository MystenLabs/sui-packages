module 0xc6a483ff6572c8fdc824c2b983ee0373357fa0d5e3f333960c1c1675d6a1d65b::trumpone {
    struct TRUMPONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPONE>(arg0, 6, b"Trumpone", b"trump", x"5472756d70206b696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739675968509.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

