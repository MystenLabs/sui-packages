module 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        partners: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    struct Collect has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        source: u64,
    }

    struct Withdraw has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun claim_commission<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::check_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.partners, v1), v0), arg2);
        let v3 = Withdraw{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v2),
            recipient : v1,
        };
        0x2::event::emit<Withdraw>(v3);
        v2
    }

    public(friend) fun collect<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        let v1 = Collect{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
            source    : arg2,
        };
        0x2::event::emit<Collect>(v1);
    }

    public(friend) fun collect_commission<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        collect<T0>(arg0, arg1, 0);
    }

    public fun collect_dust<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::check_version(arg1);
        collect<T0>(arg0, arg2, 3);
    }

    public(friend) fun collect_slippage<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(arg2) > arg3 && arg4 > 0) {
            0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::assert_positive_slippage_bps(arg1, arg4);
            collect<T0>(arg0, 0x2::coin::split<T0>(arg2, 0x1::u64::min(0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::math::pct_bps(arg3, arg4), 0x2::coin::value<T0>(arg2) - arg3), arg5), 1);
        };
    }

    public fun collect_tip<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::check_version(arg1);
        assert!(arg3 <= 100, 0);
        collect<T0>(arg0, 0x2::coin::split<T0>(arg2, 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::math::pct_bps(0x2::coin::value<T0>(arg2), arg3), arg4), 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
            partners : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public(friend) fun take_commision<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::assert_commission_bps(arg1, arg4);
        let v0 = 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::math::pct_bps(0x2::coin::value<T0>(arg2), arg4);
        let v1 = 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::math::pct_bps(v0, 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::protocol_fee_bps(arg1));
        let v2 = v0 - v1;
        collect_commission<T0>(arg0, 0x2::coin::split<T0>(arg2, v1, arg5));
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::utils::transfer_or_destroy<T0>(0x2::coin::split<T0>(arg2, v2, arg5), arg3);
        (v1, v2)
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        let v2 = Withdraw{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v1),
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Withdraw>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

