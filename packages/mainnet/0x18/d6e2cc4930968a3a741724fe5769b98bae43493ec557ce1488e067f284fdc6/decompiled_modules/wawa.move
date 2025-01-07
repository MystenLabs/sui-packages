module 0x18d6e2cc4930968a3a741724fe5769b98bae43493ec557ce1488e067f284fdc6::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 6, b"WAWA", b"GWAWA", b"Welcome to GWAWA on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962607087.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

