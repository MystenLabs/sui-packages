module 0x750a432d5081ab3a149d1be919e877272932fae86dd5257f1709eb44b717ebda::sov {
    struct SOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOV>(arg0, 6, b"SOV", b"SUIOVI", b"@suilaunchcoin $SOV + SUIOVI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sov-rgbuia.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

