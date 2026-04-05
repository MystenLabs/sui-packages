module 0x3f6446fb5b3309cea502887b4ee105fcd5c1bd70233f4c863b300107526024ee::deposit {
    struct RewardDeposit<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        depositor: address,
        recipient: address,
    }

    struct RewardAdded<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        depositor: address,
        recipient: address,
        amount: u64,
    }

    struct RewardWithdrawn<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        withdrawer: address,
        amount: u64,
    }

    public fun LendReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != v0, 5);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0x2::object::new(arg2);
        let v4 = RewardDeposit<T0>{
            id        : v3,
            balance   : v1,
            depositor : v0,
            recipient : arg1,
        };
        0x2::transfer::share_object<RewardDeposit<T0>>(v4);
        let v5 = RewardAdded<T0>{
            deposit_id : 0x2::object::uid_to_inner(&v3),
            depositor  : v0,
            recipient  : arg1,
            amount     : v2,
        };
        0x2::event::emit<RewardAdded<T0>>(v5);
    }

    public fun WithdrawReward<T0>(arg0: RewardDeposit<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.recipient, 4);
        let RewardDeposit {
            id        : v1,
            balance   : v2,
            depositor : _,
            recipient : _,
        } = arg0;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v5, v6, arg1), v0);
        let v7 = RewardWithdrawn<T0>{
            deposit_id : 0x2::object::uid_to_inner(&arg0.id),
            withdrawer : v0,
            amount     : v6,
        };
        0x2::event::emit<RewardWithdrawn<T0>>(v7);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v1);
    }

    public fun get_deposit_info<T0>(arg0: &RewardDeposit<T0>) : (address, address, u64) {
        (arg0.depositor, arg0.recipient, 0x2::balance::value<T0>(&arg0.balance))
    }

    // decompiled from Move bytecode v6
}

