module 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::slush_pool {
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
        yield_balance: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        locked_yield: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        lock_last_compound_ms: u64,
        lock_end_ms: u64,
    }

    struct SlushStrategiesAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun cancel_locked_yield(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1.locked_yield);
        assert!(v2 > 0, 13906835707648016405);
        v1.lock_last_compound_ms = 0;
        v1.lock_end_ms = 0;
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_yield_cancelled(v0, v2, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.locked_yield, v2), arg3)
    }

    public fun claim_yield(arg0: &SlushPool, arg1: &mut 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg3: &SlushStrategiesAdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        load_inner(arg0);
        let v0 = SlushStrategies{dummy_field: false};
        let v1 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::claim_incentives<SlushStrategies>(arg1, arg2, v0, arg4, arg5);
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_yield_claimed(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public fun compound_yield(arg0: &mut SlushPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg2: &0x2::clock::Clock) {
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
            0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.locked_yield)
        } else {
            v2.lock_last_compound_ms = v1;
            0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.locked_yield), v1 - v2.lock_last_compound_ms, v2.lock_end_ms - v2.lock_last_compound_ms)
        };
        if (v3 == 0) {
            return
        };
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.yield_balance, 0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.locked_yield, v3));
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_yield_deposited(v0, v3, v2.total_user_shares, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.yield_balance), share_price(arg0, arg1), v1);
    }

    public fun deposit_yield(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg4 >= 1, 13906835501489324049);
        assert!(arg4 <= 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::constants::max_duration_days(), 13906835505784422419);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906835514373177345);
        compound_yield(arg0, arg2, arg5);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = arg4 * 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::constants::ms_per_day();
        let v4 = load_inner_mut(arg0);
        assert!(v4.total_user_shares > 0, 13906835561618735119);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v4.locked_yield, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        v4.lock_last_compound_ms = v2;
        v4.lock_end_ms = v2 + v3;
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_yield_locked(v1, v0, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.locked_yield), 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.locked_yield), v3, v4.lock_end_ms, v2);
    }

    public fun disable_version(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906836008295202829);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg2);
    }

    public fun enable_version(arg0: &mut SlushPool, arg1: &SlushStrategiesAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906835982525267979);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::constants::current_version();
        let v1 = SlushPoolInner{
            allowed_versions      : 0x2::vec_set::singleton<u64>(v0),
            total_user_shares     : 0,
            user_shares           : 0x2::table::new<address, u64>(arg0),
            yield_balance         : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            locked_yield          : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
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
        let v1 = 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906836223043305481);
        v0
    }

    fun load_inner_mut(arg0: &mut SlushPool) : &mut SlushPoolInner {
        let v0 = 0x2::versioned::load_value_mut<SlushPoolInner>(&mut arg0.inner);
        let v1 = 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906836253108076553);
        v0
    }

    public fun share_price(arg0: &SlushPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool) : u64 {
        let v0 = load_inner(arg0);
        if (v0.total_user_shares == 0) {
            return 0
        };
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::div(0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::entity_principal<SlushStrategies>(arg1) + 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v0.yield_balance), v0.total_user_shares)
    }

    public fun supply(arg0: &mut SlushPool, arg1: &mut 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906834749868998657);
        compound_yield(arg0, arg1, arg4);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = total_balance(arg0, arg1);
        let v4 = load_inner_mut(arg0);
        let v5 = if (v4.total_user_shares == 0 || v3 == 0) {
            v0
        } else {
            0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(v0, v4.total_user_shares, v3)
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
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::entity_supply<SlushStrategies>(arg1, arg2, v7, arg3, arg4);
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_user_supplied(v1, v2, v0, v5, v4.total_user_shares, share_price(arg0, arg1), 0x2::clock::timestamp_ms(arg4));
        v5
    }

    public fun total_balance(arg0: &SlushPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool) : u64 {
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::entity_principal<SlushStrategies>(arg1) + 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).yield_balance)
    }

    public fun total_user_shares(arg0: &SlushPool) : u64 {
        load_inner(arg0).total_user_shares
    }

    public fun user_amount(arg0: &SlushPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg2: address) : u64 {
        let v0 = load_inner(arg0);
        if (!0x2::table::contains<address, u64>(&v0.user_shares, arg2) || v0.total_user_shares == 0) {
            return 0
        };
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(*0x2::table::borrow<address, u64>(&v0.user_shares, arg2), total_balance(arg0, arg1), v0.total_user_shares)
    }

    public fun user_shares(arg0: &SlushPool, arg1: address) : u64 {
        let v0 = load_inner(arg0);
        if (0x2::table::contains<address, u64>(&v0.user_shares, arg1)) {
            *0x2::table::borrow<address, u64>(&v0.user_shares, arg1)
        } else {
            0
        }
    }

    public fun withdraw(arg0: &mut SlushPool, arg1: &mut 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::IronBankPool, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        assert!(arg3 > 0, 13906834973207429123);
        compound_yield(arg0, arg1, arg4);
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
        let v4 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(arg3, 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::entity_principal<SlushStrategies>(arg1), v2.total_user_shares);
        let v5 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(arg3, 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.yield_balance), v2.total_user_shares);
        v2.total_user_shares = v2.total_user_shares - arg3;
        let v6 = if (v4 > 0) {
            let v7 = SlushStrategies{dummy_field: false};
            0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool::entity_withdraw<SlushStrategies>(arg1, arg2, v7, v4, arg4, arg5)
        } else {
            0x2::coin::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg5)
        };
        let v8 = v6;
        0x2::coin::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v8, 0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.yield_balance, v5), arg5));
        let v9 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v8);
        assert!(v9 > 0, 13906835226610368513);
        0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events::emit_user_withdrew(v0, v1, v9, arg3, v4, v5, v2.total_user_shares, share_price(arg0, arg1), 0x2::clock::timestamp_ms(arg4));
        v8
    }

    public fun yield_balance_value(arg0: &SlushPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).yield_balance)
    }

    // decompiled from Move bytecode v7
}

