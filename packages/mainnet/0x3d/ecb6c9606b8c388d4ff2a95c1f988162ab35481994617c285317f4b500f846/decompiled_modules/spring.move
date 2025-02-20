module 0x3decb6c9606b8c388d4ff2a95c1f988162ab35481994617c285317f4b500f846::spring {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_price_voucher_from_spring<T0: drop, T1: drop>(arg0: &mut 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg3: &0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::State, arg4: &0x2::tx_context::TxContext) : 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceVoucher<T0> {
        assert!(0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::is_sy_bind<T1, T0>(arg3), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T1>(arg2);
        assert!(v0 > 0, 0);
        0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T1>(arg2) as u128), (v0 as u128)), arg4)
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

