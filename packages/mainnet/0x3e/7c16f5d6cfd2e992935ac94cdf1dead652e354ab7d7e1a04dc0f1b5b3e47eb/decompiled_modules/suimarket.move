module 0x3e7c16f5d6cfd2e992935ac94cdf1dead652e354ab7d7e1a04dc0f1b5b3e47eb::suimarket {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeVault has store, key {
        id: 0x2::object::UID,
        recipient: address,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        title: vector<u8>,
        description: vector<u8>,
        label_a: vector<u8>,
        label_b: vector<u8>,
        category: vector<u8>,
        created_at: u64,
        betting_ends_at: u64,
        expires_at: u64,
        betting_closed: bool,
        admin: address,
        creator: address,
        fee_vault_id: 0x2::object::ID,
        a_total: u64,
        b_total: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_earnings: 0x2::balance::Balance<0x2::sui::SUI>,
        resolved: bool,
        cancelled: bool,
        cancel_reason: vector<u8>,
        outcome: u8,
        resolved_at: u64,
        snap_a: u64,
        snap_b: u64,
        snap_total: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        side: u8,
        amount: u64,
        placed_at: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        admin: address,
        creator: address,
        title: vector<u8>,
        description: vector<u8>,
        label_a: vector<u8>,
        label_b: vector<u8>,
        category: vector<u8>,
        betting_ends_at: u64,
        expires_at: u64,
        creation_fee_paid: u64,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        net_amount: u64,
        platform_fee: u64,
        creator_fee: u64,
        timestamp: u64,
    }

    struct BettingClosed has copy, drop {
        market_id: 0x2::object::ID,
        closed_at: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        total_pool: u64,
        a_total: u64,
        b_total: u64,
        resolved_at: u64,
    }

    struct MarketCancelled has copy, drop {
        market_id: 0x2::object::ID,
        reason: vector<u8>,
        cancelled_at: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
        stake: u64,
        payout: u64,
    }

    struct RefundClaimed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct CreatorEarningsWithdrawn has copy, drop {
        market_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct FeesWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct PlatformPaused has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct EmergencyRefund has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        refund_recipient: address,
        amount: u64,
    }

    entry fun bet_a(arg0: &mut FeeVault, arg1: &mut Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal(arg0, arg1, 1, arg2, arg3, arg4);
    }

    entry fun bet_b(arg0: &mut FeeVault, arg1: &mut Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal(arg0, arg1, 2, arg2, arg3, arg4);
    }

    fun bet_internal(arg0: &mut FeeVault, arg1: &mut Market, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused && 0x2::object::uid_to_inner(&arg0.id) == arg1.fee_vault_id, 100);
        let v0 = if (!arg1.resolved) {
            if (!arg1.cancelled) {
                !arg1.betting_closed
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 101);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 < arg1.betting_ends_at, 103);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= 10000000 && v2 <= 100000000000, 403);
        let v3 = mul_div_u64(v2, 150 - 50, 10000);
        let v4 = mul_div_u64(v2, 50, 10000);
        let v5 = v2 - v3 - v4;
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_earnings, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, v6);
        if (arg2 == 1) {
            arg1.a_total = arg1.a_total + v5;
        } else {
            arg1.b_total = arg1.b_total + v5;
        };
        let v7 = Position{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            side      : arg2,
            amount    : v5,
            placed_at : v1,
        };
        let v8 = BetPlaced{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            position_id  : 0x2::object::uid_to_inner(&v7.id),
            bettor       : 0x2::tx_context::sender(arg5),
            side         : arg2,
            net_amount   : v5,
            platform_fee : v3,
            creator_fee  : v4,
            timestamp    : v1,
        };
        0x2::event::emit<BetPlaced>(v8);
        0x2::transfer::transfer<Position>(v7, 0x2::tx_context::sender(arg5));
    }

    public fun calculate_potential_payout(arg0: &Market, arg1: u8, arg2: u64) : u64 {
        let v0 = arg2 - mul_div_u64(arg2, 150, 10000);
        let v1 = if (arg1 == 1) {
            arg0.a_total + v0
        } else {
            arg0.b_total + v0
        };
        if (v1 == 0) {
            return 0
        };
        mul_div_u64(arg0.a_total + arg0.b_total + v0, v0, v1)
    }

    entry fun cancel_market(arg0: &AdminCap, arg1: &mut Market, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved && !arg1.cancelled, 202);
        arg1.cancelled = true;
        arg1.cancel_reason = arg2;
        let v0 = MarketCancelled{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            reason       : arg2,
            cancelled_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketCancelled>(v0);
    }

    entry fun claim(arg0: &mut Market, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 200);
        let Position {
            id        : v0,
            market_id : v1,
            side      : v2,
            amount    : v3,
            placed_at : _,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id) && v2 == arg0.outcome, 300);
        let v6 = if (arg0.outcome == 1) {
            arg0.snap_a
        } else {
            arg0.snap_b
        };
        assert!(v6 > 0, 302);
        let v7 = mul_div_u64(arg0.snap_total, v3, v6);
        assert!(v7 > 0, 303);
        let v8 = WinningsClaimed{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            position_id : 0x2::object::uid_to_inner(&v5),
            claimer     : 0x2::tx_context::sender(arg2),
            stake       : v3,
            payout      : v7,
        };
        0x2::event::emit<WinningsClaimed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v7), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v5);
    }

    entry fun claim_refund(arg0: &mut Market, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.cancelled, 200);
        let Position {
            id        : v0,
            market_id : v1,
            side      : _,
            amount    : v3,
            placed_at : _,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 300);
        let v6 = RefundClaimed{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            position_id : 0x2::object::uid_to_inner(&v5),
            claimer     : 0x2::tx_context::sender(arg2),
            amount      : v3,
        };
        0x2::event::emit<RefundClaimed>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v3), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v5);
    }

    entry fun close_betting(arg0: &AdminCap, arg1: &mut Market, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg1.resolved) {
            if (!arg1.cancelled) {
                !arg1.betting_closed
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        arg1.betting_closed = true;
        let v1 = BettingClosed{
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            closed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BettingClosed>(v1);
    }

    entry fun create_market(arg0: &mut FeeVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 409);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 500000000, 406);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = if (0x1::vector::length<u8>(&arg2) > 0) {
            if (0x1::vector::length<u8>(&arg3) > 0) {
                if (0x1::vector::length<u8>(&arg4) > 0) {
                    0x1::vector::length<u8>(&arg5) > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 400);
        let v1 = if (0x1::vector::length<u8>(&arg3) <= 500) {
            if (0x1::vector::length<u8>(&arg4) <= 10) {
                0x1::vector::length<u8>(&arg5) <= 10
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 404);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = if (arg7 > v2 + 3600000) {
            if (arg8 >= arg7) {
                arg8 - v2 <= 31536000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 402);
        let v4 = Market{
            id               : 0x2::object::new(arg10),
            title            : arg2,
            description      : arg3,
            label_a          : arg4,
            label_b          : arg5,
            category         : arg6,
            created_at       : v2,
            betting_ends_at  : arg7,
            expires_at       : arg8,
            betting_closed   : false,
            admin            : arg0.recipient,
            creator          : 0x2::tx_context::sender(arg10),
            fee_vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            a_total          : 0,
            b_total          : 0,
            vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_earnings : 0x2::balance::zero<0x2::sui::SUI>(),
            resolved         : false,
            cancelled        : false,
            cancel_reason    : 0x1::vector::empty<u8>(),
            outcome          : 0,
            resolved_at      : 0,
            snap_a           : 0,
            snap_b           : 0,
            snap_total       : 0,
        };
        let v5 = MarketCreated{
            market_id         : 0x2::object::uid_to_inner(&v4.id),
            admin             : v4.admin,
            creator           : v4.creator,
            title             : v4.title,
            description       : v4.description,
            label_a           : v4.label_a,
            label_b           : v4.label_b,
            category          : v4.category,
            betting_ends_at   : arg7,
            expires_at        : arg8,
            creation_fee_paid : 500000000,
        };
        0x2::event::emit<MarketCreated>(v5);
        0x2::transfer::share_object<Market>(v4);
    }

    entry fun emergency_refund(arg0: &AdminCap, arg1: &mut Market, arg2: Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved && !arg1.cancelled, 202);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.expires_at + 2592000000, 203);
        let Position {
            id        : v0,
            market_id : v1,
            side      : _,
            amount    : v3,
            placed_at : _,
        } = arg2;
        let v5 = v0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg1.id), 300);
        let v6 = EmergencyRefund{
            market_id        : 0x2::object::uid_to_inner(&arg1.id),
            position_id      : 0x2::object::uid_to_inner(&v5),
            refund_recipient : 0x2::tx_context::sender(arg4),
            amount           : v3,
        };
        0x2::event::emit<EmergencyRefund>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v3), arg4), 0x2::tx_context::sender(arg4));
        0x2::object::delete(v5);
    }

    public fun get_current_odds(arg0: &Market) : (u64, u64) {
        let v0 = arg0.a_total + arg0.b_total;
        if (v0 == 0) {
            return (5000, 5000)
        };
        (mul_div_u64(arg0.a_total, 10000, v0), mul_div_u64(arg0.b_total, 10000, v0))
    }

    public fun get_market_info(arg0: &Market) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, u64, u64, u64, bool, address, address, u64, u64, bool, bool, u8) {
        (arg0.title, arg0.description, arg0.label_a, arg0.label_b, arg0.category, arg0.created_at, arg0.betting_ends_at, arg0.expires_at, arg0.betting_closed, arg0.admin, arg0.creator, arg0.a_total, arg0.b_total, arg0.resolved, arg0.cancelled, arg0.outcome)
    }

    public fun get_position_info(arg0: &Position) : (0x2::object::ID, u8, u64, u64) {
        (arg0.market_id, arg0.side, arg0.amount, arg0.placed_at)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeVault{
            id        : 0x2::object::new(arg0),
            recipient : 0x2::tx_context::sender(arg0),
            fees      : 0x2::balance::zero<0x2::sui::SUI>(),
            paused    : false,
        };
        0x2::transfer::share_object<FeeVault>(v1);
    }

    fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 303);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    entry fun pause_platform(arg0: &AdminCap, arg1: &mut FeeVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = PlatformPaused{
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    entry fun resolve(arg0: &AdminCap, arg1: &mut Market, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg1.resolved) {
            if (!arg1.cancelled) {
                arg2 == 1 || arg2 == 2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 202);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.betting_closed || v1 >= arg1.expires_at, 204);
        let v2 = arg1.a_total + arg1.b_total;
        assert!(v2 >= 10000000, 205);
        arg1.resolved = true;
        arg1.outcome = arg2;
        arg1.resolved_at = v1;
        arg1.snap_a = arg1.a_total;
        arg1.snap_b = arg1.b_total;
        arg1.snap_total = v2;
        let v3 = MarketResolved{
            market_id   : 0x2::object::uid_to_inner(&arg1.id),
            outcome     : arg2,
            total_pool  : v2,
            a_total     : arg1.snap_a,
            b_total     : arg1.snap_b,
            resolved_at : v1,
        };
        0x2::event::emit<MarketResolved>(v3);
    }

    entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeVault, arg2: address) {
        arg1.recipient = arg2;
    }

    entry fun unpause_platform(arg0: &AdminCap, arg1: &mut FeeVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = PlatformPaused{
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    entry fun withdraw_creator_earnings(arg0: &mut Market, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 304);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_earnings);
        assert!(v0 > 0, 303);
        let v1 = CreatorEarningsWithdrawn{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<CreatorEarningsWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_earnings, v0), arg1), arg0.creator);
    }

    entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut FeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fees);
        assert!(v0 > 0, 303);
        let v1 = FeesWithdrawn{
            recipient : arg1.recipient,
            amount    : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fees, v0), arg2), arg1.recipient);
    }

    // decompiled from Move bytecode v6
}

