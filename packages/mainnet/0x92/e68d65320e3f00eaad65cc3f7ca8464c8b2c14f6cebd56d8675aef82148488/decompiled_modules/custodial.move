module 0x92e68d65320e3f00eaad65cc3f7ca8464c8b2c14f6cebd56d8675aef82148488::custodial {
    struct Vault has key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
    }

    struct VaultCap has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct Whitelist has copy, drop, store {
        address: address,
    }

    public entry fun add_whitelist(arg0: &VaultCap, arg1: &mut Vault, arg2: address) {
        assert!(arg0.for == 0x2::object::id<Vault>(arg1), 2);
        let v0 = Whitelist{address: arg2};
        0x2::dynamic_field::add<Whitelist, bool>(&mut arg1.id, v0, true);
    }

    fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            coins : 0x2::bag::new(arg0),
        };
        let v1 = VaultCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        0x2::transfer::transfer<VaultCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_vault(arg0);
    }

    public entry fun remove_whitelist(arg0: &VaultCap, arg1: &mut Vault, arg2: address) {
        assert!(arg0.for == 0x2::object::id<Vault>(arg1), 2);
        let v0 = Whitelist{address: arg2};
        0x2::dynamic_field::remove_if_exists<Whitelist, bool>(&mut arg1.id, v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Whitelist{address: 0x2::tx_context::sender(arg2)};
        assert!(0x2::dynamic_field::exists_<Whitelist>(&arg0.id, v0), 3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v1), 1);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg2)
    }

    public fun withdraw_at_most<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Whitelist{address: 0x2::tx_context::sender(arg2)};
        assert!(0x2::dynamic_field::exists_<Whitelist>(&arg0.id, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, 0x1::u64::min(0x2::balance::value<T0>(v1), arg1)), arg2)
    }

    // decompiled from Move bytecode v6
}

