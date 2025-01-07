module 0x7ba6e74f0e9e18c89575f210b25ddf2fddd47f78c252b6a5ef9b845845acc01d::trumpwif {
    struct TRUMPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIF>(arg0, 6, b"TRUMPWIF", b"Trumpwighatt", b"America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960548775.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

