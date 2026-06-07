module 0x6de835db0f62e073f17dcb5f4a946a81ea2a565eb87df8f683ad606c5fb11bb8::escrow {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        league_id: u64,
        staker: address,
        amount: u64,
    }

    struct PayoutEvent has copy, drop {
        vault_id: 0x2::object::ID,
        league_id: u64,
        recipient: address,
        amount: u64,
    }

    struct RefundEvent has copy, drop {
        vault_id: 0x2::object::ID,
        league_id: u64,
        recipient: address,
        amount: u64,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            league_id : arg2,
            staker    : 0x2::tx_context::sender(arg3),
            amount    : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun payout<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5), arg2);
        let v0 = PayoutEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg1.id),
            league_id : arg4,
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<PayoutEvent>(v0);
    }

    public fun payout_batch<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            payout<T0>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), arg4, arg5);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun refund<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5), arg2);
        let v0 = RefundEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg1.id),
            league_id : arg4,
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<RefundEvent>(v0);
    }

    public fun refund_batch<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            refund<T0>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), arg4, arg5);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

