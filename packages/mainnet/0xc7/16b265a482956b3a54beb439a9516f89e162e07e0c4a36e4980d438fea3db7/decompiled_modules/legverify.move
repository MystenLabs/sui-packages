module 0xc716b265a482956b3a54beb439a9516f89e162e07e0c4a36e4980d438fea3db7::legverify {
    struct LEGVERIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGVERIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LEGVERIFY>(arg0, 0, 0x1::string::utf8(b"LEGV"), 0x1::string::utf8(b"Legacy Verify"), 0x1::string::utf8(b"testing the fixed 2-transaction legacy metadata bridge, safe to ignore"), 0x1::string::utf8(b"https://example.com/x.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LEGVERIFY>>(0x2::coin::mint<LEGVERIFY>(&mut v2, 1, arg1), @0xb1a93b4f54716aab7c5e3fb56986e00eb5438bdc6aeb36b1e9ec76672772304c);
        0x2::coin_registry::make_supply_fixed_init<LEGVERIFY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LEGVERIFY>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

