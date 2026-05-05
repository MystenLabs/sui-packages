module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_market {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        owner: address,
        backing_type: 0x1::type_name::TypeName,
        maturity_ms: u64,
        initial_rate: u64,
    }

    struct SplitOpened has copy, drop {
        market_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        owner: address,
        backing_amount: u64,
        face_value: u64,
        initial_rate: u64,
    }

    struct FinalizationStarted has copy, drop {
        market_id: 0x2::object::ID,
        backing_amount: u64,
        total_face_outstanding: u64,
    }

    struct MarketFinalized has copy, drop {
        market_id: 0x2::object::ID,
        final_rate: u64,
        final_value: u64,
        principal_pool: u64,
        yield_pool: u64,
    }

    struct PtRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        face_amount: u64,
        payout: u64,
    }

    struct YtRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        face_amount: u64,
        payout: u64,
    }

    struct EarlyExited has copy, drop {
        market_id: 0x2::object::ID,
        exiter: address,
        face_amount: u64,
        backing_returned: u64,
    }

    public fun begin_finalize<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: &0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry::AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::FinalizeReceipt<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg0), 2);
        let (v0, v1) = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::begin_finalize<T0>(arg0);
        let v2 = v1;
        let v3 = FinalizationStarted{
            market_id              : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0),
            backing_amount         : 0x2::balance::value<T0>(&v2),
            total_face_outstanding : 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::total_face_outstanding<T0>(arg0),
        };
        0x2::event::emit<FinalizationStarted>(v3);
        (v0, 0x2::coin::from_balance<T0>(v2, arg3))
    }

    public fun complete_finalize<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::FinalizeReceipt<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry::AdminCap) {
        let (v0, v1, v2) = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::complete_finalize<T0>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v3 = MarketFinalized{
            market_id      : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0),
            final_rate     : v2,
            final_value    : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            principal_pool : v0,
            yield_pool     : v1,
        };
        0x2::event::emit<MarketFinalized>(v3);
    }

    public fun create_market<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry::YieldRegistry, arg1: &0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry::AdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4), 1);
        assert!(arg3 >= 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math::rate_scale(), 4);
        assert!(arg3 <= 5000000000, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::new_market<T0>(v0, arg2, arg3, arg5);
        let v2 = 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(&v1);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::share<T0>(v1);
        let v3 = MarketCreated{
            market_id    : v2,
            owner        : v0,
            backing_type : 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry::register_market<T0>(arg0, v2, arg2, arg3),
            maturity_ms  : arg2,
            initial_rate : arg3,
        };
        0x2::event::emit<MarketCreated>(v3);
    }

    public fun delete_receipt<T0>(arg0: 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::SplitReceipt, arg1: &0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg1), 2);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::destroy(arg0, 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg1));
    }

    public fun early_exit<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::MintAuthority, arg2: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::MintAuthority, arg3: 0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::PRINCIPAL_TOKEN>, arg4: 0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::YIELD_TOKEN>, arg5: 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::SplitReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg6) < 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg0), 3);
        let v0 = 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0);
        let v1 = 0x2::coin::value<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::PRINCIPAL_TOKEN>(&arg3);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::burn(arg1, arg3);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::burn(arg2, arg4);
        let v2 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::withdraw_backing_for_early_exit<T0>(arg0, v1, 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::consume_for_early_exit(arg5, v0, v1, 0x2::coin::value<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::YIELD_TOKEN>(&arg4)));
        let v3 = EarlyExited{
            market_id        : v0,
            exiter           : 0x2::tx_context::sender(arg7),
            face_amount      : v1,
            backing_returned : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<EarlyExited>(v3);
        0x2::coin::from_balance<T0>(v2, arg7)
    }

    public fun redeem_pt<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::MintAuthority, arg2: 0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::PRINCIPAL_TOKEN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg0), 2);
        let v0 = 0x2::coin::value<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::PRINCIPAL_TOKEN>(&arg2);
        assert!(v0 > 0, 0);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::burn(arg1, arg2);
        let v1 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::withdraw_principal<T0>(arg0, v0);
        let v2 = PtRedeemed{
            market_id   : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0),
            redeemer    : 0x2::tx_context::sender(arg4),
            face_amount : v0,
            payout      : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<PtRedeemed>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4)
    }

    public fun redeem_yt<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::MintAuthority, arg2: 0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::YIELD_TOKEN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg0), 2);
        let v0 = 0x2::coin::value<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::YIELD_TOKEN>(&arg2);
        assert!(v0 > 0, 0);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::burn(arg1, arg2);
        let v1 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::withdraw_yield<T0>(arg0, v0);
        let v2 = YtRedeemed{
            market_id   : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0),
            redeemer    : 0x2::tx_context::sender(arg4),
            face_amount : v0,
            payout      : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<YtRedeemed>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4)
    }

    public fun split<T0>(arg0: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>, arg1: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::MintAuthority, arg2: &mut 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::MintAuthority, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::PRINCIPAL_TOKEN>, 0x2::coin::Coin<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::YIELD_TOKEN>, 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::SplitReceipt) {
        assert!(0x2::clock::timestamp_ms(arg4) < 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::maturity_ms<T0>(arg0), 3);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0);
        let v1 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::initial_rate<T0>(arg0);
        let v2 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math::face_from_backing(v0, v1);
        assert!(v2 > 0, 0);
        0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::deposit_backing<T0>(arg0, 0x2::coin::into_balance<T0>(arg3), v2);
        let v3 = 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::new(0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0), v2, v0, v1, arg5);
        let v4 = SplitOpened{
            market_id      : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_position::YieldPosition<T0>>(arg0),
            receipt_id     : 0x2::object::id<0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt::SplitReceipt>(&v3),
            owner          : 0x2::tx_context::sender(arg5),
            backing_amount : v0,
            face_value     : v2,
            initial_rate   : v1,
        };
        0x2::event::emit<SplitOpened>(v4);
        (0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token::mint(arg1, v2, arg5), 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_token::mint(arg2, v2, arg5), v3)
    }

    // decompiled from Move bytecode v7
}

