module 0xd07fc66c71db89fbbf97baab8aaff2b6cc3a7945ec43fc6f92b822fd9fba244f::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 6, b"CCAT", b"CAP CAT", b"CAT? or CAP? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730445927557.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

