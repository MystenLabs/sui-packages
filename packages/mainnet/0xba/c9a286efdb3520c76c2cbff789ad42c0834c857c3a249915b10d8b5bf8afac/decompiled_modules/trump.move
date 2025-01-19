module 0xbac9a286efdb3520c76c2cbff789ad42c0834c857c3a249915b10d8b5bf8afac::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Wrapped Coin for Trump", b"Sudo Wrapped Coin for Official Trump", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP>>(v0);
    }

    // decompiled from Move bytecode v6
}

