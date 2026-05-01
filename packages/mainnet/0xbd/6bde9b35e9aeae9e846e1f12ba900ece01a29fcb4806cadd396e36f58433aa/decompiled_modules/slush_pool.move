module 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::slush_pool {
    struct SlushStrategies has drop {
        dummy_field: bool,
    }

    struct SlushPool has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct SlushPoolInner has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        total_user_shares: u64,
        user_shares: 0x2::table::Table<address, u64>,
        reward_balance: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        locked_rewards: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        lock_last_compound_ms: u64,
        lock_end_ms: u64,
    }

    struct SlushStrategiesAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun claim_rewards(arg0: &SlushPool, arg1: &mut 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg2: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg3: &SlushStrategiesAdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        load_inner(arg0);
        let v0 = SlushStrategies{dummy_field: false};
        let v1 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::claim_rewards<SlushStrategies>(arg1, arg2, v0, arg4, arg5);
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_rewards_claimed(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public fun cancel_locked_rewards(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1.locked_rewards);
        assert!(v2 > 0, 13906835711942983701);
        v1.lock_last_compound_ms = 0;
        v1.lock_end_ms = 0;
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_rewards_cancelled(v0, v2, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.locked_rewards, v2), arg3)
    }

    public fun compound_rewards(arg0: &mut SlushPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = load_inner_mut(arg0);
        if (v2.lock_end_ms == 0) {
            return
        };
        if (v1 <= v2.lock_last_compound_ms) {
            return
        };
        let v3 = if (v1 >= v2.lock_end_ms) {
            v2.lock_last_compound_ms = 0;
            v2.lock_end_ms = 0;
            0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.locked_rewards)
        } else {
            v2.lock_last_compound_ms = v1;
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.locked_rewards), v1 - v2.lock_last_compound_ms, v2.lock_end_ms - v2.lock_last_compound_ms)
        };
        if (v3 == 0) {
            return
        };
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.reward_balance, 0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.locked_rewards, v3));
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_rewards_deposited(v0, v3, v2.total_user_shares, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.reward_balance), share_price(arg0, arg1), v1);
    }

    public fun deposit_rewards(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg4 >= 1, 13906835505784291345);
        assert!(arg4 <= 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::constants::max_duration_days(), 13906835510079389715);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906835518668144641);
        compound_rewards(arg0, arg2, arg5);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = arg4 * 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::constants::ms_per_day();
        let v4 = load_inner_mut(arg0);
        assert!(v4.total_user_shares > 0, 13906835565913702415);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v4.locked_rewards, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        v4.lock_last_compound_ms = v2;
        v4.lock_end_ms = v2 + v3;
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_rewards_locked(v1, v0, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.locked_rewards), 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.locked_rewards), v3, v4.lock_end_ms, v2);
    }

    public fun disable_version(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906836012590170125);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg2);
    }

    public fun enable_version(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906835986820235275);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::constants::current_version();
        let v1 = SlushPoolInner{
            allowed_versions      : 0x2::vec_set::singleton<u64>(v0),
            total_user_shares     : 0,
            user_shares           : 0x2::table::new<address, u64>(arg0),
            reward_balance        : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            locked_rewards        : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            lock_last_compound_ms : 0,
            lock_end_ms           : 0,
        };
        let v2 = SlushPool{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<SlushPoolInner>(v0, v1, arg0),
        };
        0x2::transfer::share_object<SlushPool>(v2);
        let v3 = SlushStrategiesAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SlushStrategiesAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    fun load_inner(arg0: &SlushPool) : &SlushPoolInner {
        let v0 = 0x2::versioned::load_value<SlushPoolInner>(&arg0.inner);
        let v1 = 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906836231633240073);
        v0
    }

    fun load_inner_mut(arg0: &mut SlushPool) : &mut SlushPoolInner {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        let v1 = 0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906836261698011145);
        v0
    }

    public fun reward_balance_value(arg0: &SlushPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).reward_balance)
    }

    public fun share_price(arg0: &SlushPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool) : u64 {
        let v0 = load_inner(arg0);
        if (v0.total_user_shares == 0) {
            return 0
        };
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::div(0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::entity_principal<SlushStrategies>(arg1) + 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v0.reward_balance), v0.total_user_shares)
    }

    public fun supply(arg0: &mut SlushPool, arg1: &mut 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg2: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906834749868998657);
        compound_rewards(arg0, arg1, arg4);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = total_balance(arg0, arg1);
        let v4 = load_inner_mut(arg0);
        let v5 = if (v4.total_user_shares == 0 || v3 == 0) {
            v0
        } else {
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(v0, v4.total_user_shares, v3)
        };
        assert!(v5 > 0, 13906834809998671875);
        if (0x2::table::contains<address, u64>(&v4.user_shares, v2)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut v4.user_shares, v2);
            *v6 = *v6 + v5;
        } else {
            0x2::table::add<address, u64>(&mut v4.user_shares, v2, v5);
        };
        v4.total_user_shares = v4.total_user_shares + v5;
        let v7 = SlushStrategies{dummy_field: false};
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::entity_supply<SlushStrategies>(arg1, arg2, v7, arg3, arg4);
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_user_supplied(v1, v2, v0, v5, v4.total_user_shares, share_price(arg0, arg1), 0x2::clock::timestamp_ms(arg4));
        v5
    }

    public fun total_balance(arg0: &SlushPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool) : u64 {
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::entity_principal<SlushStrategies>(arg1) + 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).reward_balance)
    }

    public fun total_user_shares(arg0: &SlushPool) : u64 {
        load_inner(arg0).total_user_shares
    }

    public fun user_amount(arg0: &SlushPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg2: address) : u64 {
        let v0 = load_inner(arg0);
        if (!0x2::table::contains<address, u64>(&v0.user_shares, arg2) || v0.total_user_shares == 0) {
            return 0
        };
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(*0x2::table::borrow<address, u64>(&v0.user_shares, arg2), total_balance(arg0, arg1), v0.total_user_shares)
    }

    public fun user_shares(arg0: &SlushPool, arg1: address) : u64 {
        let v0 = load_inner(arg0);
        if (0x2::table::contains<address, u64>(&v0.user_shares, arg1)) {
            *0x2::table::borrow<address, u64>(&v0.user_shares, arg1)
        } else {
            0
        }
    }

    public fun withdraw(arg0: &mut SlushPool, arg1: &mut 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::IronBankPool, arg2: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        assert!(arg3 > 0, 13906834973207429123);
        compound_rewards(arg0, arg1, arg4);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = load_inner_mut(arg0);
        assert!(0x2::table::contains<address, u64>(&v2.user_shares, v1), 13906835016157364231);
        assert!(*0x2::table::borrow<address, u64>(&v2.user_shares, v1) >= arg3, 13906835024747167749);
        if (arg3 == v2.total_user_shares) {
            v2.lock_last_compound_ms = 0;
            v2.lock_end_ms = 0;
        };
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut v2.user_shares, v1);
        *v3 = *v3 - arg3;
        if (*v3 == 0) {
            0x2::table::remove<address, u64>(&mut v2.user_shares, v1);
        };
        let v4 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(arg3, 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::entity_principal<SlushStrategies>(arg1), v2.total_user_shares);
        let v5 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(arg3, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.reward_balance), v2.total_user_shares);
        v2.total_user_shares = v2.total_user_shares - arg3;
        let v6 = if (v4 > 0) {
            let v7 = SlushStrategies{dummy_field: false};
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool::entity_withdraw<SlushStrategies>(arg1, arg2, v7, v4, arg4, arg5)
        } else {
            0x2::coin::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg5)
        };
        let v8 = v6;
        0x2::coin::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v8, 0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.reward_balance, v5), arg5));
        let v9 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v8);
        assert!(v9 > 0, 13906835226610368513);
        0xbd6bde9b35e9aeae9e846e1f12ba900ece01a29fcb4806cadd396e36f58433aa::events::emit_user_withdrew(v0, v1, v9, arg3, v4, v5, v2.total_user_shares, share_price(arg0, arg1), 0x2::clock::timestamp_ms(arg4));
        v8
    }

    // decompiled from Move bytecode v7
}

