module 0x86a617340a83b56764204292c2511e2f84b9f4c8a712e63161371a8b101732f6::escrow {
    struct BackendCap has store, key {
        id: 0x2::object::UID,
    }

    struct DuelEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        duel_id: vector<u8>,
        challenger: address,
        opponent: address,
        stake_amount: u64,
        challenger_balance: 0x2::balance::Balance<T0>,
        opponent_balance: 0x2::balance::Balance<T0>,
        status: u8,
        created_at_ms: u64,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        duel_id: vector<u8>,
        challenger: address,
        opponent: address,
        stake_amount: u64,
    }

    struct EscrowOpponentSet has copy, drop {
        escrow_id: 0x2::object::ID,
        duel_id: vector<u8>,
        opponent: address,
    }

    struct EscrowActivated has copy, drop {
        duel_id: vector<u8>,
        opponent: address,
    }

    struct EscrowSettled has copy, drop {
        duel_id: vector<u8>,
        winner: address,
        total_amount: u64,
    }

    struct EscrowTied has copy, drop {
        duel_id: vector<u8>,
        stake_amount: u64,
    }

    struct EscrowCancelled has copy, drop {
        duel_id: vector<u8>,
    }

    public fun cancel_expired<T0>(arg0: DuelEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.challenger, 7);
        assert!(arg0.status == 2 || arg0.status == 0, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.created_at_ms + 172800000, 6);
        let DuelEscrow {
            id                 : v0,
            duel_id            : v1,
            challenger         : v2,
            opponent           : _,
            stake_amount       : _,
            challenger_balance : v5,
            opponent_balance   : v6,
            status             : _,
            created_at_ms      : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v6);
        let v9 = EscrowCancelled{duel_id: v1};
        0x2::event::emit<EscrowCancelled>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v2);
    }

    public fun challenger<T0>(arg0: &DuelEscrow<T0>) : address {
        arg0.challenger
    }

    public fun create_escrow<T0>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = DuelEscrow<T0>{
            id                 : 0x2::object::new(arg4),
            duel_id            : arg0,
            challenger         : v0,
            opponent           : arg1,
            stake_amount       : v1,
            challenger_balance : 0x2::coin::into_balance<T0>(arg2),
            opponent_balance   : 0x2::balance::zero<T0>(),
            status             : 0,
            created_at_ms      : 0x2::clock::timestamp_ms(arg3),
        };
        let v3 = EscrowCreated{
            escrow_id    : 0x2::object::id<DuelEscrow<T0>>(&v2),
            duel_id      : v2.duel_id,
            challenger   : v0,
            opponent     : arg1,
            stake_amount : v1,
        };
        0x2::event::emit<EscrowCreated>(v3);
        0x2::transfer::share_object<DuelEscrow<T0>>(v2);
    }

    public fun create_open_escrow<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = DuelEscrow<T0>{
            id                 : 0x2::object::new(arg3),
            duel_id            : arg0,
            challenger         : v0,
            opponent           : @0x0,
            stake_amount       : v1,
            challenger_balance : 0x2::coin::into_balance<T0>(arg1),
            opponent_balance   : 0x2::balance::zero<T0>(),
            status             : 2,
            created_at_ms      : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = EscrowCreated{
            escrow_id    : 0x2::object::id<DuelEscrow<T0>>(&v2),
            duel_id      : v2.duel_id,
            challenger   : v0,
            opponent     : @0x0,
            stake_amount : v1,
        };
        0x2::event::emit<EscrowCreated>(v3);
        0x2::transfer::share_object<DuelEscrow<T0>>(v2);
    }

    public fun deposit_opponent_stake<T0>(arg0: &mut DuelEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.opponent, 0);
        assert!(arg0.status == 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.opponent_balance) == 0, 1);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.stake_amount, 2);
        0x2::balance::join<T0>(&mut arg0.opponent_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.status = 1;
        let v0 = EscrowActivated{
            duel_id  : arg0.duel_id,
            opponent : arg0.opponent,
        };
        0x2::event::emit<EscrowActivated>(v0);
    }

    public fun duel_id<T0>(arg0: &DuelEscrow<T0>) : vector<u8> {
        arg0.duel_id
    }

    public fun force_cancel<T0>(arg0: &BackendCap, arg1: DuelEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let DuelEscrow {
            id                 : v0,
            duel_id            : v1,
            challenger         : v2,
            opponent           : v3,
            stake_amount       : _,
            challenger_balance : v5,
            opponent_balance   : v6,
            status             : _,
            created_at_ms      : _,
        } = arg1;
        let v9 = v6;
        0x2::object::delete(v0);
        let v10 = EscrowCancelled{duel_id: v1};
        0x2::event::emit<EscrowCancelled>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v2);
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg2), v3);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BackendCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BackendCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_active<T0>(arg0: &DuelEscrow<T0>) : bool {
        arg0.status == 1
    }

    public fun is_open<T0>(arg0: &DuelEscrow<T0>) : bool {
        arg0.status == 2
    }

    public fun is_pending<T0>(arg0: &DuelEscrow<T0>) : bool {
        arg0.status == 0
    }

    public fun opponent<T0>(arg0: &DuelEscrow<T0>) : address {
        arg0.opponent
    }

    public fun set_opponent<T0>(arg0: &BackendCap, arg1: &mut DuelEscrow<T0>, arg2: address) {
        assert!(arg1.status == 2, 8);
        arg1.opponent = arg2;
        arg1.status = 0;
        let v0 = EscrowOpponentSet{
            escrow_id : 0x2::object::id<DuelEscrow<T0>>(arg1),
            duel_id   : arg1.duel_id,
            opponent  : arg2,
        };
        0x2::event::emit<EscrowOpponentSet>(v0);
    }

    public fun settle<T0>(arg0: &BackendCap, arg1: DuelEscrow<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 4);
        assert!(arg2 == arg1.challenger || arg2 == arg1.opponent, 5);
        let DuelEscrow {
            id                 : v0,
            duel_id            : v1,
            challenger         : _,
            opponent           : _,
            stake_amount       : _,
            challenger_balance : v5,
            opponent_balance   : v6,
            status             : _,
            created_at_ms      : _,
        } = arg1;
        let v9 = v6;
        let v10 = v5;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut v10, v9);
        let v11 = EscrowSettled{
            duel_id      : v1,
            winner       : arg2,
            total_amount : 0x2::balance::value<T0>(&v10) + 0x2::balance::value<T0>(&v9),
        };
        0x2::event::emit<EscrowSettled>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg3), arg2);
    }

    public fun settle_tied<T0>(arg0: &BackendCap, arg1: DuelEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 4);
        let DuelEscrow {
            id                 : v0,
            duel_id            : v1,
            challenger         : v2,
            opponent           : v3,
            stake_amount       : v4,
            challenger_balance : v5,
            opponent_balance   : v6,
            status             : _,
            created_at_ms      : _,
        } = arg1;
        0x2::object::delete(v0);
        let v9 = EscrowTied{
            duel_id      : v1,
            stake_amount : v4,
        };
        0x2::event::emit<EscrowTied>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg2), v3);
    }

    public fun stake_amount<T0>(arg0: &DuelEscrow<T0>) : u64 {
        arg0.stake_amount
    }

    public fun status<T0>(arg0: &DuelEscrow<T0>) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

