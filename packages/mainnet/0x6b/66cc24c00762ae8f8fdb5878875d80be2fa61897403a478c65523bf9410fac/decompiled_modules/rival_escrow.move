module 0x6b66cc24c00762ae8f8fdb5878875d80be2fa61897403a478c65523bf9410fac::rival_escrow {
    struct EscrowSession<phantom T0> has key {
        id: 0x2::object::UID,
        session_id: vector<u8>,
        authority: address,
        wallet_a: address,
        wallet_b: 0x1::option::Option<address>,
        wager_amount: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T0>,
        state: u8,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        wallet_a: address,
        wager_amount: u64,
    }

    struct EscrowJoined has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        wallet_b: address,
    }

    struct EscrowSettled has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        winner: address,
        payout: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
    }

    public fun join<T0>(arg0: &mut EscrowSession<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg0.wallet_a, 5);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.wager_amount, 3);
        0x2::balance::join<T0>(&mut arg0.balance_b, 0x2::coin::into_balance<T0>(arg1));
        arg0.wallet_b = 0x1::option::some<address>(v0);
        arg0.state = 1;
        let v1 = EscrowJoined{
            escrow_id  : 0x2::object::id<EscrowSession<T0>>(arg0),
            session_id : arg0.session_id,
            wallet_b   : v0,
        };
        0x2::event::emit<EscrowJoined>(v1);
    }

    public fun authority<T0>(arg0: &EscrowSession<T0>) : address {
        arg0.authority
    }

    public fun cancel<T0>(arg0: &mut EscrowSession<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.wallet_a || v0 == arg0.authority, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a)), arg1), arg0.wallet_a);
        arg0.state = 3;
        let v1 = EscrowCancelled{
            escrow_id  : 0x2::object::id<EscrowSession<T0>>(arg0),
            session_id : arg0.session_id,
        };
        0x2::event::emit<EscrowCancelled>(v1);
    }

    public fun create<T0>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= 1000000000, 0);
        let v1 = EscrowSession<T0>{
            id           : 0x2::object::new(arg3),
            session_id   : arg0,
            authority    : arg1,
            wallet_a     : 0x2::tx_context::sender(arg3),
            wallet_b     : 0x1::option::none<address>(),
            wager_amount : v0,
            balance_a    : 0x2::coin::into_balance<T0>(arg2),
            balance_b    : 0x2::balance::zero<T0>(),
            state        : 0,
        };
        let v2 = EscrowCreated{
            escrow_id    : 0x2::object::id<EscrowSession<T0>>(&v1),
            session_id   : v1.session_id,
            wallet_a     : v1.wallet_a,
            wager_amount : v0,
        };
        0x2::event::emit<EscrowCreated>(v2);
        0x2::transfer::share_object<EscrowSession<T0>>(v1);
    }

    public fun err_below_min() : u64 {
        0
    }

    public fun err_invalid_winner() : u64 {
        4
    }

    public fun err_not_authority() : u64 {
        2
    }

    public fun err_self_rival() : u64 {
        5
    }

    public fun err_wager_mismatch() : u64 {
        3
    }

    public fun err_wrong_state() : u64 {
        1
    }

    public fun is_active<T0>(arg0: &EscrowSession<T0>) : bool {
        arg0.state == 1
    }

    public fun is_cancelled<T0>(arg0: &EscrowSession<T0>) : bool {
        arg0.state == 3
    }

    public fun is_settled<T0>(arg0: &EscrowSession<T0>) : bool {
        arg0.state == 2
    }

    public fun is_waiting<T0>(arg0: &EscrowSession<T0>) : bool {
        arg0.state == 0
    }

    public fun min_wager() : u64 {
        1000000000
    }

    public fun settle<T0>(arg0: &mut EscrowSession<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 2);
        assert!(arg1 == arg0.wallet_a || arg1 == *0x1::option::borrow<address>(&arg0.wallet_b), 4);
        let v0 = 0x2::balance::split<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.balance_b, 0x2::balance::value<T0>(&arg0.balance_b)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg1);
        arg0.state = 2;
        let v1 = EscrowSettled{
            escrow_id  : 0x2::object::id<EscrowSession<T0>>(arg0),
            session_id : arg0.session_id,
            winner     : arg1,
            payout     : 0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b),
        };
        0x2::event::emit<EscrowSettled>(v1);
    }

    public fun state<T0>(arg0: &EscrowSession<T0>) : u8 {
        arg0.state
    }

    public fun wager_amount<T0>(arg0: &EscrowSession<T0>) : u64 {
        arg0.wager_amount
    }

    public fun wallet_a<T0>(arg0: &EscrowSession<T0>) : address {
        arg0.wallet_a
    }

    public fun wallet_b<T0>(arg0: &EscrowSession<T0>) : &0x1::option::Option<address> {
        &arg0.wallet_b
    }

    // decompiled from Move bytecode v7
}

