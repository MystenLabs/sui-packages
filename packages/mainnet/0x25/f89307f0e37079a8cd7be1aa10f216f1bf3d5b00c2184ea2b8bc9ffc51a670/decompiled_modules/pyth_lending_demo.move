module 0x25f89307f0e37079a8cd7be1aa10f216f1bf3d5b00c2184ea2b8bc9ffc51a670::pyth_lending_demo {
    struct LendingMarket has key {
        id: 0x2::object::UID,
        asset: 0x1::string::String,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        policy: 0x1::option::Option<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>,
    }

    struct ShortfallCovered has copy, drop {
        asset: 0x1::string::String,
        payout: u64,
    }

    public fun asset(arg0: &LendingMarket) : 0x1::string::String {
        arg0.asset
    }

    public fun cover_shortfall(arg0: &mut LendingMarket, arg1: &mut 0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::DepegCoverPool<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&arg0.policy), 1);
        let v0 = 0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::claim_latched<0x2::sui::SUI>(arg1, 0x1::option::extract<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&mut arg0.policy), arg2);
        let v1 = ShortfallCovered{
            asset  : arg0.asset,
            payout : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<ShortfallCovered>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
    }

    public fun create_and_share(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LendingMarket>(new_market(0x1::string::utf8(arg0), arg1));
    }

    public fun deposit_reserve(arg0: &mut LendingMarket, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun insure(arg0: &mut LendingMarket, arg1: &mut 0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::DepegCoverPool<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x1::option::is_none<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&arg0.policy), 0);
        let (v0, v1) = 0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::buy_cover<0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x1::option::fill<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&mut arg0.policy, v0);
        v1
    }

    public fun is_insured(arg0: &LendingMarket) : bool {
        0x1::option::is_some<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&arg0.policy)
    }

    public fun new_market(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : LendingMarket {
        LendingMarket{
            id      : 0x2::object::new(arg1),
            asset   : arg0,
            reserve : 0x2::balance::zero<0x2::sui::SUI>(),
            policy  : 0x1::option::none<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(),
        }
    }

    public fun record_shortfall(arg0: &mut LendingMarket, arg1: &mut 0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::DepegCoverPool<0x2::sui::SUI>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&arg0.policy), 1);
        0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::record_breach<0x2::sui::SUI>(arg1, 0x1::option::borrow_mut<0x4f8d00eb76a59996a0c88f3d103e950e6e4c02132acb8483cc8e1450005f04e9::pyth_cover_pool::Policy<0x2::sui::SUI>>(&mut arg0.policy), arg2, arg3, arg4);
    }

    public fun reserve_value(arg0: &LendingMarket) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve)
    }

    // decompiled from Move bytecode v7
}

