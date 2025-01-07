module 0x7d5fd707fbf314f3696efa32ff3b5f463095d5c113176151b24fd087d32cb2fb::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"Hop Cat", b"First cat on Turbos Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001332860.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

