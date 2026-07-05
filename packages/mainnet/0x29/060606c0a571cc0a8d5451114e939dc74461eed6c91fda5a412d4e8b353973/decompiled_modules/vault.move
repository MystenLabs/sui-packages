module 0x29060606c0a571cc0a8d5451114e939dc74461eed6c91fda5a412d4e8b353973::vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        reserves: 0x2::balance::Balance<T0>,
    }

    public entry fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id       : 0x2::object::new(arg0),
            reserves : 0x2::balance::zero<T0>(),
        };
        let v1 = OwnerCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<Vault<T0>>(&v0),
        };
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 1);
        0x2::balance::join<T0>(&mut arg1.reserves, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun return_from_trade<T0>(arg0: &OperatorCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.reserves, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun take_for_trade<T0>(arg0: &OperatorCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reserves, arg2), arg3)
    }

    public fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reserves, arg2), arg3)
    }

    public entry fun withdraw_to_sender<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reserves, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

