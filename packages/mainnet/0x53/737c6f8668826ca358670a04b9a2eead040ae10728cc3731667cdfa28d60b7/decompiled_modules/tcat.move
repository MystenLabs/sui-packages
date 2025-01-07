module 0x53737c6f8668826ca358670a04b9a2eead040ae10728cc3731667cdfa28d60b7::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"TURBOSCAT", b"TurbosCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950314678.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

