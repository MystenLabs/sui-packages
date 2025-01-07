module 0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::trade_builder {
    struct TradeBuilder<phantom T0, phantom T1> {
        trade_id: u256,
        amount_out_expected: u64,
        slippage: u64,
        deadline: u64,
        coin_in: 0x2::coin::Coin<T0>,
        route_percentages: vector<u64>,
        partner: 0x1::option::Option<0x1::string::String>,
    }

    public fun add_route<T0, T1>(arg0: &mut TradeBuilder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<u64>(&mut arg0.route_percentages, arg1);
    }

    public fun build<T0, T1>(arg0: TradeBuilder<T0, T1>, arg1: &mut 0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::partner_manager::PartnerRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::universal_router::Trade<T0, T1> {
        let TradeBuilder {
            trade_id            : v0,
            amount_out_expected : v1,
            slippage            : v2,
            deadline            : v3,
            coin_in             : v4,
            route_percentages   : v5,
            partner             : v6,
        } = arg0;
        0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::universal_router::new<T0, T1>(arg1, v6, v4, v0, v1, v2, v3, v5, arg2)
    }

    public fun new<T0, T1>(arg0: &mut 0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::trade_id_tracker::TradeIdTracker, arg1: &0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::partner_manager::PartnerRegistry, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : TradeBuilder<T0, T1> {
        0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::trade_id_tracker::increment(arg0);
        TradeBuilder<T0, T1>{
            trade_id            : 0x1a97eb4e5e9e135a99a730b1772c1f95b1c9f36590d9cd1c5ab14426055b8156::trade_id_tracker::current(arg0),
            amount_out_expected : arg4,
            slippage            : arg5,
            deadline            : arg6,
            coin_in             : arg2,
            route_percentages   : 0x1::vector::empty<u64>(),
            partner             : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

