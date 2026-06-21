module 0x2292d8d0c248a7b0246f33752e411064f88fe8575c959c1e86558436c1f55e45::suilend_adapter {
    struct SUILEND has drop {
        dummy_field: bool,
    }

    public fun owner_redeem<T0, T1>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T1>, arg1: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::OwnerCap<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::owner_take_receipt<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, arg1, 0);
        0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::owner_recustody<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, arg1, 0, v0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &v0, arg5, arg4, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6)
    }

    public fun verified_supply_suilend_entry<T0, T1>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DecisionRegistry, arg1: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T1>, arg2: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Enclave<0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DECISION>, arg3: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u16, arg7: vector<u8>, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: u8, arg13: u8, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: u64, arg22: vector<u8>, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND{dummy_field: false};
        let (v1, v2) = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::verified_release<T1, SUILEND>(v0, arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        let v3 = v2;
        if (0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::ticket_has_position<T1>(arg1, &v3)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg4, arg5, 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::borrow_for_ticket<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, &v3), arg23, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg4, arg5, arg23, v1, arg24), arg24);
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::discharge_existing<T1>(arg1, v3);
        } else {
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg4, arg24);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg4, arg5, &v4, arg23, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg4, arg5, arg23, v1, arg24), arg24);
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::custody_new<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, v3, v4);
        };
    }

    // decompiled from Move bytecode v7
}

