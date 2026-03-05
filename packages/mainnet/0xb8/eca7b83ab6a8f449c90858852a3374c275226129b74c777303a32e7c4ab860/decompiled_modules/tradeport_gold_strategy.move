module 0xb8eca7b83ab6a8f449c90858852a3374c275226129b74c777303a32e7c4ab860::tradeport_gold_strategy {
    struct TRADEPORT_GOLD_STRATEGY has drop {
        dummy_field: bool,
    }

    struct GLDSTR has key {
        id: 0x2::object::UID,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        fee_bps: u64,
        locked: bool,
        xaum_pool_fee: u64,
        gldstr_pool_fee: u64,
        xaum: 0x2::balance::Balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>,
    }

    struct StrategyCreatedEvent has copy, drop {
        xaum_total: u64,
        gldstr_total: u64,
    }

    struct StrategyAppliedEvent has copy, drop {
        usdc_spent: u64,
        xaum_purchased: u64,
        xaum_total: u64,
        gldstr_total: u64,
    }

    struct RedeemedEvent has copy, drop {
        gldstr_burned: u64,
        xaum_redeemed: u64,
        xaum_total: u64,
        gldstr_total: u64,
    }

    public fun apply_strategy(arg0: &mut Manager, arg1: &mut 0x2::coin_registry::Currency<GLDSTR>, arg2: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool_manager::PoolRegistry, arg3: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(arg0.locked == false, 1);
        let (v0, v1) = if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::is_ordered<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, GLDSTR>()) {
            0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool::withdraw_strategy_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, GLDSTR>(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool_manager::borrow_mut_pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, GLDSTR>(arg2, arg0.gldstr_pool_fee), &arg0.id, arg3, arg5)
        } else {
            let (v2, v3) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool::withdraw_strategy_balance<GLDSTR, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool_manager::borrow_mut_pool<GLDSTR, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0.gldstr_pool_fee), &arg0.id, arg3, arg5);
            (v3, v2)
        };
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::balance::value<GLDSTR>(&v4) == 0, 2);
        0x2::balance::destroy_zero<GLDSTR>(v4);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5) > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, (((0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5) as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)));
            let v6 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::swap_router::swap_exact_input<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(arg2, arg0.xaum_pool_fee, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5, arg5), 0, 0, 18446744073709551615, arg3, arg4, arg5);
            0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum, 0x2::coin::into_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(v6));
            let v7 = 0x2::coin_registry::total_supply<GLDSTR>(arg1);
            let v8 = StrategyAppliedEvent{
                usdc_spent     : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5),
                xaum_purchased : 0x2::coin::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&v6),
                xaum_total     : 0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum),
                gldstr_total   : *0x1::option::borrow<u64>(&v7),
            };
            0x2::event::emit<StrategyAppliedEvent>(v8);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5);
        };
    }

    public fun create_strategy(arg0: &mut Manager, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<GLDSTR>, 0x2::coin_registry::MetadataCap<GLDSTR>) {
        verify_version(arg0);
        verify_admin(arg0, arg9);
        let (v0, v1) = 0x2::coin_registry::new_currency<GLDSTR>(arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GLDSTR>(&mut v3, v2);
        0x2::balance::join<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum, 0x2::coin::into_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(arg8));
        let v4 = StrategyCreatedEvent{
            xaum_total   : 0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum),
            gldstr_total : arg7,
        };
        0x2::event::emit<StrategyCreatedEvent>(v4);
        (0x2::coin::mint<GLDSTR>(&mut v2, arg7, arg9), 0x2::coin_registry::finalize<GLDSTR>(v3, arg9))
    }

    fun init(arg0: TRADEPORT_GOLD_STRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Manager{
            id              : 0x2::object::new(arg1),
            version         : 0,
            admin           : 0x2::tx_context::sender(arg1),
            fee             : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            fee_bps         : 2000,
            locked          : false,
            xaum_pool_fee   : 0,
            gldstr_pool_fee : 0,
            xaum            : 0x2::balance::zero<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    public fun redeem(arg0: &mut Manager, arg1: &mut 0x2::coin_registry::Currency<GLDSTR>, arg2: 0x2::coin::Coin<GLDSTR>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM> {
        verify_version(arg0);
        assert!(arg0.locked == false, 1);
        let v0 = 0x2::coin_registry::total_supply<GLDSTR>(arg1);
        let v1 = 0x2::coin::value<GLDSTR>(&arg2);
        let v2 = (((0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum) as u128) * (v1 as u128) / (*0x1::option::borrow<u64>(&v0) as u128)) as u64);
        assert!(v1 > 0 && v2 > 0, 3);
        0x2::coin_registry::burn<GLDSTR>(arg1, arg2);
        let v3 = 0x2::coin_registry::total_supply<GLDSTR>(arg1);
        let v4 = RedeemedEvent{
            gldstr_burned : v1,
            xaum_redeemed : v2,
            xaum_total    : 0x2::balance::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg0.xaum),
            gldstr_total  : *0x1::option::borrow<u64>(&v3),
        };
        0x2::event::emit<RedeemedEvent>(v4);
        0x2::coin::from_balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(0x2::balance::split<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&mut arg0.xaum, v2), arg3)
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee_bps(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.fee_bps = arg1;
    }

    entry fun set_gldstr_pool_fee(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.gldstr_pool_fee = arg1;
    }

    entry fun set_locked(arg0: &mut Manager, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.locked = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    entry fun set_xaum_pool_fee(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.xaum_pool_fee = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version <= 1, 6);
    }

    entry fun withdraw_fee(arg0: &mut Manager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee) >= arg1, 4);
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee, arg1), arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee, arg1), arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

