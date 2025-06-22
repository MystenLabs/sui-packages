module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store {
    struct TreasuryStore has key {
        id: 0x2::object::UID,
        roles: 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleStore,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct TokenStore<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        max_supply: u64,
    }

    struct TreasuryCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenStoreKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &TreasuryStore) : u64 {
        let v0 = TokenStoreKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<TokenStoreKey<T0>, TokenStore<T0>>(&arg0.id, v0).balance)
    }

    public fun total_supply<T0>(arg0: &TreasuryStore) : u64 {
        0x2::coin::total_supply<T0>(borrow_cap<T0>(arg0))
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TreasuryStore {
        TreasuryStore{
            id                  : 0x2::object::new(arg0),
            roles               : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::new(arg0),
            compatible_versions : 0x2::vec_set::singleton<u64>(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::versioning::current_version()),
        }
    }

    public fun add_capability<T0: drop + store>(arg0: &mut TreasuryStore, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::add_capability<T0>(&mut arg0.roles, arg1, arg2, arg3);
    }

    public fun has_cap<T0: store>(arg0: &TreasuryStore, arg1: address) : bool {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<T0>(&arg0.roles, arg1)
    }

    public fun remove_capability<T0: drop + store>(arg0: &mut TreasuryStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::remove_capability<T0>(&mut arg0.roles, arg1, arg2);
    }

    public fun add_compatible_version(arg0: &mut TreasuryStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&arg0.roles, 0x2::tx_context::sender(arg2)), 8);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public fun borrow_cap<T0>(arg0: &TreasuryStore) : &0x2::coin::TreasuryCap<T0> {
        assert!(contains_treasury_cap<T0>(arg0), 1);
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun borrow_cap_mut<T0>(arg0: &mut TreasuryStore, arg1: &0x2::tx_context::TxContext) : &mut 0x2::coin::TreasuryCap<T0> {
        assert!(contains_treasury_cap<T0>(arg0), 1);
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun borrow_roles_mut(arg0: &mut TreasuryStore) : &mut 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleStore {
        &mut arg0.roles
    }

    public(friend) fun burn_token<T0>(arg0: &mut TreasuryStore, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) : u64 {
        0x2::coin::burn<T0>(borrow_cap_mut<T0>(arg0, arg2), arg1)
    }

    public fun contains_token_store<T0>(arg0: &TreasuryStore) : bool {
        let v0 = TokenStoreKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_<TokenStoreKey<T0>>(&arg0.id, v0)
    }

    public fun contains_treasury_cap<T0>(arg0: &TreasuryStore) : bool {
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_<TreasuryCapKey<T0>>(&arg0.id, v0)
    }

    public fun id(arg0: &TreasuryStore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun remove_compatible_version(arg0: &mut TreasuryStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&arg0.roles, 0x2::tx_context::sender(arg2)), 8);
        assert!(0x2::vec_set::contains<u64>(&arg0.compatible_versions, &arg1), 9);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public(friend) fun share(arg0: TreasuryStore) {
        0x2::transfer::share_object<TreasuryStore>(arg0);
    }

    public fun store<T0>(arg0: &mut TreasuryStore, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg0, 0x2::tx_context::sender(arg3)), 3);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 6);
        assert!(arg2 > 0, 4);
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0, arg1);
        let v1 = TokenStoreKey<T0>{dummy_field: false};
        let v2 = TokenStore<T0>{
            id         : 0x2::object::new(arg3),
            balance    : 0x2::coin::mint_balance<T0>(&mut arg1, arg2),
            max_supply : arg2,
        };
        0x2::dynamic_object_field::add<TokenStoreKey<T0>, TokenStore<T0>>(&mut arg0.id, v1, v2);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_token_stored<T0>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun take<T0>(arg0: &mut TreasuryStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg0, 0x2::tx_context::sender(arg2)), 3);
        let v0 = take_internal<T0>(arg0, arg1, arg2);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public(friend) fun take_internal<T0>(arg0: &mut TreasuryStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(contains_token_store<T0>(arg0), 7);
        assert!(arg1 <= balance<T0>(arg0), 2);
        let v0 = TokenStoreKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<TokenStoreKey<T0>, TokenStore<T0>>(&mut arg0.id, v0).balance, arg1)
    }

    // decompiled from Move bytecode v6
}

