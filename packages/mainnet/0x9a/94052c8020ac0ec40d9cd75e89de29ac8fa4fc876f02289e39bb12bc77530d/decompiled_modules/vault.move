module 0x9a94052c8020ac0ec40d9cd75e89de29ac8fa4fc876f02289e39bb12bc77530d::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        beneficiary: address,
    }

    struct Deposited<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        beneficiary: address,
        amount: u64,
    }

    struct Paid<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    struct Refunded<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun beneficiary<T0>(arg0: &Vault<T0>) : address {
        arg0.beneficiary
    }

    public fun close_empty<T0>(arg0: Vault<T0>) {
        let Vault {
            id          : v0,
            funds       : v1,
            beneficiary : _,
        } = arg0;
        let v3 = v1;
        assert!(0x2::balance::value<T0>(&v3) == 0, 1);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun deposit_balance<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        store<T0>(0x2::balance::redeem_funds<T0>(arg0), arg1, arg2);
    }

    public fun deposit_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        store<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2);
    }

    public fun redeem_to_beneficiary<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1), arg0.beneficiary);
        let v1 = Paid<T0>{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            beneficiary : arg0.beneficiary,
            amount      : v0,
        };
        0x2::event::emit<Paid<T0>>(v1);
    }

    public fun refund_to_owner<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg1), 0x2::tx_context::sender(arg1));
        let v1 = Refunded<T0>{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            depositor : 0x2::tx_context::sender(arg1),
            amount    : v0,
        };
        0x2::event::emit<Refunded<T0>>(v1);
    }

    fun store<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = Vault<T0>{
            id          : 0x2::object::new(arg2),
            funds       : arg0,
            beneficiary : arg1,
        };
        let v2 = Deposited<T0>{
            vault_id    : 0x2::object::id<Vault<T0>>(&v1),
            depositor   : 0x2::tx_context::sender(arg2),
            beneficiary : arg1,
            amount      : v0,
        };
        0x2::event::emit<Deposited<T0>>(v2);
        0x2::transfer::transfer<Vault<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

