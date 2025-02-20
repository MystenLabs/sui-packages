module 0xc167c8782d73bf1c5777c2b005b730e53b21cc277136c7c3b94cca625dc6cf3f::scallop {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceTicket<T0>,
    }

    fun calc_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun get_price_voucher_from_x_oracle<T0: drop, T1: drop>(arg0: &mut 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::State, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceVoucher<T0> {
        assert!(0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::is_sy_bind_with_underlying_token<T1, T0>(arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 1000000000;
        0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((calc_scoin_to_coin(arg2, arg3, 0x1::type_name::get<T1>(), arg5, v0) as u128), (v0 as u128)), arg6)
    }

    fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    public fun register_price_ticket_cap<T0: drop>(arg0: 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceTicketCap<T0>{
            id           : 0x2::object::new(arg1),
            price_ticket : arg0,
        };
        0x2::transfer::share_object<PriceTicketCap<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

