module 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::buy_bundle {
    struct BuyBundle<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        creator: address,
        target: u64,
        deadline_ms: u64,
        total: u64,
        money: 0x2::balance::Balance<T1>,
        state: u8,
        filled_ms: u64,
        last_buy_ms: u64,
        fee_bps: u64,
        spent_q: u64,
        bought_t: u64,
        deposit: 0x1::option::Option<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>,
        open_total: u64,
    }

    struct Commit<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        amount: u64,
    }

    struct BuyBundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        creator: address,
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        target: u64,
        deadline_ms: u64,
    }

    struct BuyCommitted has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        committed: u64,
        full: bool,
    }

    struct BuyFilled has copy, drop {
        bundle_id: 0x2::object::ID,
        total: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    struct BuyRefundStarted has copy, drop {
        bundle_id: 0x2::object::ID,
        total: u64,
        timestamp_ms: u64,
    }

    struct BuyRefunded has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        backer: address,
        amount: u64,
    }

    struct Bought has copy, drop {
        bundle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        quote: u64,
        fee: u64,
        tokens: u64,
        shares: u64,
        money_left: u64,
        timestamp_ms: u64,
    }

    struct BuyDone has copy, drop {
        bundle_id: 0x2::object::ID,
        spent_q: u64,
        bought_t: u64,
        shares: u64,
        money_left: u64,
        timestamp_ms: u64,
    }

    struct BuyClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        shares: u64,
        quote: u64,
    }

    fun after_buy<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &mut 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 616);
        let v1 = fee_of(arg4, arg0.fee_bps);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.money, v1), arg8), 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::fee_recipient(arg2));
        };
        let v2 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::deposit_at<T0, T1>(arg1, arg3, arg5, arg6, arg7, arg8);
        if (0x1::option::is_some<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&arg0.deposit)) {
            0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::merge<T0, T1>(0x1::option::borrow_mut<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&mut arg0.deposit), v2);
        } else {
            0x1::option::fill<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&mut arg0.deposit, v2);
        };
        arg0.last_buy_ms = arg7;
        arg0.spent_q = arg0.spent_q + arg4;
        arg0.bought_t = arg0.bought_t + v0;
        let v3 = Bought{
            bundle_id    : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
            vault_id     : arg0.vault_id,
            quote        : arg4,
            fee          : v1,
            tokens       : v0,
            shares       : 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::deposit_shares<T0, T1>(&v2),
            money_left   : 0x2::balance::value<T1>(&arg0.money),
            timestamp_ms : arg7,
        };
        0x2::event::emit<Bought>(v3);
        if (0x2::balance::value<T1>(&arg0.money) <= 1 || 0x2::balance::value<T1>(&arg0.money) < min_step_money(arg0.fee_bps)) {
            finish<T0, T1>(arg0, arg7);
        };
    }

    fun before_buy<T0, T1>(arg0: &BuyBundle<T0, T1>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u128 {
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_version(arg2);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_keeper(arg2, arg6);
        assert!(arg0.state == 1, 609);
        assert!(0x2::object::id<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>>(arg1) == arg0.vault_id, 600);
        assert!(arg0.last_buy_ms == 0 || arg5 >= arg0.last_buy_ms + 60000, 610);
        assert!(arg4 > 0 && (arg4 as u128) + (fee_of(arg4, arg0.fee_bps) as u128) <= (0x2::balance::value<T1>(&arg0.money) as u128), 607);
        let v0 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::reference<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1), arg5);
        let (_, _, v3, _, _) = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::terms<T0, T1>(arg1);
        assert!(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::limits::within_deviation(arg3, v0, v3), 612);
        assert!((arg4 as u128) <= 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::max_size_at<T0, T1>(arg1, v0, arg5) / 20, 611);
        let v6 = sqrt_limit(v0, v3);
        assert!(arg3 < v6, 612);
        v6
    }

    public fun buy_bluefin<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &mut 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::assert_pool_id<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), 0);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::assert_can_deposit<T0, T1>(arg1, arg2);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::collect<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg7);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg3, arg4, false, true, arg5, before_buy<T0, T1>(arg0, arg1, arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), arg5, v0, arg7));
        let v4 = v3;
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.money, v5), v4);
        0x2::balance::destroy_zero<T1>(v2);
        after_buy<T0, T1>(arg0, arg1, arg2, v1, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), v0, arg7);
    }

    public fun buy_cetus<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &mut 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(!0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::quote_first<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1)), 615);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::assert_pool_id<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 1);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::assert_can_deposit<T0, T1>(arg1, arg2);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault_cetus::collect<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, false, true, arg5, before_buy<T0, T1>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), arg5, v0, arg7), arg6);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.money, v5), v4);
        0x2::balance::destroy_zero<T1>(v2);
        after_buy<T0, T1>(arg0, arg1, arg2, v1, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg4), v0, arg7);
    }

    public fun buy_cetus_qf<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &mut 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::quote_first<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1)), 615);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::assert_pool_id<T0, T1>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::book_ref<T0, T1>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), 1);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::assert_can_deposit<T0, T1>(arg1, arg2);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault_cetus::collect_qf<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg3, arg4, true, true, arg5, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book_cetus::flip_sqrt(before_buy<T0, T1>(arg0, arg1, arg2, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book_cetus::spot_qf<T0, T1>(arg4), arg5, v0, arg7)), arg6);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg3, arg4, 0x2::balance::split<T1>(&mut arg0.money, v5), 0x2::balance::zero<T0>(), v4);
        0x2::balance::destroy_zero<T1>(v1);
        after_buy<T0, T1>(arg0, arg1, arg2, v2, v5, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book_cetus::spot_qf<T0, T1>(arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T0>(arg4), v0, arg7);
    }

    public fun claim<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: Commit<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.state == 2, 613);
        let Commit {
            id        : v0,
            bundle_id : v1,
            amount    : v2,
        } = arg1;
        let v3 = v0;
        assert!(v1 == 0x2::object::id<BuyBundle<T0, T1>>(arg0), 614);
        let v4 = v2 == arg0.open_total;
        let v5 = if (0x1::option::is_some<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&arg0.deposit)) {
            0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::deposit_shares<T0, T1>(0x1::option::borrow<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&arg0.deposit))
        } else {
            0
        };
        let v6 = if (v4) {
            v5
        } else {
            mul_div(v5, v2, arg0.open_total)
        };
        let v7 = if (v4) {
            0x2::balance::value<T1>(&arg0.money)
        } else {
            mul_div(0x2::balance::value<T1>(&arg0.money), v2, arg0.open_total)
        };
        if (v4 && v5 > 0) {
            0x2::transfer::public_transfer<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(0x1::option::extract<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&mut arg0.deposit), 0x2::tx_context::sender(arg2));
        } else if (v6 > 0) {
            0x2::transfer::public_transfer<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::split<T0, T1>(0x1::option::borrow_mut<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&mut arg0.deposit), v6, arg2), 0x2::tx_context::sender(arg2));
        };
        arg0.open_total = arg0.open_total - v2;
        let v8 = BuyClaimed{
            bundle_id : v1,
            commit_id : 0x2::object::uid_to_inner(&v3),
            backer    : 0x2::tx_context::sender(arg2),
            amount    : v2,
            shares    : v6,
            quote     : v7,
        };
        0x2::event::emit<BuyClaimed>(v8);
        0x2::object::delete(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.money, v7), arg2)
    }

    public fun commit<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Commit<T0, T1>, 0x2::coin::Coin<T1>) {
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_open<T1>(arg1);
        commit_internal<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public fun commit_amount<T0, T1>(arg0: &Commit<T0, T1>) : u64 {
        arg0.amount
    }

    fun commit_internal<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Commit<T0, T1>, 0x2::coin::Coin<T1>) {
        assert!(arg0.state == 0, 605);
        assert!(arg3 < arg0.deadline_ms, 606);
        let v0 = arg0.target - arg0.total;
        let v1 = 0x1::u64::min(0x2::coin::value<T1>(&arg2), v0);
        assert!(v1 > 0, 607);
        assert!(v1 == v0 || v1 >= mul_div(arg0.target, 10, 10000), 617);
        0x2::balance::join<T1>(&mut arg0.money, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v1, arg4)));
        arg0.total = arg0.total + v1;
        let v2 = arg0.total == arg0.target;
        let v3 = Commit<T0, T1>{
            id        : 0x2::object::new(arg4),
            bundle_id : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
            amount    : v1,
        };
        let v4 = BuyCommitted{
            bundle_id : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
            commit_id : 0x2::object::id<Commit<T0, T1>>(&v3),
            backer    : 0x2::tx_context::sender(arg4),
            amount    : v1,
            committed : arg0.total,
            full      : v2,
        };
        0x2::event::emit<BuyCommitted>(v4);
        if (v2) {
            arg0.state = 1;
            arg0.filled_ms = arg3;
            arg0.open_total = arg0.total;
            let v5 = BuyFilled{
                bundle_id    : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
                total        : arg0.total,
                fee          : 0,
                timestamp_ms : arg3,
            };
            0x2::event::emit<BuyFilled>(v5);
        };
        (v3, arg2)
    }

    public fun create<T0, T1>(arg0: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Commit<T0, T1> {
        let v0 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_open<T1>(arg0);
        let v1 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::open_params<T0, T1>(arg0);
        assert!(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::open_enabled(&v1), 601);
        assert!(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::open_vault_id<T0, T1>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>>(arg1)), 600);
        assert!(arg2 >= 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::min_target(&v0) && arg2 <= 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::max_target(&v0), 602);
        let (v2, v3) = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::duration_bounds();
        assert!(arg3 >= v2 && arg3 <= v3, 603);
        assert!(0x2::coin::value<T1>(&arg4) >= mul_div(arg2, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::min_first_bps(), 10000), 604);
        let v4 = BuyBundle<T0, T1>{
            id          : 0x2::object::new(arg6),
            vault_id    : 0x2::object::id<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::OpenVault<T0, T1>>(arg1),
            creator     : 0x2::tx_context::sender(arg6),
            target      : arg2,
            deadline_ms : 0x2::clock::timestamp_ms(arg5) + arg3,
            total       : 0,
            money       : 0x2::balance::zero<T1>(),
            state       : 0,
            filled_ms   : 0,
            last_buy_ms : 0,
            fee_bps     : 100,
            spent_q     : 0,
            bought_t    : 0,
            deposit     : 0x1::option::none<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(),
            open_total  : 0,
        };
        let v5 = BuyBundleCreated{
            bundle_id   : 0x2::object::id<BuyBundle<T0, T1>>(&v4),
            vault_id    : v4.vault_id,
            creator     : v4.creator,
            token       : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote       : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            target      : arg2,
            deadline_ms : v4.deadline_ms,
        };
        0x2::event::emit<BuyBundleCreated>(v5);
        let v6 = &mut v4;
        let (v7, v8) = commit_internal<T0, T1>(v6, arg0, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        let v9 = v8;
        if (0x2::coin::value<T1>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T1>(v9);
        };
        0x2::transfer::share_object<BuyBundle<T0, T1>>(v4);
        v7
    }

    public fun end_buying<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.state == 1, 609);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.filled_ms + 259200000, 610);
        finish<T0, T1>(arg0, v0);
    }

    public fun fee_bps() : u64 {
        100
    }

    public fun fee_of(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    fun finish<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: u64) {
        arg0.state = 2;
        let v0 = if (0x1::option::is_some<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&arg0.deposit)) {
            0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::deposit_shares<T0, T1>(0x1::option::borrow<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::Deposit<T0, T1>>(&arg0.deposit))
        } else {
            0
        };
        let v1 = BuyDone{
            bundle_id    : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
            spent_q      : arg0.spent_q,
            bought_t     : arg0.bought_t,
            shares       : v0,
            money_left   : 0x2::balance::value<T1>(&arg0.money),
            timestamp_ms : arg1,
        };
        0x2::event::emit<BuyDone>(v1);
    }

    public fun min_step_money(arg0: u64) : u64 {
        ((((0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::open_vault::min_deposit_value() as u128) * ((10000 + arg0 + 300) as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun money<T0, T1>(arg0: &BuyBundle<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.money)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun refund<T0, T1>(arg0: &mut BuyBundle<T0, T1>, arg1: Commit<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.state == 0 && v0 >= arg0.deadline_ms) {
            arg0.state = 3;
            let v1 = BuyRefundStarted{
                bundle_id    : 0x2::object::id<BuyBundle<T0, T1>>(arg0),
                total        : arg0.total,
                timestamp_ms : v0,
            };
            0x2::event::emit<BuyRefundStarted>(v1);
        };
        assert!(arg0.state == 3, 608);
        let Commit {
            id        : v2,
            bundle_id : v3,
            amount    : v4,
        } = arg1;
        let v5 = v2;
        assert!(v3 == 0x2::object::id<BuyBundle<T0, T1>>(arg0), 614);
        let v6 = BuyRefunded{
            bundle_id : v3,
            commit_id : 0x2::object::uid_to_inner(&v5),
            backer    : 0x2::tx_context::sender(arg3),
            amount    : v4,
        };
        0x2::event::emit<BuyRefunded>(v6);
        0x2::object::delete(v5);
        arg0.total = arg0.total - v4;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.money, v4), arg3)
    }

    public fun sqrt_limit(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg1 as u256);
        let v1 = (10000 as u256) * (10000 as u256) * 8;
        (((arg0 as u256) * (v1 + v0 * (10000 as u256) * 4 - v0 * v0) / v1) as u128)
    }

    public fun state<T0, T1>(arg0: &BuyBundle<T0, T1>) : u8 {
        arg0.state
    }

    public fun total<T0, T1>(arg0: &BuyBundle<T0, T1>) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v7
}

