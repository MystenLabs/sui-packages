module 0x3844aece0c215222d6b24e04e0068b590d0233683c057658aa52da67814ec242::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        recipient: address,
    }

    struct Deposited<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct Redeemed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = Vault<T0>{
            id        : 0x2::object::new(arg2),
            funds     : 0x2::coin::into_balance<T0>(arg0),
            recipient : arg1,
        };
        let v2 = Deposited<T0>{
            vault_id  : 0x2::object::id<Vault<T0>>(&v1),
            recipient : arg1,
            amount    : v0,
        };
        0x2::event::emit<Deposited<T0>>(v2);
        0x2::transfer::transfer<Vault<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun recipient<T0>(arg0: &Vault<T0>) : address {
        arg0.recipient
    }

    public fun redeem_to_recipient<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1), arg0.recipient);
        let v1 = Redeemed<T0>{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            recipient : arg0.recipient,
            amount    : v0,
        };
        0x2::event::emit<Redeemed<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

