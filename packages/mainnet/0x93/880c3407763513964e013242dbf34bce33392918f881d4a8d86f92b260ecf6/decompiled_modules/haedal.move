module 0x93880c3407763513964e013242dbf34bce33392918f881d4a8d86f92b260ecf6::haedal {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_haWAL_price_voucher<T0: drop, T1: drop>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::State, arg4: &0x2::tx_context::TxContext) : 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceVoucher<T0> {
        assert!(0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::is_sy_bind<T1, T0>(arg3), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_exchange_rate(arg2) as u128), 1000000);
        0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::one()), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(v0));
        0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, v0, arg4)
    }

    public fun get_price_voucher_from_cetus_vault<T0: drop, T1: drop, T2: drop>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::State, arg6: &0x2::tx_context::TxContext) : 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceVoucher<T0> {
        assert!(0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::sy::is_sy_bind<T2, T0>(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        let (v0, v1) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<T1, 0x2::sui::SUI, T2>(arg3, arg4, 1000000000);
        0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::divDown(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::add(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v0), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg2) as u128), 1000000)), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v1)), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(1000000000)), arg6)
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

