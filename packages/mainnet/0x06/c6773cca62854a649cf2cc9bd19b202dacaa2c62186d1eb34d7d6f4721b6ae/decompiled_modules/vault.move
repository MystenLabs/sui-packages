module 0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        version: u16,
    }

    struct VaultBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    fun assert_version(arg0: &Vault) {
        assert!(arg0.version == 0, 1);
    }

    public(friend) fun borrow_object<T0: copy + drop + store, T1: store + key>(arg0: &Vault, arg1: T0) : &T1 {
        assert_version(arg0);
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_object_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0) : &mut T1 {
        assert_version(arg0);
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun get_balance<T0>(arg0: &Vault) : u64 {
        assert_version(arg0);
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::coin::balance<T0>(0x2::dynamic_object_field::borrow<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0)))
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<VAULT>(&arg0), 0);
        let v0 = Vault{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public(friend) fun put_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            let v1 = VaultBalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v1)), arg1);
        } else {
            let v2 = VaultBalanceKey<T0>{dummy_field: false};
            0x2::dynamic_object_field::add<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v2, 0x2::coin::from_balance<T0>(arg1, arg2));
        };
    }

    public(friend) fun put_object<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0, arg2: T1) {
        assert_version(arg0);
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun take_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)), arg1)
    }

    public(friend) fun take_object<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0) : T1 {
        assert_version(arg0);
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

