module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share {
    struct SHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHARE>(arg0, 9, 0x1::string::utf8(b"CSNO"), 0x1::string::utf8(b"CASINO"), 0x1::string::utf8(b"Claim on the Sui casino house pool. Games settle against this pool. Redeem by withdrawing."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SHARE>>(0x2::coin_registry::finalize<SHARE>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

