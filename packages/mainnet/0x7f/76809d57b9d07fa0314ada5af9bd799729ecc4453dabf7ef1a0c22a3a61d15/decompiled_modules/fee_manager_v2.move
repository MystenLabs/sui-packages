module 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        paused: bool,
        flat_fees: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct TreasuryKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct FeeUpdated has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old_fee: u64,
        new_fee: u64,
    }

    struct PauseUpdated has copy, drop {
        paused: bool,
    }

    struct FeesWithdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun assert_admin(arg0: &AdminCap, arg1: &PlatformConfig) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
    }

    public fun collect_fee<T0>(arg0: &mut PlatformConfig, arg1: 0x2::coin::Coin<T0>) {
        let v0 = TreasuryKey{coin_type: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<TreasuryKey>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun get_flat_fee<T0>(arg0: &PlatformConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.flat_fees, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.flat_fees, v0)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PlatformConfig{
            id           : 0x2::object::new(arg0),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            paused       : false,
            flat_fees    : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        };
        0x2::transfer::share_object<PlatformConfig>(v1);
    }

    public fun is_paused(arg0: &PlatformConfig) : bool {
        arg0.paused
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool) {
        assert_admin(arg0, arg1);
        arg1.paused = arg2;
        let v0 = PauseUpdated{paused: arg2};
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun update_flat_fee<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert_admin(arg0, arg1);
        assert!(arg2 <= 10000000000, 3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.flat_fees, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.flat_fees, v0)
        } else {
            0
        };
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.flat_fees, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg1.flat_fees, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.flat_fees, v0, arg2);
        };
        let v2 = FeeUpdated{
            coin_type : v0,
            old_fee   : v1,
            new_fee   : arg2,
        };
        0x2::event::emit<FeeUpdated>(v2);
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = TreasuryKey{coin_type: v0};
        if (!0x2::dynamic_field::exists<TreasuryKey>(&arg1.id, v1)) {
            assert!(arg2 == 0, 2);
            let v2 = FeesWithdrawn{
                coin_type : v0,
                amount    : arg2,
                recipient : arg3,
            };
            0x2::event::emit<FeesWithdrawn>(v2);
            return
        };
        let v3 = 0x2::dynamic_field::borrow_mut<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v1);
        assert!(arg2 <= 0x2::balance::value<T0>(v3), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, arg2), arg4), arg3);
        let v4 = FeesWithdrawn{
            coin_type : v0,
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<FeesWithdrawn>(v4);
    }

    // decompiled from Move bytecode v7
}

