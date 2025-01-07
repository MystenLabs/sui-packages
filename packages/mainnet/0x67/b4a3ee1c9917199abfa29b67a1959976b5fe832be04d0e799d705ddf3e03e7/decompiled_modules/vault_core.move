module 0x67b4a3ee1c9917199abfa29b67a1959976b5fe832be04d0e799d705ddf3e03e7::vault_core {
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

    struct VaultCreated has copy, drop {
        vault_id: vector<u8>,
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

    public(friend) fun create_delegation<T0>(arg0: &mut ResourceVault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000 + arg3;
        let v1 = VaultInfo{
            delegate : arg1,
            amount   : arg2,
            expiry   : v0,
            frozen   : false,
        };
        let v2 = generate_resource_vault_id<T0>(arg1);
        0x2::table::add<vector<u8>, VaultInfo>(&mut arg0.vaults, v2, v1);
        let v3 = VaultCreated{
            vault_id : v2,
            delegate : arg1,
            amount   : arg2,
            expiry   : v0,
        };
        0x2::event::emit<VaultCreated>(v3);
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

    public(friend) fun deposit<T0>(arg0: &mut ResourceVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun is_frozen<T0>(arg0: &VaultRegistry, arg1: vector<u8>, arg2: address) : bool {
        0x2::table::borrow<vector<u8>, VaultInfo>(&0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).vaults, generate_resource_vault_id<T0>(arg2)).frozen
    }

    public fun owner<T0>(arg0: &VaultRegistry, arg1: vector<u8>) : address {
        0x2::dynamic_object_field::borrow<vector<u8>, ResourceVault<T0>>(&arg0.id, arg1).owner
    }

    public fun resource_vault_exists(arg0: &VaultRegistry, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public(friend) fun set_frozen<T0>(arg0: &mut VaultRegistry, arg1: vector<u8>, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, ResourceVault<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg4) == v0.owner, 0);
        0x2::table::borrow_mut<vector<u8>, VaultInfo>(&mut v0.vaults, generate_resource_vault_id<T0>(arg2)).frozen = arg3;
    }

    public(friend) fun withdraw<T0>(arg0: &mut ResourceVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
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

