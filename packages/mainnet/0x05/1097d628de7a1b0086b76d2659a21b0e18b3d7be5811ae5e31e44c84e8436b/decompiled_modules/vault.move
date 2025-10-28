module 0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct Collect has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        source: u64,
        address: address,
    }

    struct Withdraw has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public(friend) fun collect<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        let v1 = Collect{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
            source    : arg2,
            address   : arg3,
        };
        0x2::event::emit<Collect>(v1);
    }

    public fun collect_fixed<T0>(arg0: &mut Vault, arg1: &0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: address) {
        0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::check_version(arg1);
        collect<T0>(arg0, arg2, 0, arg3);
    }

    public fun collect_rate<T0>(arg0: &mut Vault, arg1: &0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::check_version(arg1);
        assert!(arg3 <= 10000, 0);
        collect<T0>(arg0, 0x2::coin::split<T0>(arg2, 0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::math::pct_bps(0x2::coin::value<T0>(arg2), arg3), arg5), 1, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::Config, arg2: &0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config::check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg3);
        let v2 = Withdraw{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v1),
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdraw>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

