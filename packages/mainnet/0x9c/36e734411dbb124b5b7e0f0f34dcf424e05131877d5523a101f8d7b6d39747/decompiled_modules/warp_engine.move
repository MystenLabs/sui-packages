module 0x9c36e734411dbb124b5b7e0f0f34dcf424e05131877d5523a101f8d7b6d39747::warp_engine {
    struct WarpEscrow has key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        bet_count: u64,
        win_count: u64,
    }

    struct WarpStats has key {
        id: 0x2::object::UID,
        total_batches: u64,
        total_settled: u64,
        total_voided: u64,
        max_batch_size: u64,
        last_batch_ts: u64,
    }

    struct WarpAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WarpEscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct WarpEscrowDeposit has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        coin_type: vector<u8>,
        timestamp: u64,
    }

    struct WarpEscrowWithdraw has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        coin_type: vector<u8>,
        timestamp: u64,
    }

    struct WarpBatchSettled has copy, drop {
        batch_id: u64,
        count: u64,
        voided: u64,
        timestamp: u64,
    }

    struct WarpParlayAtomicSettled has copy, drop {
        parlay_id: 0x2::object::ID,
        legs_verified: u64,
        maker_wins: bool,
        timestamp: u64,
    }

    public entry fun create_warp_escrow(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = WarpEscrow{
            id        : 0x2::object::new(arg1),
            owner     : v0,
            balances  : 0x2::bag::new(arg1),
            bet_count : 0,
            win_count : 0,
        };
        let v2 = WarpEscrowCreated{
            escrow_id : 0x2::object::id<WarpEscrow>(&v1),
            owner     : v0,
            timestamp : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<WarpEscrowCreated>(v2);
        0x2::transfer::transfer<WarpEscrow>(v1, v0);
    }

    public entry fun deposit_to_escrow<T0>(arg0: &mut WarpEscrow, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 100);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = WarpEscrowDeposit{
            escrow_id : 0x2::object::id<WarpEscrow>(arg0),
            owner     : arg0.owner,
            amount    : 0x2::coin::value<T0>(&arg1),
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WarpEscrowDeposit>(v1);
    }

    public fun escrow_balance<T0>(arg0: &WarpEscrow) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun escrow_bet_count(arg0: &WarpEscrow) : u64 {
        arg0.bet_count
    }

    public fun escrow_owner(arg0: &WarpEscrow) : address {
        arg0.owner
    }

    public fun escrow_win_count(arg0: &WarpEscrow) : u64 {
        arg0.win_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WarpStats{
            id             : 0x2::object::new(arg0),
            total_batches  : 0,
            total_settled  : 0,
            total_voided   : 0,
            max_batch_size : 0,
            last_batch_ts  : 0,
        };
        let v1 = WarpAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<WarpStats>(v0);
        0x2::transfer::transfer<WarpAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun stats_last_batch_ts(arg0: &WarpStats) : u64 {
        arg0.last_batch_ts
    }

    public fun stats_max_batch_size(arg0: &WarpStats) : u64 {
        arg0.max_batch_size
    }

    public fun stats_total_batches(arg0: &WarpStats) : u64 {
        arg0.total_batches
    }

    public fun stats_total_settled(arg0: &WarpStats) : u64 {
        arg0.total_settled
    }

    public fun stats_total_voided(arg0: &WarpStats) : u64 {
        arg0.total_voided
    }

    public entry fun warp_batch_marker(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut WarpStats, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 103);
        assert!(arg2 <= 512, 104);
        arg1.total_batches = arg1.total_batches + 1;
        arg1.total_settled = arg1.total_settled + arg2;
        arg1.total_voided = arg1.total_voided + arg3;
        arg1.last_batch_ts = 0x2::clock::timestamp_ms(arg4);
        if (arg2 + arg3 > arg1.max_batch_size) {
            arg1.max_batch_size = arg2 + arg3;
        };
        let v0 = WarpBatchSettled{
            batch_id  : arg1.total_batches,
            count     : arg2,
            voided    : arg3,
            timestamp : arg1.last_batch_ts,
        };
        0x2::event::emit<WarpBatchSettled>(v0);
    }

    public entry fun warp_settle_parlay_atomic<T0>(arg0: &0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::OracleCap, arg1: &mut 0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::P2PConfig, arg2: &mut 0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::P2PRegistry, arg3: &mut 0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::P2PParlay<T0>, arg4: vector<bool>, arg5: vector<bool>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::parlay_num_legs<T0>(arg3);
        assert!(0x1::vector::length<bool>(&arg4) == v0, 102);
        assert!(0x1::vector::length<bool>(&arg5) == v0, 105);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<bool>(&arg5, v1)) {
                0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::void_parlay_leg<T0>(arg0, arg3, v1, arg6);
            } else {
                v3 = v3 + 1;
                let v4 = *0x1::vector::borrow<bool>(&arg4, v1);
                0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::settle_parlay_leg<T0>(arg0, arg3, v1, v4, arg6);
                if (!v4) {
                    v2 = true;
                };
            };
            v1 = v1 + 1;
        };
        assert!(v3 > 0, 106);
        let v5 = !v2;
        let v6 = WarpParlayAtomicSettled{
            parlay_id     : 0x2::object::id<0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::P2PParlay<T0>>(arg3),
            legs_verified : v0,
            maker_wins    : v5,
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<WarpParlayAtomicSettled>(v6);
        0xd51fe151bec66a15b086a67c1cfce9b05759ddac1d73fcd3e14324ad202b2e59::p2p_betting::instant_settle_parlay<T0>(arg0, arg1, arg2, arg3, v5, arg6, arg7);
    }

    public fun warp_spend_from_escrow<T0>(arg0: &mut WarpEscrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 100);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 101);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 101);
        arg0.bet_count = arg0.bet_count + 1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public entry fun withdraw_from_escrow<T0>(arg0: &mut WarpEscrow, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 100);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 101);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 101);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg3);
        let v3 = WarpEscrowWithdraw{
            escrow_id : 0x2::object::id<WarpEscrow>(arg0),
            owner     : arg0.owner,
            amount    : arg1,
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WarpEscrowWithdraw>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.owner);
    }

    // decompiled from Move bytecode v6
}

