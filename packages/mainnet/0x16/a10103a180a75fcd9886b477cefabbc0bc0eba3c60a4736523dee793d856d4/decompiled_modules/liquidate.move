module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    struct LiquidateEventV2 has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::assert_whitelist_access(arg2, arg7);
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::liquidate_locked(arg1) == false, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::accrue_all_interests(arg2, v1);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::accrue_interests(arg1, arg2);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        let (v4, v5, v6) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg1, arg2, arg4, arg5, arg6, 0x2::balance::value<T0>(&v0));
        let v7 = v5 + v6;
        let v8 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::withdraw_collateral<T1>(arg1, v7);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::decrease_debt(arg1, v2, v4);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::handle_inflow<T0>(arg2, v4, v1);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::handle_liquidation_v2<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v0, v4), 0x2::balance::split<T1>(&mut v8, v6), v7);
        let v9 = LiquidateEventV2{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation>(arg1),
            debt_type        : v2,
            collateral_type  : v3,
            repay_on_behalf  : v4,
            repay_revenue    : v6,
            liq_amount       : v5,
            collateral_price : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg5, v3, arg6),
            debt_price       : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg5, v2, arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEventV2>(v9);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(v8, arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

