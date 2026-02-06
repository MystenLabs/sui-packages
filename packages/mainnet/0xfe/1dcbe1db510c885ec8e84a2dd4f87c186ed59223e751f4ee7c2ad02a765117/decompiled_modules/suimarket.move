module 0xfe1dcbe1db510c885ec8e84a2dd4f87c186ed59223e751f4ee7c2ad02a765117::suimarket {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeVault has key {
        id: 0x2::object::UID,
        recipient: address,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Market has key {
        id: 0x2::object::UID,
        title: vector<u8>,
        option_yes: vector<u8>,
        option_no: vector<u8>,
        created_at: u64,
        expires_at: u64,
        admin: address,
        creator: address,
        fee_vault_id: 0x2::object::ID,
        yes_total: u64,
        no_total: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        resolved: bool,
        outcome: u8,
        resolved_at: u64,
        snap_yes: u64,
        snap_no: u64,
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
        expires_at: u64,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        net_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        total_pool: u64,
        yes_total: u64,
        no_total: u64,
        resolved_at: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
        stake: u64,
        payout: u64,
    }

    struct FeesWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct EmergencyRefund has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        refund_recipient: address,
        amount: u64,
    }

    fun bet_internal(arg0: &mut FeeVault, arg1: &mut Market, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.fee_vault_id, 100);
        assert!(!arg1.resolved, 101);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.expires_at, 103);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 10000000, 403);
        let v2 = mul_div_u64(v1, 150, 10000);
        let v3 = v1 - v2;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, v4);
        if (arg2 == 1) {
            arg1.yes_total = arg1.yes_total + v3;
        } else {
            arg1.no_total = arg1.no_total + v3;
        };
        let v5 = Position{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            side      : arg2,
            amount    : v3,
            placed_at : v0,
        };
        let v6 = BetPlaced{
            market_id   : 0x2::object::uid_to_inner(&arg1.id),
            position_id : 0x2::object::uid_to_inner(&v5.id),
            bettor      : 0x2::tx_context::sender(arg5),
            side        : arg2,
            net_amount  : v3,
            fee_amount  : v2,
            timestamp   : v0,
        };
        0x2::event::emit<BetPlaced>(v6);
        0x2::transfer::transfer<Position>(v5, 0x2::tx_context::sender(arg5));
    }

    public entry fun bet_no(arg0: &mut FeeVault, arg1: &mut Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal(arg0, arg1, 2, arg2, arg3, arg4);
    }

    public entry fun bet_yes(arg0: &mut FeeVault, arg1: &mut Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        bet_internal(arg0, arg1, 1, arg2, arg3, arg4);
    }

    public fun calculate_potential_payout(arg0: &Market, arg1: u8, arg2: u64) : u64 {
        let v0 = arg2 - mul_div_u64(arg2, 150, 10000);
        let v1 = if (arg1 == 1) {
            arg0.yes_total + v0
        } else {
            arg0.no_total + v0
        };
        if (v1 == 0) {
            return 0
        };
        mul_div_u64(arg0.yes_total + arg0.no_total + v0, v0, v1)
    }

    public entry fun claim(arg0: &mut Market, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
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
            arg0.snap_yes
        } else {
            arg0.snap_no
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

    public entry fun create_market(arg0: &FeeVault, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 400);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 401);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 401);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v0 + 3600000, 402);
        let v1 = arg0.recipient;
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = Market{
            id           : 0x2::object::new(arg6),
            title        : arg1,
            option_yes   : arg2,
            option_no    : arg3,
            created_at   : v0,
            expires_at   : arg4,
            admin        : v1,
            creator      : v2,
            fee_vault_id : 0x2::object::uid_to_inner(&arg0.id),
            yes_total    : 0,
            no_total     : 0,
            vault        : 0x2::balance::zero<0x2::sui::SUI>(),
            resolved     : false,
            outcome      : 0,
            resolved_at  : 0,
            snap_yes     : 0,
            snap_no      : 0,
            snap_total   : 0,
        };
        let v4 = MarketCreated{
            market_id  : 0x2::object::uid_to_inner(&v3.id),
            admin      : v1,
            creator    : v2,
            title      : v3.title,
            expires_at : arg4,
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::transfer::share_object<Market>(v3);
    }

    public entry fun emergency_refund(arg0: &AdminCap, arg1: &mut Market, arg2: Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved, 202);
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
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = EmergencyRefund{
            market_id        : 0x2::object::uid_to_inner(&arg1.id),
            position_id      : 0x2::object::uid_to_inner(&v5),
            refund_recipient : v6,
            amount           : v3,
        };
        0x2::event::emit<EmergencyRefund>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v3), arg4), v6);
        0x2::object::delete(v5);
    }

    public fun get_market_info(arg0: &Market) : (vector<u8>, vector<u8>, vector<u8>, u64, u64, address, address, u64, u64, bool, u8) {
        (arg0.title, arg0.option_yes, arg0.option_no, arg0.created_at, arg0.expires_at, arg0.admin, arg0.creator, arg0.yes_total, arg0.no_total, arg0.resolved, arg0.outcome)
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
        };
        0x2::transfer::transfer<FeeVault>(v1, 0x2::tx_context::sender(arg0));
    }

    fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 303);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun resolve(arg0: &AdminCap, arg1: &mut Market, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.resolved, 202);
        assert!(arg2 == 1 || arg2 == 2, 201);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.expires_at, 203);
        arg1.resolved = true;
        arg1.outcome = arg2;
        arg1.resolved_at = v0;
        arg1.snap_yes = arg1.yes_total;
        arg1.snap_no = arg1.no_total;
        arg1.snap_total = arg1.yes_total + arg1.no_total;
        let v1 = MarketResolved{
            market_id   : 0x2::object::uid_to_inner(&arg1.id),
            outcome     : arg2,
            total_pool  : arg1.snap_total,
            yes_total   : arg1.snap_yes,
            no_total    : arg1.snap_no,
            resolved_at : v0,
        };
        0x2::event::emit<MarketResolved>(v1);
    }

    public entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeVault, arg2: address) {
        arg1.recipient = arg2;
    }

    public entry fun share_fee_vault(arg0: &AdminCap, arg1: FeeVault) {
        0x2::transfer::share_object<FeeVault>(arg1);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut FeeVault, arg2: &mut 0x2::tx_context::TxContext) {
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

