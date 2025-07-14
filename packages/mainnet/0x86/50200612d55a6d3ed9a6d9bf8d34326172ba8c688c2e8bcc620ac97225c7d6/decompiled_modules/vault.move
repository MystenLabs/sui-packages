module 0x8650200612d55a6d3ed9a6d9bf8d34326172ba8c688c2e8bcc620ac97225c7d6::vault {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_exchange_rate_in_usd_from_mmt_vault<T0: drop, T1, T2, T3: drop, T4: copy + drop + store>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg3: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T1, T2, T3, T4>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::State, arg6: &mut 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::py::PyState<T0>, arg7: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::market_global::MarketFactoryConfig, arg8: &mut 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::market::MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        let v0 = get_pair_price_voucher_usd_from_mmt_vault<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10);
        let v1 = 100000;
        let (v2, _, _, _) = 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::router::get_pt_out_for_exact_sy_in_with_price_voucher<T0>(v1, 0, v0, arg6, arg7, arg8, arg9, arg10);
        (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((v2 as u128), (v1 as u128))), 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::get_price<T0>(get_pair_price_voucher_usd_from_mmt_vault<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10), arg10))
    }

    public fun get_pair_price_voucher_usd_from_mmt_vault<T0: drop, T1, T2, T3: drop, T4: copy + drop + store>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg3: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T1, T2, T3, T4>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::State, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceVoucher<T0> {
        assert!(0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::is_sy_bind<T3, T0>(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((get_vault_total_value_in_usd<T1, T2, T3, T4>(arg3, arg4, arg2, arg6) as u128), (0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::total_supply<T1, T2, T3, T4>(arg3) as u128)), arg7)
    }

    fun get_vault_total_value_in_usd<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::utils::get_amount_by_liquidity<T0, T1, T2, T3>(arg0, arg1, true);
        let (v2, v3) = 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::decimals<T0, T1, T2, T3>(arg0);
        (((0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg2, 0x1::type_name::get<T0>(), arg3) as u128) * (v0 as u128) / (0x2::math::pow(10, v2) as u128)) as u64) + (((0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg2, 0x1::type_name::get<T1>(), arg3) as u128) * (v1 as u128) / (0x2::math::pow(10, v3) as u128)) as u64)
    }

    public fun register_price_ticket_cap<T0: drop>(arg0: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceTicketCap<T0>{
            id           : 0x2::object::new(arg1),
            price_ticket : arg0,
        };
        0x2::transfer::share_object<PriceTicketCap<T0>>(v0);
    }

    public fun test<T0: drop, T1, T2, T3: drop, T4: copy + drop + store>(arg0: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg1: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T1, T2, T3, T4>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1) = 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::utils::get_amount_by_liquidity<T1, T2, T3, T4>(arg1, arg2, true);
        let (v2, v3) = 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::decimals<T1, T2, T3, T4>(arg1);
        let v4 = 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg0, 0x1::type_name::get<T1>(), arg3);
        let v5 = 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg0, 0x1::type_name::get<T2>(), arg3);
        (get_vault_total_value_in_usd<T1, T2, T3, T4>(arg1, arg2, arg0, arg3), 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::total_supply<T1, T2, T3, T4>(arg1), (((v4 as u128) * (v0 as u128) / (0x2::math::pow(10, v2) as u128)) as u64), (((v5 as u128) * (v1 as u128) / (0x2::math::pow(10, v3) as u128)) as u64), v4, v5, v0, v1)
    }

    // decompiled from Move bytecode v6
}

