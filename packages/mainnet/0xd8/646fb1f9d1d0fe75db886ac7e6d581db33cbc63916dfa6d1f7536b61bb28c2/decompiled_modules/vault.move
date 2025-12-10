module 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::vault {
    struct RebateVault has store, key {
        id: 0x2::object::UID,
        unclaimed_rebates: 0x2::object_bag::ObjectBag,
        allocation_registry: 0x2::object_table::ObjectTable<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
    }

    struct DepositCap<phantom T0> {
        vault_id: 0x2::object::ID,
        added_rebates: u64,
        num_of_addresses: u64,
    }

    struct WithdrawCap {
        vault_id: 0x2::object::ID,
        types: vector<0x1::ascii::String>,
        amounts: vector<u64>,
    }

    fun join<T0>(arg0: &mut RebateVault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.unclaimed_rebates, v0)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.unclaimed_rebates, v0), arg1);
        } else {
            0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.unclaimed_rebates, v0, arg1);
        };
    }

    fun split<T0>(arg0: &mut RebateVault, arg1: address, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_allocation(arg0, arg1, arg2);
        0x2::coin::split<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.unclaimed_rebates, arg2), v0, arg3)
    }

    public fun new(arg0: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::ADMIN>, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg1);
        let v0 = RebateVault{
            id                  : 0x2::object::new(arg2),
            unclaimed_rebates   : 0x2::object_bag::new(arg2),
            allocation_registry : 0x2::object_table::new<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg2),
        };
        let v1 = &mut v0;
        add_allocation(v1, @0x0, 0x1::type_name::with_defining_ids<RebateVault>(), 0, arg2);
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::events::emit_create_vault_event(0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<RebateVault>(v0);
    }

    fun add_allocation(arg0: &mut RebateVault, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::object_table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, arg1)) {
            0x2::object_table::add<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.allocation_registry, arg1, 0x2::table::new<0x1::type_name::TypeName, u64>(arg4));
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.allocation_registry, arg1);
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(v0, arg2)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(v0, arg2)
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(v0, arg2, 0);
            0
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v0, arg2) = v1 + arg3;
    }

    public fun address_has_rebate(arg0: &RebateVault, arg1: address) : bool {
        0x2::object_table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, arg1) && 0x2::table::length<0x1::type_name::TypeName, u64>(0x2::object_table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, arg1)) > 0
    }

    public fun address_has_rebate_with_type<T0>(arg0: &RebateVault, arg1: address) : bool {
        address_has_rebate_with_type_name(arg0, arg1, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun address_has_rebate_with_type_name(arg0: &RebateVault, arg1: address, arg2: 0x1::type_name::TypeName) : bool {
        address_has_rebate(arg0, arg1) && 0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::object_table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, arg1), arg2)
    }

    public fun begin_deposit_tx<T0, T1>(arg0: &RebateVault, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, T0>, arg2: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config) : DepositCap<T1> {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg2);
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        DepositCap<T1>{
            vault_id         : 0x2::object::uid_to_inner(&arg0.id),
            added_rebates    : 0,
            num_of_addresses : 0,
        }
    }

    public fun begin_withdraw_tx(arg0: &RebateVault, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config) : WithdrawCap {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg1);
        WithdrawCap{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            types    : 0x1::vector::empty<0x1::ascii::String>(),
            amounts  : vector[],
        }
    }

    public fun end_deposit_tx<T0>(arg0: &mut RebateVault, arg1: DepositCap<T0>, arg2: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::ascii::String, arg5: u64, arg6: u64) {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg2);
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 13835622276546166789);
        let DepositCap {
            vault_id         : v0,
            added_rebates    : v1,
            num_of_addresses : v2,
        } = arg1;
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 == v1, 13835340848813965315);
        join<T0>(arg0, arg3);
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::events::emit_deposit_rebate_event<T0>(v0, arg4, v3, v2, arg5, arg6);
    }

    public fun end_withdraw_tx(arg0: WithdrawCap, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config, arg2: &0x2::tx_context::TxContext) {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg1);
        let WithdrawCap {
            vault_id : v0,
            types    : v1,
            amounts  : v2,
        } = arg0;
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::events::emit_withdraw_rebate_event(v0, 0x2::tx_context::sender(arg2), v1, v2);
    }

    public fun rebates_for(arg0: &RebateVault, arg1: address, arg2: 0x1::type_name::TypeName) : &u64 {
        if (address_has_rebate_with_type_name(arg0, arg1, arg2)) {
            0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::object_table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, arg1), arg2)
        } else {
            0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::object_table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.allocation_registry, @0x0), 0x1::type_name::with_defining_ids<RebateVault>())
        }
    }

    fun remove_allocation(arg0: &mut RebateVault, arg1: address, arg2: 0x1::type_name::TypeName) : u64 {
        0x2::table::remove<0x1::type_name::TypeName, u64>(0x2::object_table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.allocation_registry, arg1), arg2)
    }

    fun sum(arg0: vector<u64>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg0);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        v0
    }

    public fun update_allocations<T0>(arg0: &mut RebateVault, arg1: &mut DepositCap<T0>, arg2: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg2);
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 13835622053207867397);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 13835059120434053121);
        arg1.num_of_addresses = arg1.num_of_addresses + 0x1::vector::length<address>(&arg3);
        arg1.added_rebates = arg1.added_rebates + sum(arg4);
        let v1 = 0;
        while (v1 < v0) {
            add_allocation(arg0, *0x1::vector::borrow<address>(&arg3, v1), 0x1::type_name::with_defining_ids<T0>(), *0x1::vector::borrow<u64>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    public fun withdraw_rebate<T0>(arg0: &mut RebateVault, arg1: &mut WithdrawCap, arg2: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::assert_correct_version(arg2);
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 13835622615848583173);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = split<T0>(arg0, v0, v1, arg3);
        let v3 = 0x2::coin::value<T0>(&v2);
        if (v3 != 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg1.types, 0x1::type_name::into_string(v1));
            0x1::vector::push_back<u64>(&mut arg1.amounts, v3);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

