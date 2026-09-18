module 0xa80e627eb8d73507055de2ee8ccbe8bc746d2741f66b10266027d718f401e5ec::returns {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct Deposited<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct Redeemed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = Vault<T0>{
            id    : 0x2::object::new(arg1),
            funds : 0x2::coin::into_balance<T0>(arg0),
        };
        let v2 = Deposited<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(&v1),
            amount   : v0,
        };
        0x2::event::emit<Deposited<T0>>(v2);
        0x2::transfer::transfer<Vault<T0>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun rebuild_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    public fun redeem<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 > 0, 0);
        let v1 = Redeemed<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<Redeemed<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1)
    }

    // decompiled from Move bytecode v7
}

