module 0xf86f73df88fb60dee71c8e3e8250214ff33d96e0d2f4403d5267ad73edf7144e::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        assets: 0x2::bag::Bag,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct EmergencyWithdrawal has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun id(arg0: &Vault) : 0x2::object::ID {
        0x2::object::id<Vault>(arg0)
    }

    public fun asset_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.assets, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.assets, v0))
        }
    }

    public fun asset_type_count(arg0: &Vault) : u64 {
        0x2::bag::length(&arg0.assets)
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.assets, v1)) {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v1), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : v1,
            amount    : v0,
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Deposited>(v2);
    }

    public entry fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.assets, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.assets, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 3);
        if (asset_balance<T0>(arg1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.assets, v0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, arg2, arg4), arg3);
        let v2 = EmergencyWithdrawal{
            vault_id  : 0x2::object::id<Vault>(arg1),
            coin_type : v0,
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<EmergencyWithdrawal>(v2);
    }

    public entry fun emergency_withdraw_all<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.assets, v0), 2);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.assets, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
        let v2 = EmergencyWithdrawal{
            vault_id  : 0x2::object::id<Vault>(arg1),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
            recipient : arg2,
        };
        0x2::event::emit<EmergencyWithdrawal>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id     : 0x2::object::new(arg0),
            assets : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

