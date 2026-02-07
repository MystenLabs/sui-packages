module 0x4a144672af540f255554ecc8d7ef9bf511146aca432929dd72c3cf2b33410343::suimarket {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        fees: 0x2::balance::Balance<T0>,
        paused: bool,
    }

    struct Market<phantom T0> has store, key {
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
        vault: 0x2::balance::Balance<T0>,
        creator_earnings: 0x2::balance::Balance<T0>,
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

    public entry fun bet_a<T0>(arg0: &mut FeeVault<T0>, arg1: &mut Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal<T0>(arg0, arg1, 1, arg2, arg3, arg4);
    }

    public entry fun bet_b<T0>(arg0: &mut FeeVault<T0>, arg1: &mut Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal<T0>(arg0, arg1, 2, arg2, arg3, arg4);
    }

    fun bet_internal<T0>(arg0: &mut FeeVault<T0>, arg1: &mut Market<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 409);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.fee_vault_id, 100);
        assert!(!arg1.resolved, 101);
        assert!(!arg1.cancelled, 104);
        assert!(!arg1.betting_closed, 103);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.betting_ends_at, 103);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= 10000, 403);
        assert!(v1 <= 100000000000, 407);
        let v2 = mul_div_u64(v1, 150 - 50, 10000);
        let v3 = mul_div_u64(v1, 50, 10000);
        let v4 = v1 - v2 - v3;
        let v5 = 0x2::coin::into_balance<T0>(arg3);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v5, v2));
        0x2::balance::join<T0>(&mut arg1.creator_earnings, 0x2::balance::split<T0>(&mut v5, v3));
        0x2::balance::join<T0>(&mut arg1.vault, v5);
        if (arg2 == 1) {
            arg1.a_total = arg1.a_total + v4;
        } else {
            arg1.b_total = arg1.b_total + v4;
        };
        let v6 = Position{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            side      : arg2,
            amount    : v4,
            placed_at : v0,
        };
        let v7 = BetPlaced{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            position_id  : 0x2::object::uid_to_inner(&v6.id),
            bettor       : 0x2::tx_context::sender(arg5),
            side         : arg2,
            net_amount   : v4,
            platform_fee : v2,
            creator_fee  : v3,
            timestamp    : v0,
        };
        0x2::event::emit<BetPlaced>(v7);
        0x2::transfer::transfer<Position>(v6, 0x2::tx_context::sender(arg5));
    }

    public entry fun cancel_market<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved, 202);
        assert!(!arg1.cancelled, 104);
        arg1.cancelled = true;
        arg1.cancel_reason = arg2;
        let v0 = MarketCancelled{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            reason       : arg2,
            cancelled_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketCancelled>(v0);
    }

    public entry fun claim<T0>(arg0: &mut Market<T0>, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 200);
        let Position {
            id        : v0,
            market_id : v1,
            side      : v2,
            amount    : v3,
            placed_at : _,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 300);
        assert!(v2 == arg0.outcome, 301);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v7), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v5);
    }

    public entry fun claim_refund<T0>(arg0: &mut Market<T0>, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v3), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v5);
    }

    public entry fun close_betting<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved, 101);
        assert!(!arg1.cancelled, 104);
        assert!(!arg1.betting_closed, 103);
        arg1.betting_closed = true;
        let v0 = BettingClosed{
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            closed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BettingClosed>(v0);
    }

    public entry fun create_fee_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault<T0>{
            id        : 0x2::object::new(arg1),
            recipient : 0x2::tx_context::sender(arg1),
            fees      : 0x2::balance::zero<T0>(),
            paused    : false,
        };
        0x2::transfer::share_object<FeeVault<T0>>(v0);
    }

    public entry fun create_market<T0>(arg0: &mut FeeVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 409);
        assert!(0x2::coin::value<T0>(&arg1) == 500000, 406);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x1::vector::length<u8>(&arg2) > 0, 400);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 400);
        assert!(0x1::vector::length<u8>(&arg3) <= 500, 410);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 401);
        assert!(0x1::vector::length<u8>(&arg5) > 0, 401);
        assert!(0x1::vector::length<u8>(&arg4) <= 10, 404);
        assert!(0x1::vector::length<u8>(&arg5) <= 10, 404);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg7 > v0 + 3600000, 402);
        assert!(arg8 >= arg7, 405);
        assert!(arg8 - v0 <= 31536000000, 408);
        let v1 = arg0.recipient;
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = Market<T0>{
            id               : 0x2::object::new(arg10),
            title            : arg2,
            description      : arg3,
            label_a          : arg4,
            label_b          : arg5,
            category         : arg6,
            created_at       : v0,
            betting_ends_at  : arg7,
            expires_at       : arg8,
            betting_closed   : false,
            admin            : v1,
            creator          : v2,
            fee_vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            a_total          : 0,
            b_total          : 0,
            vault            : 0x2::balance::zero<T0>(),
            creator_earnings : 0x2::balance::zero<T0>(),
            resolved         : false,
            cancelled        : false,
            cancel_reason    : 0x1::vector::empty<u8>(),
            outcome          : 0,
            resolved_at      : 0,
            snap_a           : 0,
            snap_b           : 0,
            snap_total       : 0,
        };
        let v4 = MarketCreated{
            market_id         : 0x2::object::uid_to_inner(&v3.id),
            admin             : v1,
            creator           : v2,
            title             : v3.title,
            description       : v3.description,
            label_a           : v3.label_a,
            label_b           : v3.label_b,
            category          : v3.category,
            betting_ends_at   : arg7,
            expires_at        : arg8,
            creation_fee_paid : 500000,
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::transfer::share_object<Market<T0>>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 303);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun pause_platform<T0>(arg0: &AdminCap, arg1: &mut FeeVault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = PlatformPaused{
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun resolve<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved, 202);
        assert!(!arg1.cancelled, 104);
        assert!(arg2 == 1 || arg2 == 2, 201);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.betting_closed || v0 >= arg1.expires_at, 204);
        let v1 = arg1.a_total + arg1.b_total;
        assert!(v1 >= 1000000, 205);
        arg1.resolved = true;
        arg1.outcome = arg2;
        arg1.resolved_at = v0;
        arg1.snap_a = arg1.a_total;
        arg1.snap_b = arg1.b_total;
        arg1.snap_total = v1;
        let v2 = MarketResolved{
            market_id   : 0x2::object::uid_to_inner(&arg1.id),
            outcome     : arg2,
            total_pool  : v1,
            a_total     : arg1.snap_a,
            b_total     : arg1.snap_b,
            resolved_at : v0,
        };
        0x2::event::emit<MarketResolved>(v2);
    }

    public entry fun set_fee_recipient<T0>(arg0: &AdminCap, arg1: &mut FeeVault<T0>, arg2: address) {
        arg1.recipient = arg2;
    }

    public entry fun unpause_platform<T0>(arg0: &AdminCap, arg1: &mut FeeVault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = PlatformPaused{
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun withdraw_creator_earnings<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.creator_earnings);
        assert!(v0 > 0, 303);
        let v1 = CreatorEarningsWithdrawn{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<CreatorEarningsWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.creator_earnings, v0), arg1), arg0.creator);
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut FeeVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.fees);
        assert!(v0 > 0, 303);
        let v1 = FeesWithdrawn{
            recipient : arg1.recipient,
            amount    : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fees, v0), arg2), arg1.recipient);
    }

    // decompiled from Move bytecode v6
}

