module 0xd9999332d22fe0001164e2ba0ddbfd69245f8a8434acf663a138f2520cbe7288::deep_vault {
    struct DeepVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DeepVaultAdmin has store, key {
        id: 0x2::object::UID,
        authorized: vector<address>,
    }

    public fun borrow<T0>(arg0: &mut DeepVaultAdmin, arg1: &mut DeepVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_authorized(arg0, arg3);
        0x2::balance::split<T0>(&mut arg1.balance, arg2)
    }

    public fun add_authorized(arg0: &mut DeepVaultAdmin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.authorized, &v0), 1);
        0x1::vector::append<address>(&mut arg0.authorized, arg1);
    }

    fun check_authorized(arg0: &DeepVaultAdmin, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.authorized, &v0), 2);
    }

    public fun create_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepVaultAdmin{
            id         : 0x2::object::new(arg0),
            authorized : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<DeepVaultAdmin>(v0);
    }

    public fun create_vault<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        };
        0x2::transfer::share_object<DeepVault<T0>>(v0);
    }

    public fun is_authorized(arg0: &DeepVaultAdmin, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized, &arg1)
    }

    public fun repay<T0>(arg0: &mut DeepVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(&mut arg1, arg2));
        arg1
    }

    public fun vault_balance<T0>(arg0: &DeepVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

