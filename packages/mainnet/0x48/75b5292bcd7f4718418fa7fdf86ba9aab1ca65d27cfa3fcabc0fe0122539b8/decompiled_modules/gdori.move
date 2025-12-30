module 0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori {
    struct GDORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GDORI>(arg0, 9, 0x1::string::utf8(b"gDORI"), 0x1::string::utf8(b"Guard DORI"), 0x1::string::utf8(b"gDORI is a wrapper token representing DORI auto-deposited across all Stability Pools on Weiss.Finance. It uses an exchange-rate mechanism and is redeemable for DORI."), 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/gdori.svg"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<GDORI>>(0x2::coin_registry::finalize<GDORI>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDORI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

