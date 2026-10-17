module 0xca23a1391b33bfedb728fc0c07ed6cb273922771ef4b97cab672a55753f5ad0b::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: BNB, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BNB>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BNB>>(0x2::coin::mint<BNB>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<BNB>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<BNB>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BNB>>(0x2::coin_registry::finalize<BNB>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BNB>(v3, arg12);
        };
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"BNB"), 0x1::string::utf8(b"BNB Test Meme"), 0x1::string::utf8(b"Blast standalone Bluefin vault test coin. Not Binance BNB."), 0x1::string::utf8(b""), 1000000000000000, @0x612fa27ba229021c5a1c32022fd6341ffbd58a87ac928a0dc32d8d6d1dba9fed, 1, @0x7ca9, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

