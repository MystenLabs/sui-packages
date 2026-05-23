module 0x88e900326dda4d837dd13144034bc3c339917cb22b3cdc87ff1bddde3e4389e1::gnv_presale {
    struct Reservation has store {
        total_gnv: u64,
        claimed_gnv: u64,
        purchase_round: u8,
        purchase_price: u64,
        purchase_ts: u64,
        tge_claimed: bool,
    }

    struct PresaleState<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        tge_timestamp_ms: u64,
        current_round: u8,
        presale_pool: 0x2::balance::Balance<T0>,
        staking_pool: 0x2::balance::Balance<T0>,
        burned_total: u64,
        reservations: 0x2::table::Table<address, Reservation>,
        stakes: 0x2::table::Table<address, StakeInfo>,
        round_sold: vector<u64>,
        proposals: 0x2::table::Table<u64, Proposal>,
        proposal_count: u64,
        operator_issued: bool,
    }

    struct StakeInfo has store {
        staked_amount: u64,
        stake_ts: u64,
        last_claim_ts: u64,
        lock_duration_ms: u64,
        rewards_claimed: u64,
    }

    struct Proposal has store {
        id: u64,
        proposer: address,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        deadline_ms: u64,
        executed: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
    }

    struct PresaleInitCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventReserved has copy, drop {
        buyer: address,
        gnv_amount: u64,
        usd_amount: u64,
        round: u8,
    }

    struct EventReservedMultiRound has copy, drop {
        buyer: address,
        total_gnv: u64,
        total_usd: u64,
        round_from: u8,
        round_to: u8,
    }

    struct EventRoundCompleted has copy, drop {
        completed_round: u8,
        next_round: u8,
    }

    struct EventRoundAlert90 has copy, drop {
        round: u8,
        sold: u64,
        cap: u64,
        percent_bps: u64,
    }

    struct EventPresaleEnded has copy, drop {
        total_sold: u64,
        last_round: u8,
    }

    struct EventClaimed has copy, drop {
        claimer: address,
        gnv_amount: u64,
        claim_type: u8,
    }

    struct EventStaked has copy, drop {
        staker: address,
        amount: u64,
        lock_duration_ms: u64,
    }

    struct EventUnstaked has copy, drop {
        staker: address,
        amount: u64,
        rewards: u64,
    }

    struct EventBurned has copy, drop {
        burner: address,
        amount: u64,
        operation: u8,
    }

    struct EventRoundChanged has copy, drop {
        new_round: u8,
        price: u64,
    }

    struct EventTGESet has copy, drop {
        tge_timestamp_ms: u64,
    }

    struct EventOperatorIssued has copy, drop {
        operator_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct EventOperatorRevoked has copy, drop {
        revoke_method: u8,
    }

    public fun admin_force_tge<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.tge_timestamp_ms == 0 || v0 < arg0.tge_timestamp_ms, 20);
        assert!(arg2 > v0, 21);
        arg0.tge_timestamp_ms = arg2;
        let v1 = EventTGESet{tge_timestamp_ms: arg2};
        0x2::event::emit<EventTGESet>(v1);
    }

    fun advance_round<T0>(arg0: &mut PresaleState<T0>) : bool {
        let v0 = arg0.current_round + 1;
        if (v0 >= 10) {
            arg0.paused = true;
            false
        } else {
            arg0.current_round = v0;
            true
        }
    }

    public fun burn_auth<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 0, arg2);
    }

    public fun burn_biolock_update<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 4, arg2);
    }

    public fun burn_data_share<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 2, arg2);
    }

    fun burn_op<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.burned_total = arg0.burned_total + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v1 = EventBurned{
            burner    : 0x2::tx_context::sender(arg3),
            amount    : v0,
            operation : arg2,
        };
        0x2::event::emit<EventBurned>(v1);
    }

    public fun burn_service_activate<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 5, arg2);
    }

    public fun burn_tx_sign<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 1, arg2);
    }

    public fun burn_verify<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        burn_op<T0>(arg0, arg1, 3, arg2);
    }

    public fun calc_gnv_for_usd<T0>(arg0: &PresaleState<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = (arg0.current_round as u64);
        while (arg1 > 0 && v1 < 10) {
            let v2 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
            let v3 = *0x1::vector::borrow<u64>(&v2, v1);
            let v4 = vector[10000000000000000, 20000000000000000, 30000000000000000, 50000000000000000, 70000000000000000, 90000000000000000, 110000000000000000, 150000000000000000, 190000000000000000, 240000000000000000];
            let v5 = *0x1::vector::borrow<u64>(&v4, v1);
            let v6 = *0x1::vector::borrow<u64>(&arg0.round_sold, v1);
            let v7 = if (v5 > v6) {
                v5 - v6
            } else {
                0
            };
            if (v7 == 0) {
                v1 = v1 + 1;
                continue
            };
            let v8 = (arg1 as u128) * 1000000000 / (v3 as u128);
            let v9 = if (v8 <= (v7 as u128)) {
                (v8 as u64)
            } else {
                v7
            };
            let v10 = if (v8 <= (v7 as u128)) {
                arg1
            } else {
                (((v7 as u128) * (v3 as u128) / 1000000000) as u64)
            };
            v0 = v0 + v9;
            arg1 = arg1 - v10;
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_rewards<T0>(arg0: &PresaleState<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow<address, StakeInfo>(&arg0.stakes, arg1);
        (((v0.staked_amount as u128) * (2400 as u128) * ((arg2 - v0.last_claim_ts) as u128) / (10000 as u128) * (31536000000 as u128)) as u64)
    }

    public fun claim<T0>(arg0: &mut PresaleState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.tge_timestamp_ms > 0, 6);
        assert!(0x2::table::contains<address, Reservation>(&arg0.reservations, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg0.tge_timestamp_ms;
        assert!(v1 >= v2, 7);
        let v3 = 0x2::table::borrow_mut<address, Reservation>(&mut arg0.reservations, v0);
        let v4 = 0;
        let v5 = v4;
        if (!v3.tge_claimed) {
            let v6 = v3.total_gnv * 2000 / 10000;
            v5 = v4 + v6;
            v3.tge_claimed = true;
            let v7 = EventClaimed{
                claimer    : v0,
                gnv_amount : v6,
                claim_type : 0,
            };
            0x2::event::emit<EventClaimed>(v7);
        };
        let v8 = (v1 - v2) / 2592000000;
        let v9 = if (v8 > 6) {
            6
        } else {
            v8
        };
        let v10 = (v3.total_gnv - v3.total_gnv * 2000 / 10000) * v9 / 6;
        let v11 = v3.total_gnv * 2000 / 10000;
        let v12 = if (v3.claimed_gnv > v11) {
            v3.claimed_gnv - v11
        } else {
            0
        };
        if (v10 > v12) {
            let v13 = v10 - v12;
            v5 = v5 + v13;
            let v14 = EventClaimed{
                claimer    : v0,
                gnv_amount : v13,
                claim_type : 1,
            };
            0x2::event::emit<EventClaimed>(v14);
        };
        assert!(v5 > 0, 8);
        v3.claimed_gnv = v3.claimed_gnv + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.presale_pool, v5), arg2), v0);
    }

    public fun claim_staking_rewards<T0>(arg0: &mut PresaleState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = calculate_rewards<T0>(arg0, v0, v1);
        assert!(v2 > 0, 8);
        let v3 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v0);
        v3.last_claim_ts = v1;
        v3.rewards_claimed = v3.rewards_claimed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staking_pool, v2), arg2), v0);
        let v4 = EventClaimed{
            claimer    : v0,
            gnv_amount : v2,
            claim_type : 2,
        };
        0x2::event::emit<EventClaimed>(v4);
    }

    fun compute_total_sold(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 10) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_burned_total<T0>(arg0: &PresaleState<T0>) : u64 {
        arg0.burned_total
    }

    public fun get_current_round<T0>(arg0: &PresaleState<T0>) : (u8, u64) {
        let v0 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
        (arg0.current_round, *0x1::vector::borrow<u64>(&v0, (arg0.current_round as u64)))
    }

    public fun get_reservation<T0>(arg0: &PresaleState<T0>, arg1: address) : (u64, u64, u8) {
        if (!0x2::table::contains<address, Reservation>(&arg0.reservations, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Reservation>(&arg0.reservations, arg1);
        (v0.total_gnv, v0.claimed_gnv, v0.purchase_round)
    }

    public fun get_reservation_v2<T0>(arg0: &PresaleState<T0>, arg1: address) : (u64, u64, u8, bool, u64) {
        if (!0x2::table::contains<address, Reservation>(&arg0.reservations, arg1)) {
            return (0, 0, 0, false, 0)
        };
        let v0 = 0x2::table::borrow<address, Reservation>(&arg0.reservations, arg1);
        (v0.total_gnv, v0.claimed_gnv, v0.purchase_round, v0.tge_claimed, v0.purchase_price)
    }

    public fun get_round_remaining<T0>(arg0: &PresaleState<T0>) : u64 {
        let v0 = (arg0.current_round as u64);
        let v1 = vector[10000000000000000, 20000000000000000, 30000000000000000, 50000000000000000, 70000000000000000, 90000000000000000, 110000000000000000, 150000000000000000, 190000000000000000, 240000000000000000];
        let v2 = *0x1::vector::borrow<u64>(&v1, v0);
        let v3 = *0x1::vector::borrow<u64>(&arg0.round_sold, v0);
        if (v2 > v3) {
            v2 - v3
        } else {
            0
        }
    }

    public fun get_round_sold<T0>(arg0: &PresaleState<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.round_sold, arg1)
    }

    public fun get_stake_info<T0>(arg0: &PresaleState<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, StakeInfo>(&arg0.stakes, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, StakeInfo>(&arg0.stakes, arg1);
        (v0.staked_amount, v0.rewards_claimed)
    }

    public fun get_tge<T0>(arg0: &PresaleState<T0>) : u64 {
        arg0.tge_timestamp_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleInitCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PresaleInitCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0>(arg0: PresaleInitCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let PresaleInitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::object::new(arg3);
        let v3 = PresaleState<T0>{
            id               : v2,
            admin            : v1,
            paused           : false,
            tge_timestamp_ms : 0,
            current_round    : 0,
            presale_pool     : 0x2::coin::into_balance<T0>(arg1),
            staking_pool     : 0x2::coin::into_balance<T0>(arg2),
            burned_total     : 0,
            reservations     : 0x2::table::new<address, Reservation>(arg3),
            stakes           : 0x2::table::new<address, StakeInfo>(arg3),
            round_sold       : vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            proposals        : 0x2::table::new<u64, Proposal>(arg3),
            proposal_count   : 0,
            operator_issued  : false,
        };
        let v4 = AdminCap{
            id         : 0x2::object::new(arg3),
            presale_id : 0x2::object::uid_to_inner(&v2),
        };
        0x2::transfer::share_object<PresaleState<T0>>(v3);
        0x2::transfer::transfer<AdminCap>(v4, v1);
    }

    public fun is_operator_active<T0>(arg0: &PresaleState<T0>) : bool {
        arg0.operator_issued
    }

    public fun is_paused<T0>(arg0: &PresaleState<T0>) : bool {
        arg0.paused
    }

    public fun is_presale_ended<T0>(arg0: &PresaleState<T0>) : bool {
        if (!arg0.paused) {
            return false
        };
        let v0 = vector[10000000000000000, 20000000000000000, 30000000000000000, 50000000000000000, 70000000000000000, 90000000000000000, 110000000000000000, 150000000000000000, 190000000000000000, 240000000000000000];
        *0x1::vector::borrow<u64>(&arg0.round_sold, 9) >= *0x1::vector::borrow<u64>(&v0, 9)
    }

    public fun issue_operator<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.operator_issued, 23);
        arg0.operator_issued = true;
        let v0 = OperatorCap{
            id         : 0x2::object::new(arg3),
            presale_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        let v1 = EventOperatorIssued{
            operator_cap_id : 0x2::object::id<OperatorCap>(&v0),
            recipient       : arg2,
        };
        0x2::event::emit<EventOperatorIssued>(v1);
    }

    public fun reserve<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        reserve_internal<T0>(arg0, arg2, arg3, arg4);
    }

    fun reserve_internal<T0>(arg0: &mut PresaleState<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!arg0.paused, 2);
        assert!(arg2 >= 15000000, 14);
        assert!(arg0.current_round < 10, 4);
        let v0 = arg2;
        let v1 = 0;
        let v2 = arg0.current_round;
        let v3 = arg0.current_round;
        while (v0 > 0 && arg0.current_round < 10) {
            let v4 = (arg0.current_round as u64);
            let v5 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
            let v6 = *0x1::vector::borrow<u64>(&v5, v4);
            let v7 = vector[10000000000000000, 20000000000000000, 30000000000000000, 50000000000000000, 70000000000000000, 90000000000000000, 110000000000000000, 150000000000000000, 190000000000000000, 240000000000000000];
            let v8 = *0x1::vector::borrow<u64>(&v7, v4);
            let v9 = *0x1::vector::borrow<u64>(&arg0.round_sold, v4);
            let v10 = v8 - v9;
            if (v10 == 0) {
                advance_round<T0>(arg0);
                continue
            };
            let v11 = (v0 as u128) * 1000000000 / (v6 as u128);
            let (v12, v13) = if (v11 <= (v10 as u128)) {
                let v13 = v0;
                ((v11 as u64), v13)
            } else {
                (v10, (((v10 as u128) * (v6 as u128) / 1000000000) as u64))
            };
            if (v12 == 0) {
                break
            };
            let v14 = v9 + v12;
            *0x1::vector::borrow_mut<u64>(&mut arg0.round_sold, v4) = v14;
            v1 = v1 + v12;
            v0 = v0 - v13;
            v3 = arg0.current_round;
            let v15 = EventReserved{
                buyer      : arg1,
                gnv_amount : v12,
                usd_amount : v13,
                round      : arg0.current_round,
            };
            0x2::event::emit<EventReserved>(v15);
            let v16 = (((v14 as u128) * (10000 as u128) / (v8 as u128)) as u64);
            if (v16 >= 9000) {
                let v17 = EventRoundAlert90{
                    round       : arg0.current_round,
                    sold        : v14,
                    cap         : v8,
                    percent_bps : v16,
                };
                0x2::event::emit<EventRoundAlert90>(v17);
            };
            if (v14 >= v8) {
                let v18 = arg0.current_round;
                if (advance_round<T0>(arg0)) {
                    let v19 = EventRoundCompleted{
                        completed_round : v18,
                        next_round      : arg0.current_round,
                    };
                    0x2::event::emit<EventRoundCompleted>(v19);
                    let v20 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
                    let v21 = EventRoundChanged{
                        new_round : arg0.current_round,
                        price     : *0x1::vector::borrow<u64>(&v20, (arg0.current_round as u64)),
                    };
                    0x2::event::emit<EventRoundChanged>(v21);
                } else {
                    let v22 = EventPresaleEnded{
                        total_sold : compute_total_sold(&arg0.round_sold),
                        last_round : v18,
                    };
                    0x2::event::emit<EventPresaleEnded>(v22);
                    break
                };
            };
        };
        assert!(v1 > 0, 3);
        if (v3 > v2) {
            let v23 = EventReservedMultiRound{
                buyer      : arg1,
                total_gnv  : v1,
                total_usd  : arg2 - v0,
                round_from : v2,
                round_to   : v3,
            };
            0x2::event::emit<EventReservedMultiRound>(v23);
        };
        if (0x2::table::contains<address, Reservation>(&arg0.reservations, arg1)) {
            let v24 = 0x2::table::borrow_mut<address, Reservation>(&mut arg0.reservations, arg1);
            v24.total_gnv = v24.total_gnv + v1;
        } else {
            let v25 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
            let v26 = Reservation{
                total_gnv      : v1,
                claimed_gnv    : 0,
                purchase_round : v2,
                purchase_price : *0x1::vector::borrow<u64>(&v25, (v2 as u64)),
                purchase_ts    : 0x2::clock::timestamp_ms(arg3),
                tge_claimed    : false,
            };
            0x2::table::add<address, Reservation>(&mut arg0.reservations, arg1, v26);
        };
    }

    public fun reserve_v3<T0>(arg0: &mut PresaleState<T0>, arg1: &OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operator_issued, 24);
        reserve_internal<T0>(arg0, arg2, arg3, arg4);
    }

    public fun revoke_operator<T0>(arg0: &mut PresaleState<T0>, arg1: OperatorCap, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let OperatorCap {
            id         : v0,
            presale_id : _,
        } = arg1;
        0x2::object::delete(v0);
        arg0.operator_issued = false;
        let v2 = EventOperatorRevoked{revoke_method: 0};
        0x2::event::emit<EventOperatorRevoked>(v2);
    }

    public fun revoke_operator_by_id<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.operator_issued = false;
        let v0 = EventOperatorRevoked{revoke_method: 1};
        0x2::event::emit<EventOperatorRevoked>(v0);
    }

    public fun set_paused<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
    }

    public fun set_round<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!((arg2 as u64) < 10, 4);
        assert!(arg2 >= arg0.current_round, 22);
        arg0.current_round = arg2;
        let v0 = vector[4200, 4500, 4800, 5100, 5500, 5900, 6300, 6700, 7200, 7700];
        let v1 = EventRoundChanged{
            new_round : arg2,
            price     : *0x1::vector::borrow<u64>(&v0, (arg2 as u64)),
        };
        0x2::event::emit<EventRoundChanged>(v1);
    }

    public fun set_tge<T0>(arg0: &mut PresaleState<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tge_timestamp_ms == 0, 11);
        arg0.tge_timestamp_ms = arg2;
        let v0 = EventTGESet{tge_timestamp_ms: arg2};
        0x2::event::emit<EventTGESet>(v0);
    }

    public fun stake<T0>(arg0: &mut PresaleState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 12);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = arg2 * 2592000000;
        0x2::balance::join<T0>(&mut arg0.staking_pool, 0x2::coin::into_balance<T0>(arg1));
        if (0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0)) {
            let v4 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v0);
            v4.staked_amount = v4.staked_amount + v1;
            v4.last_claim_ts = v2;
        } else {
            let v5 = StakeInfo{
                staked_amount    : v1,
                stake_ts         : v2,
                last_claim_ts    : v2,
                lock_duration_ms : v3,
                rewards_claimed  : 0,
            };
            0x2::table::add<address, StakeInfo>(&mut arg0.stakes, v0, v5);
        };
        let v6 = EventStaked{
            staker           : v0,
            amount           : v1,
            lock_duration_ms : v3,
        };
        0x2::event::emit<EventStaked>(v6);
    }

    public fun unstake<T0>(arg0: &mut PresaleState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::table::borrow<address, StakeInfo>(&arg0.stakes, v0);
        assert!(v1 >= v2.stake_ts + v2.lock_duration_ms, 10);
        let v3 = calculate_rewards<T0>(arg0, v0, v1);
        let StakeInfo {
            staked_amount    : v4,
            stake_ts         : _,
            last_claim_ts    : _,
            lock_duration_ms : _,
            rewards_claimed  : _,
        } = 0x2::table::remove<address, StakeInfo>(&mut arg0.stakes, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staking_pool, v4 + v3), arg2), v0);
        let v9 = EventUnstaked{
            staker  : v0,
            amount  : v4,
            rewards : v3,
        };
        0x2::event::emit<EventUnstaked>(v9);
    }

    // decompiled from Move bytecode v7
}

