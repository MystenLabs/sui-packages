module 0x729e11856afe3d1f7678366b7fbcbe8af0aecb623cc0277f372a5b95fa6a3b2e::pyth_lending_demo {
    struct LendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        asset: 0x1::string::String,
        reserve: 0x2::balance::Balance<T0>,
        buyer_cap: 0x1::option::Option<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>,
        policy: 0x1::option::Option<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>,
    }

    struct MarketCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct ShortfallCovered has copy, drop {
        asset: 0x1::string::String,
        payout: u64,
    }

    public fun asset<T0>(arg0: &LendingMarket<T0>) : 0x1::string::String {
        arg0.asset
    }

    public fun cover_shortfall<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::DepegCoverPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&arg0.policy), 1);
        let v0 = 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::claim_latched<T0>(arg1, 0x1::option::extract<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&mut arg0.policy), arg2);
        let v1 = ShortfallCovered{
            asset  : arg0.asset,
            payout : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<ShortfallCovered>(v1);
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(v0));
    }

    public fun create_and_share<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_market<T0>(0x1::string::utf8(arg0), arg1);
        let v1 = MarketCap<T0>{
            id        : 0x2::object::new(arg1),
            market_id : 0x2::object::id<LendingMarket<T0>>(&v0),
        };
        0x2::transfer::transfer<MarketCap<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LendingMarket<T0>>(v0);
    }

    public fun deposit_reserve<T0>(arg0: &mut LendingMarket<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun has_buyer_cap<T0>(arg0: &LendingMarket<T0>) : bool {
        0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(&arg0.buyer_cap)
    }

    public fun install_buyer_cap<T0>(arg0: &mut LendingMarket<T0>, arg1: 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>) {
        assert!(0x1::option::is_none<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(&arg0.buyer_cap), 2);
        0x1::option::fill<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(&mut arg0.buyer_cap, arg1);
    }

    public fun insure<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::DepegCoverPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::option::is_none<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&arg0.policy), 0);
        assert!(0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(&arg0.buyer_cap), 3);
        let (v0, v1) = 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::buy_cover_with_cap<T0>(arg1, 0x1::option::borrow<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(&arg0.buyer_cap), arg2, arg3, arg4, arg5, arg6, arg7);
        0x1::option::fill<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&mut arg0.policy, v0);
        v1
    }

    public fun is_insured<T0>(arg0: &LendingMarket<T0>) : bool {
        0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&arg0.policy)
    }

    public fun new_market<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : LendingMarket<T0> {
        LendingMarket<T0>{
            id        : 0x2::object::new(arg1),
            asset     : arg0,
            reserve   : 0x2::balance::zero<T0>(),
            buyer_cap : 0x1::option::none<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::BuyerCap<T0>>(),
            policy    : 0x1::option::none<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(),
        }
    }

    public fun record_shortfall<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::DepegCoverPool<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&arg0.policy), 1);
        0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::record_breach<T0>(arg1, 0x1::option::borrow_mut<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&mut arg0.policy), arg2, arg3, arg4);
    }

    public fun release_expired_policy<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::DepegCoverPool<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&arg0.policy), 1);
        0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::expire_policy<T0>(arg1, 0x1::option::extract<0x3ec312b1173922dfe6d5866741299f4525c135fa90709a39ddb0a0f7e8baccb5::pyth_cover_pool::Policy<T0>>(&mut arg0.policy), arg2);
    }

    public fun reserve_value<T0>(arg0: &LendingMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun withdraw_reserve<T0>(arg0: &mut LendingMarket<T0>, arg1: &MarketCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.market_id == 0x2::object::id<LendingMarket<T0>>(arg0), 4);
        0x2::coin::take<T0>(&mut arg0.reserve, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

