module 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_controller_v2 {
    struct VaultController has key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: address) : u64 {
        if (0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::is_user_registered(arg0, arg1)) {
            let v1 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_user_registry(arg0, arg1);
            if (0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::resource_vault_exists<T0>(v1)) {
                0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::balance<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_resource_vault<T0>(v1))
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun create_delegation<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_user_registry(arg0, 0x2::tx_context::sender(arg6));
        assert!(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::resource_vault_exists<T0>(v0), 21);
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::create_delegation<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_resource_vault<T0>(v0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun deposit<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::is_user_registered(arg0, v0)) {
            0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::register_user(arg0, arg2);
        };
        let v1 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_user_registry(arg0, v0);
        if (!0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::resource_vault_exists<T0>(v1)) {
            0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::create_resource_vault<T0>(v1, arg2);
        };
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::deposit<T0>(v1, arg1, arg2);
    }

    public fun get_delegation_info<T0>(arg0: &0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (vector<u8>, u64, address, bool) {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_delegation_info<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_resource_vault<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_user_registry(arg0, arg1)), arg2, arg3, arg4)
    }

    public fun get_fee_address(arg0: &0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry) : address {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_fee_address(arg0)
    }

    public fun get_fee_amount(arg0: &0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: u128) : u128 {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_fee_amount(arg0, arg1)
    }

    public fun get_fee_bps(arg0: &0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry) : u64 {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_fee_bps(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultController{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VaultController>(v0);
    }

    public fun is_frozen<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : bool {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::is_frozen<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_resource_vault<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_user_registry(arg0, arg1)), arg2, arg3)
    }

    public fun set_frozen<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: vector<u8>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::set_frozen<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_resource_vault<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_user_registry(arg0, 0x2::tx_context::sender(arg3))), arg1, arg2, arg3);
    }

    public fun update_fee_address(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::update_fee_address(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun update_fee_bps(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::update_fee_bps(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun withdraw_by_solver<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_user_registry(arg0, arg1);
        assert!(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::resource_vault_exists<T0>(v0), 21);
        let v1 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::withdraw_delegated<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_resource_vault<T0>(v0), arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, (0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_fee_amount(arg0, (0x2::balance::value<T0>(0x2::coin::balance<T0>(&v1)) as u128)) as u64), arg4), 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::get_fee_address(arg0));
        v1
    }

    public fun withdraw_by_user<T0>(arg0: &mut 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::VaultRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_user_registry(arg0, v0);
        assert!(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::is_resource_owner(v1, v0), 20);
        0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::withdraw<T0>(0x7c8fcd30434bb89495de47f241640477a27dabac09c90ad5396685f0a86b5265::vault_core_v2::borrow_mut_resource_vault<T0>(v1), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

