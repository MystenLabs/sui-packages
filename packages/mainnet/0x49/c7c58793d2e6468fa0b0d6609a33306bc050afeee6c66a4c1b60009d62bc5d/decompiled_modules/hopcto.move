module 0x49c7c58793d2e6468fa0b0d6609a33306bc050afeee6c66a4c1b60009d62bc5d::hopcto {
    struct HOPCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCTO>(arg0, 6, b"HOPCTO", b"Hop.fun CTO", x"4c6f736520796f75722074696d652049524c2026206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950117880.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

