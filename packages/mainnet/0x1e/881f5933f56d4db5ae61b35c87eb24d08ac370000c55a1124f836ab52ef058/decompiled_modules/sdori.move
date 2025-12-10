module 0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori {
    struct SDORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SDORI>(arg0, 9, 0x1::string::utf8(b"sDORI"), 0x1::string::utf8(b"Savings DORI"), 0x1::string::utf8(b"sDORI is a wrapper token representing DORI deposited in the Weiss.Finance pool. It uses an exchange-rate mechanism and is redeemable for DORI."), 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/sdori.svg"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<SDORI>>(0x2::coin_registry::finalize<SDORI>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDORI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

