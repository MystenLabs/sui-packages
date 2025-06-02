module 0xe33adb7bec8ddc73e73444f15b6703c89a86fa642b3974208228910b8d59f091::buck {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_exchange_rate_from_ssbuck<T0: drop, T1: drop>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg3: &mut 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::py::PyState<T0>, arg4: &0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::market_global::MarketFactoryConfig, arg5: &mut 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::market::MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        let v0 = get_price_voucher_from_ssbuck<T0, T1>(arg0, arg1, arg2, arg6, arg7);
        let v1 = 100000;
        let (v2, _, _, _) = 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::router::get_pt_out_for_exact_sy_in_with_price_voucher<T0>(v1, 0, v0, arg3, arg4, arg5, arg6, arg7);
        (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::get_raw_value(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((v2 as u128), (v1 as u128))), 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::get_price<T0>(get_price_voucher_from_ssbuck<T0, T1>(arg0, arg1, arg2, arg6, arg7), arg7))
    }

    public fun get_price_voucher_from_ssbuck<T0: drop, T1: drop>(arg0: &mut 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceOracleConfig, arg1: &PriceTicketCap<T0>, arg2: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::PriceVoucher<T0> {
        0x8783841625738f73a6b0085f5dad270b4b0bd2e5cdb278dc95201e45bd1a332b::oracle_voucher::generate_price_voucher<T0>(arg0, &arg1.price_ticket, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational((0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg2, arg3) as u128), (0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg2) as u128)), arg4)
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

