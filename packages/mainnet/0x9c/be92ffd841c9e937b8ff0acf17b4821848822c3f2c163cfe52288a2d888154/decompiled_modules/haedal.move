module 0x9cbe92ffd841c9e937b8ff0acf17b4821848822c3f2c163cfe52288a2d888154::haedal {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_price_voucher_from_haSui<T0: drop, T1: drop>(arg0: &mut 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::State, arg4: &0x2::tx_context::TxContext) : 0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::PriceVoucher<T0> {
        assert!(0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::sy::is_sy_bind<T1, T0>(arg3), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        0x85f6136e8af827d5cdfbf07927698f5ee035ffa34c018148ee0737fb8e43b7aa::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg2) as u128), 1000000), arg4)
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

