module 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::allowance {
    struct Allowance<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        total_spent: u64,
        created_at: u64,
        permitted_features: u64,
        expires_at: u64,
        daily_limit: u64,
        daily_spent: u64,
        window_start: u64,
    }

    public fun balance<T0>(arg0: &Allowance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun admin_deposit<T0>(arg0: &mut Allowance<T0>, arg1: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_deposited = arg0.total_deposited + v0;
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_deposited(arg0.owner, v0, 0x2::balance::value<T0>(&arg0.balance));
    }

    public fun create<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1 > 0) {
            assert!(arg1 > v0, 17);
        };
        let v1 = Allowance<T0>{
            id                 : 0x2::object::new(arg4),
            owner              : 0x2::tx_context::sender(arg4),
            balance            : 0x2::balance::zero<T0>(),
            total_deposited    : 0,
            total_spent        : 0,
            created_at         : v0,
            permitted_features : arg0,
            expires_at         : arg1,
            daily_limit        : arg2,
            daily_spent        : 0,
            window_start       : v0,
        };
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_created(0x2::tx_context::sender(arg4), 0x2::object::id<Allowance<T0>>(&v1));
        0x2::transfer::share_object<Allowance<T0>>(v1);
    }

    public fun daily_limit<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.daily_limit
    }

    public fun daily_spent<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.daily_spent
    }

    public fun deduct<T0>(arg0: &mut Allowance<T0>, arg1: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        assert!(!0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::is_paused(arg1), 1);
        assert!(arg3 > 0, 2);
        assert!(arg4 <= 63, 13);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.expires_at > 0) {
            assert!(v0 < arg0.expires_at, 15);
        };
        assert!(arg0.permitted_features & 1 << (arg4 as u8) != 0, 14);
        if (arg0.daily_limit > 0) {
            if (v0 >= arg0.window_start + 86400000) {
                arg0.daily_spent = 0;
                arg0.window_start = v0;
            };
            assert!(arg0.daily_spent + arg3 <= arg0.daily_limit, 16);
            arg0.daily_spent = arg0.daily_spent + arg3;
        };
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 12);
        arg0.total_spent = arg0.total_spent + arg3;
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_deducted(arg0.owner, arg3, arg4, 0x2::balance::value<T0>(&arg0.balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg6), 0x2::tx_context::sender(arg6));
    }

    public fun deposit<T0>(arg0: &mut Allowance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 11);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_deposited(arg0.owner, v0, 0x2::balance::value<T0>(&arg0.balance));
    }

    public fun expires_at<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.expires_at
    }

    public fun is_expired<T0>(arg0: &Allowance<T0>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.expires_at == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun is_feature_permitted<T0>(arg0: &Allowance<T0>, arg1: u8) : bool {
        arg0.permitted_features & 1 << (arg1 as u8) != 0
    }

    public fun owner<T0>(arg0: &Allowance<T0>) : address {
        arg0.owner
    }

    public fun permitted_features<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.permitted_features
    }

    public fun total_deposited<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_spent<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.total_spent
    }

    public fun update_scope<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 11);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2 > 0) {
            assert!(arg2 > v0, 17);
        };
        arg0.permitted_features = arg1;
        arg0.expires_at = arg2;
        if (arg0.daily_limit != arg3) {
            arg0.daily_limit = arg3;
            arg0.daily_spent = 0;
            arg0.window_start = v0;
        };
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_scope_updated(arg0.owner, arg1, arg2, arg3);
    }

    public fun withdraw<T0>(arg0: &mut Allowance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 11);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > 0) {
            0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_withdrawn(arg0.owner, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun withdraw_amount<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 11);
        assert!(arg1 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 12);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_allowance_withdrawn(arg0.owner, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

