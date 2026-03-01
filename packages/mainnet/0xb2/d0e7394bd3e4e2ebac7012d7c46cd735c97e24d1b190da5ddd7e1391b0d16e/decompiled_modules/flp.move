module 0xb2d0e7394bd3e4e2ebac7012d7c46cd735c97e24d1b190da5ddd7e1391b0d16e::flp {
    struct FLPObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_owner_cap: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap,
        usdc_flp_amount: u64,
        sui_flp_amount: u64,
    }

    struct FLPAmountUpdated has copy, drop {
        flp_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        owner_cap: 0x2::object::ID,
        amount: u64,
    }

    struct FLPAmountPurged has copy, drop {
        flp_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        owner_cap: 0x2::object::ID,
    }

    public fun borrow<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &FLPObligationOwnerCap<T0>, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow::borrow<T0, T1>(arg0, &arg1.obligation_owner_cap, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun deposit<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: &mut FLPObligationOwnerCap<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (v0 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            arg2.sui_flp_amount = arg2.sui_flp_amount + 0x2::coin::value<T1>(&arg3) / 5000000000000;
        } else if (v0 == 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()) {
            arg2.usdc_flp_amount = arg2.usdc_flp_amount + 0x2::coin::value<T1>(&arg3) / 5000000000;
        };
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::deposit::deposit<T0, T1>(arg0, arg1, &arg2.obligation_owner_cap, arg3, arg4, arg5);
    }

    public fun repay<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &FLPObligationOwnerCap<T0>, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::repay::repay<T0, T1>(arg0, &arg1.obligation_owner_cap, arg2, arg3, arg4, arg5);
    }

    public fun withdraw<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: &FLPObligationOwnerCap<T0>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::withdraw::withdraw<T0, T1>(arg0, arg1, &arg2.obligation_owner_cap, arg3, arg4, arg5, arg6, arg7);
    }

    fun calculate_new_quota(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg1), arg2));
        if (arg0 > v0) {
            return arg0
        };
        let v1 = ceiling_div(v0 - arg0, arg2);
        if (arg1 <= v1) {
            0
        } else {
            arg1 - v1
        }
    }

    fun calculate_obligation_asset_flp_quota<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) : u64 {
        calculate_new_quota(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::exchange_rate<T0>(arg0, arg2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(arg1, arg2))), arg3, arg4)
    }

    fun ceiling_div(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun purchase<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_type::MainMarket>, arg2: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = FLPObligationOwnerCap<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_type::MainMarket>{
            id                   : 0x2::object::new(arg5),
            obligation_owner_cap : arg2,
            usdc_flp_amount      : 0,
            sui_flp_amount       : 0,
        };
        let v1 = &mut v0;
        deposit<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_type::MainMarket, T0>(arg0, arg1, v1, arg3, arg4, arg5);
        let v2 = &mut v0;
        refresh_obligation_flp_quota<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_type::MainMarket>(arg1, v2);
        assert!(v0.usdc_flp_amount + v0.sui_flp_amount != 0, 1);
        0x2::transfer::public_transfer<FLPObligationOwnerCap<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market_type::MainMarket>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun quotas<T0>(arg0: &FLPObligationOwnerCap<T0>) : (u64, u64) {
        (arg0.usdc_flp_amount, arg0.sui_flp_amount)
    }

    public fun refresh_obligation_flp_quota<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg1: &mut FLPObligationOwnerCap<T0>) {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::borrow_obligation<T0>(arg0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::id(&arg1.obligation_owner_cap));
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
            if (v3 == &v4) {
                arg1.sui_flp_amount = calculate_obligation_asset_flp_quota<T0>(arg0, v0, *v3, arg1.sui_flp_amount, 5000000000000);
                let v5 = FLPAmountUpdated{
                    flp_id    : 0x2::object::id<FLPObligationOwnerCap<T0>>(arg1),
                    coin_type : *v3,
                    owner_cap : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap>(&arg1.obligation_owner_cap),
                    amount    : arg1.sui_flp_amount,
                };
                0x2::event::emit<FLPAmountUpdated>(v5);
            } else {
                let v6 = 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>();
                if (v3 == &v6) {
                    arg1.usdc_flp_amount = calculate_obligation_asset_flp_quota<T0>(arg0, v0, *v3, arg1.usdc_flp_amount, 5000000000);
                    let v7 = FLPAmountUpdated{
                        flp_id    : 0x2::object::id<FLPObligationOwnerCap<T0>>(arg1),
                        coin_type : *v3,
                        owner_cap : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap>(&arg1.obligation_owner_cap),
                        amount    : arg1.usdc_flp_amount,
                    };
                    0x2::event::emit<FLPAmountUpdated>(v7);
                };
            };
            v2 = v2 + 1;
        };
    }

    public fun unwrap<T0>(arg0: FLPObligationOwnerCap<T0>, arg1: &0x2::tx_context::TxContext) {
        let FLPObligationOwnerCap {
            id                   : v0,
            obligation_owner_cap : v1,
            usdc_flp_amount      : _,
            sui_flp_amount       : _,
        } = arg0;
        let v4 = v1;
        let v5 = FLPAmountPurged{
            flp_id    : 0x2::object::id<FLPObligationOwnerCap<T0>>(&arg0),
            market    : 0x1::type_name::with_defining_ids<T0>(),
            owner_cap : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap>(&v4),
        };
        0x2::event::emit<FLPAmountPurged>(v5);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ObligationOwnerCap>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

