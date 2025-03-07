module 0x2b2bdf77b20a3e0a4e08f28d308ef94653ed27e3e5e1cf096fe4a9248abcb10a::haedal {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_price_voucher_from_haSui<T0: drop, T1: drop>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::State, arg4: &0x2::tx_context::TxContext) : 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceVoucher<T0> {
        assert!(0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::is_sy_bind<T1, T0>(arg3), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg2) as u128), 1000000), arg4)
    }

    public fun register_price_ticket_cap<T0: drop>(arg0: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceTicketCap<T0>{
            id           : 0x2::object::new(arg1),
            price_ticket : arg0,
        };
        0x2::transfer::share_object<PriceTicketCap<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

