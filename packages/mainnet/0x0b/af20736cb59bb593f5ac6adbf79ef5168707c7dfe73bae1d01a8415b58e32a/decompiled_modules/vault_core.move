module 0xbaf20736cb59bb593f5ac6adbf79ef5168707c7dfe73bae1d01a8415b58e32a::vault_core {
    struct VaultInfo has store {
        delegate: address,
        amount: u64,
        expiry: u64,
        frozen: bool,
    }

    struct ResourceVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        vaults: 0x2::table::Table<vector<u8>, VaultInfo>,
    }

    struct VaultDeposited has copy, drop {
        owner: address,
        amount: u64,
    }

    struct VaultUpdated has copy, drop {
        vault_id: vector<u8>,
        intent_ref_hash: 0x1::string::String,
        delegate: address,
        amount: u64,
        expiry: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: vector<u8>,
        amount: u64,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_address: address,
        authority: address,
    }

    public fun balance<T0>(arg0: &VaultRegistry, arg1: vector<u8>) : u64 {
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).balance)
    }

    public(friend) fun borrow_mut_resource_vault<T0>(arg0: &mut VaultRegistry, arg1: address) : &mut ResourceVault<T0> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, ResourceVault<T0>>(&mut arg0.id, generate_resource_vault_id<T0>(arg1))
    }

    public fun borrow_resource_vault<T0>(arg0: &VaultRegistry, arg1: address) : &ResourceVault<T0> {
        0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, generate_resource_vault_id<T0>(arg1))
    }

    public(friend) fun create_delegation<T0>(arg0: &mut ResourceVault<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000 + arg4;
        let v1 = generate_resource_vault_id<T0>(arg2);
        if (0x2::table::contains<vector<u8>, VaultInfo>(&arg0.vaults, v1)) {
            let v2 = 0x2::table::borrow_mut<vector<u8>, VaultInfo>(&mut arg0.vaults, v1);
            v2.amount = v2.amount + arg3;
            v2.expiry = v0;
            v2.frozen = false;
            v2.delegate = arg2;
        } else {
            let v3 = VaultInfo{
                delegate : arg2,
                amount   : arg3,
                expiry   : v0,
                frozen   : false,
            };
            0x2::table::add<vector<u8>, VaultInfo>(&mut arg0.vaults, v1, v3);
        };
        let v4 = VaultUpdated{
            vault_id        : v1,
            intent_ref_hash : 0x1::string::utf8(arg1),
            delegate        : arg2,
            amount          : arg3,
            expiry          : v0,
        };
        0x2::event::emit<VaultUpdated>(v4);
    }

    public(friend) fun create_resource_vault<T0>(arg0: &mut VaultRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ResourceVault<T0>{
            id      : 0x2::object::new(arg1),
            owner   : v0,
            balance : 0x2::balance::zero<T0>(),
            vaults  : 0x2::table::new<vector<u8>, VaultInfo>(arg1),
        };
        0x2::dynamic_object_field::add<vector<u8>, ResourceVault<T0>>(&mut arg0.id, generate_resource_vault_id<T0>(v0), v1);
    }

    public fun delegated_amount<T0>(arg0: &VaultRegistry, arg1: vector<u8>, arg2: address) : u64 {
        0x2::table::borrow<vector<u8>, VaultInfo>(&0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).vaults, generate_resource_vault_id<T0>(arg2)).amount
    }

    public(friend) fun deposit<T0>(arg0: &mut ResourceVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = VaultDeposited{
            owner  : v0,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<VaultDeposited>(v1);
    }

    public(friend) fun generate_resource_vault_id<T0>(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::type_name::get<T0>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::hash::sha3_256(v0)
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
            id          : 0x2::object::new(arg0),
            fee_bps     : 0,
            fee_address : 0x2::tx_context::sender(arg0),
            authority   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun is_frozen<T0>(arg0: &VaultRegistry, arg1: vector<u8>, arg2: address) : bool {
        0x2::table::borrow<vector<u8>, VaultInfo>(&0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).vaults, generate_resource_vault_id<T0>(arg2)).frozen
    }

    public fun owner<T0>(arg0: &VaultRegistry, arg1: vector<u8>) : address {
        0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).owner
    }

    public(friend) fun remove_all_delegation<T0>(arg0: &mut ResourceVault<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = generate_resource_vault_id<T0>(arg2);
        assert!(0x2::table::contains<vector<u8>, VaultInfo>(&arg0.vaults, v1), 4);
        let v2 = 0x2::table::borrow_mut<vector<u8>, VaultInfo>(&mut arg0.vaults, v1);
        assert!(v0 == arg0.owner, 6);
        if (v0 == arg0.owner) {
            assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= v2.expiry, 7);
        };
        v2.amount = 0;
    }

    public fun resource_vault_exists(arg0: &VaultRegistry, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public(friend) fun set_frozen<T0>(arg0: &mut VaultRegistry, arg1: vector<u8>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, ResourceVault<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg4) == v0.owner, 0);
        0x2::table::borrow_mut<vector<u8>, VaultInfo>(&mut v0.vaults, generate_resource_vault_id<T0>(arg2)).frozen = arg3;
    }

    public(friend) fun update_fee_address(arg0: &mut VaultRegistry, arg1: address, arg2: address) {
        assert!(arg1 == arg0.authority, 4);
        arg0.fee_address = arg2;
    }

    public(friend) fun update_fee_bps(arg0: &mut VaultRegistry, arg1: address, arg2: u64) {
        assert!(arg1 == arg0.authority, 4);
        arg0.fee_bps = arg2;
    }

    public(friend) fun withdraw<T0>(arg0: &mut ResourceVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut ResourceVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg1)
    }

    public(friend) fun withraw_delegated_asset<T0>(arg0: &mut ResourceVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (v0 != arg3) {
            generate_resource_vault_id<T0>(arg3)
        } else {
            generate_resource_vault_id<T0>(v0)
        };
        assert!(0x2::table::contains<vector<u8>, VaultInfo>(&arg0.vaults, v1), 4);
        let v2 = 0x2::table::borrow_mut<vector<u8>, VaultInfo>(&mut arg0.vaults, v1);
        assert!(!v2.frozen, 3);
        assert!(v0 == arg0.owner || v0 == v2.delegate, 6);
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 == v2.delegate) {
            assert!(v3 < v2.expiry, 1);
        };
        if (v0 == arg0.owner) {
            assert!(v3 >= v2.expiry, 7);
        };
        assert!(arg1 <= v2.amount, 2);
        v2.amount = v2.amount - arg1;
        let v4 = VaultWithdrawn{
            vault_id : v1,
            amount   : arg1,
        };
        0x2::event::emit<VaultWithdrawn>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4)
    }

    // decompiled from Move bytecode v6
}

