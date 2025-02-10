module 0xf3c885211503c9ebb9a4db87f077e2a2e7b2764a29ee77bb8bce520372fc146a::vault_core_v2 {
    struct UserRegistry has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct DelegationInfo has copy, drop, store {
        delegate: address,
        intent_ref_hash: vector<u8>,
        amount: u64,
        expiry: u64,
        frozen: bool,
    }

    struct DelegationWithdrawn has copy, drop {
        intent_ref_hash: 0x1::string::String,
        delegate: address,
        amount: u64,
    }

    struct DelegationAdded has copy, drop {
        intent_ref_hash: 0x1::string::String,
        delegate: address,
        amount: u64,
        expiry: u64,
    }

    struct ResourceVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        delegations: vector<DelegationInfo>,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_address: address,
        authority: address,
        user_registries: 0x2::table::Table<address, UserRegistry>,
    }

    struct VaultDeposited has copy, drop {
        owner: address,
        amount: u64,
    }

    public fun balance<T0>(arg0: &ResourceVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun borrow_mut_resource_vault<T0>(arg0: &mut UserRegistry) : &mut ResourceVault<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, ResourceVault<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun borrow_mut_user_registry(arg0: &mut VaultRegistry, arg1: address) : &mut UserRegistry {
        0x2::table::borrow_mut<address, UserRegistry>(&mut arg0.user_registries, arg1)
    }

    public(friend) fun borrow_resource_vault<T0>(arg0: &UserRegistry) : &ResourceVault<T0> {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, ResourceVault<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun borrow_user_registry(arg0: &VaultRegistry, arg1: address) : &UserRegistry {
        0x2::table::borrow<address, UserRegistry>(&arg0.user_registries, arg1)
    }

    public(friend) fun create_delegation<T0>(arg0: &mut ResourceVault<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000 + arg4;
        let v1 = DelegationInfo{
            delegate        : arg2,
            intent_ref_hash : arg1,
            amount          : arg3,
            expiry          : v0,
            frozen          : false,
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelegationInfo>(&arg0.delegations)) {
            assert!(0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v2).intent_ref_hash != arg1, 12);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<DelegationInfo>(&mut arg0.delegations, v1);
        let v3 = DelegationAdded{
            intent_ref_hash : 0x1::string::utf8(arg1),
            delegate        : arg2,
            amount          : arg3,
            expiry          : v0,
        };
        0x2::event::emit<DelegationAdded>(v3);
    }

    public(friend) fun create_resource_vault<T0>(arg0: &mut UserRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ResourceVault<T0>{
            id          : 0x2::object::new(arg1),
            owner       : 0x2::tx_context::sender(arg1),
            balance     : 0x2::balance::zero<T0>(),
            delegations : 0x1::vector::empty<DelegationInfo>(),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, ResourceVault<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut UserRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, ResourceVault<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = VaultDeposited{
            owner  : v0,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<VaultDeposited>(v1);
    }

    public(friend) fun get_active_delegated_amount(arg0: &vector<DelegationInfo>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 > 0, 18);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelegationInfo>(arg0)) {
            let v3 = 0x1::vector::borrow<DelegationInfo>(arg0, v2);
            if (v3.expiry > v0) {
                v1 = v1 + v3.amount;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_delegation_info<T0>(arg0: &ResourceVault<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (vector<u8>, u64, address, bool) {
        let (v0, v1) = is_delegated(&arg0.delegations, arg1);
        assert!(v0, 13);
        let v2 = 0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1);
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000 < v2.expiry && false || true;
        (v2.intent_ref_hash, v2.amount, v2.delegate, v3)
    }

    public(friend) fun get_fee_address(arg0: &VaultRegistry) : address {
        arg0.fee_address
    }

    public(friend) fun get_fee_amount(arg0: &VaultRegistry, arg1: u128) : u128 {
        arg1 * (arg0.fee_bps as u128) / 10000
    }

    public(friend) fun get_fee_bps(arg0: &VaultRegistry) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id              : 0x2::object::new(arg0),
            fee_bps         : 0,
            fee_address     : 0x2::tx_context::sender(arg0),
            authority       : 0x2::tx_context::sender(arg0),
            user_registries : 0x2::table::new<address, UserRegistry>(arg0),
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    fun is_delegated(arg0: &vector<DelegationInfo>, arg1: vector<u8>) : (bool, u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<DelegationInfo>(arg0)) {
            if (0x1::vector::borrow<DelegationInfo>(arg0, v0).intent_ref_hash == arg1) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        (v1, v0 - 1)
    }

    public(friend) fun is_frozen<T0>(arg0: &ResourceVault<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : bool {
        let (v0, v1) = is_delegated(&arg0.delegations, arg1);
        assert!(v0, 13);
        0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1).frozen
    }

    public(friend) fun is_resource_owner(arg0: &UserRegistry, arg1: address) : bool {
        arg0.owner == arg1
    }

    public(friend) fun is_user_registered(arg0: &VaultRegistry, arg1: address) : bool {
        0x2::table::contains<address, UserRegistry>(&arg0.user_registries, arg1)
    }

    public(friend) fun register_user(arg0: &mut VaultRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, UserRegistry>(&arg0.user_registries, v0)) {
            let v1 = UserRegistry{
                id    : 0x2::object::new(arg1),
                owner : v0,
            };
            0x2::table::add<address, UserRegistry>(&mut arg0.user_registries, v0, v1);
        };
    }

    fun remove_delegated_hash(arg0: &mut vector<DelegationInfo>, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<DelegationInfo>(arg0);
        while (v0 > 0) {
            v0 = v0 - 1;
            if (0x1::vector::borrow<DelegationInfo>(arg0, v0).expiry < 0x2::clock::timestamp_ms(arg1) / 1000) {
                0x1::vector::swap_remove<DelegationInfo>(arg0, v0);
            };
        };
    }

    public(friend) fun resource_vault_exists<T0>(arg0: &UserRegistry) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun set_frozen<T0>(arg0: &mut ResourceVault<T0>, arg1: vector<u8>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = is_delegated(&arg0.delegations, arg1);
        assert!(v0, 13);
        assert!(0x2::tx_context::sender(arg3) == 0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1).delegate, 6);
        0x1::vector::borrow_mut<DelegationInfo>(&mut arg0.delegations, v1).frozen = arg2;
    }

    public(friend) fun update_fee_address(arg0: &mut VaultRegistry, arg1: address, arg2: address) {
        assert!(arg1 == arg0.authority, 6);
        arg0.fee_address = arg2;
    }

    public(friend) fun update_fee_bps(arg0: &mut VaultRegistry, arg1: address, arg2: u64) {
        assert!(arg1 == arg0.authority, 6);
        arg0.fee_bps = arg2;
    }

    public(friend) fun withdraw<T0>(arg0: &mut ResourceVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 6);
        let v0 = &mut arg0.delegations;
        let v1 = get_active_delegated_amount(v0, arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v2 >= v1, 5);
        let v3 = v2 - v1;
        assert!(v3 > 0, 16);
        remove_delegated_hash(v0, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2)
    }

    public(friend) fun withdraw_delegated<T0>(arg0: &mut ResourceVault<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = is_delegated(&arg0.delegations, arg1);
        assert!(v0, 13);
        assert!(0x2::tx_context::sender(arg3) == 0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1).delegate, 6);
        assert!(0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1).frozen == false, 31);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < 0x1::vector::borrow<DelegationInfo>(&arg0.delegations, v1).expiry, 1);
        let v2 = 0x1::vector::swap_remove<DelegationInfo>(&mut arg0.delegations, v1);
        let v3 = DelegationWithdrawn{
            intent_ref_hash : 0x1::string::utf8(arg1),
            delegate        : v2.delegate,
            amount          : v2.amount,
        };
        0x2::event::emit<DelegationWithdrawn>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2.amount), arg3)
    }

    // decompiled from Move bytecode v6
}

