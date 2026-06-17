module 0x139a7c0e2ed856a630484817a0d639f5a86fdc77f1645f770f5bfd59486e8c0b::pt_vault {
    struct PT_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT_VAULT>(arg0, 9, 0x1::string::utf8(b"PT-NEMO"), 0x1::string::utf8(b"Nemo PT"), 0x1::string::utf8(b"Nemo Yield Trading v2.35 principal token. Redeemable for SUI at market maturity."), 0x1::string::utf8(b"https://nemo.xyz/icon-pt.png"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PT_VAULT>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT_VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

