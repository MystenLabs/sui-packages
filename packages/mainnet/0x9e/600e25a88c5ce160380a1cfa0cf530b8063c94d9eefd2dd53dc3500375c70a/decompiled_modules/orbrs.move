module 0x9e600e25a88c5ce160380a1cfa0cf530b8063c94d9eefd2dd53dc3500375c70a::orbrs {
    struct ORBRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBRS>(arg0, 6, b"ORBRS", b"Ouroboros Club", b"Ouroboros is an invite-only club of alpha dealers,founded by HIM.Collect the dots in reversion.Connect the dots through recursion.Driven by value realisation.Solving the serpentine equation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736416024649.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORBRS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBRS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

