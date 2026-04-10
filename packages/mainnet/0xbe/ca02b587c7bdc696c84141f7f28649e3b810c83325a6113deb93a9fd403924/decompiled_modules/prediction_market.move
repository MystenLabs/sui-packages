module 0xbeca02b587c7bdc696c84141f7f28649e3b810c83325a6113deb93a9fd403924::prediction_market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin: address,
        default_fee_bps: u64,
        default_max_bet: u64,
        paused: bool,
        total_markets_created: u64,
        authorized_signers: vector<address>,
        required_approvals: u64,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        title: vector<u8>,
        description: vector<u8>,
        category: vector<u8>,
        creator: address,
        created_at: u64,
        end_time: u64,
        status: u8,
        yes_reserve: u64,
        no_reserve: u64,
        initial_liquidity: u64,
        treasury: 0x2::balance::Balance<T0>,
        collected_fees: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        total_yes_shares: u64,
        total_no_shares: u64,
        total_volume: u64,
        participant_count: u64,
        resolved_outcome: u8,
        resolution_time: u64,
        max_bet: u64,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        yes_shares: u64,
        no_shares: u64,
        total_invested: u64,
        claimed: bool,
    }

    struct ResolutionProposal has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        proposed_outcome: u8,
        proposer: address,
        approvals: 0x2::vec_set::VecSet<address>,
        required_approvals: u64,
        created_at: u64,
        executed: bool,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        title: vector<u8>,
        category: vector<u8>,
        end_time: u64,
        initial_liquidity: u64,
        fee_bps: u64,
    }

    struct SharesPurchased has copy, drop {
        market_id: 0x2::object::ID,
        buyer: address,
        side: u8,
        amount_paid: u64,
        shares_received: u64,
        fee_paid: u64,
        yes_price_after: u64,
        no_price_after: u64,
    }

    struct SharesSold has copy, drop {
        market_id: 0x2::object::ID,
        seller: address,
        side: u8,
        shares_sold: u64,
        amount_received: u64,
        fee_paid: u64,
        yes_price_after: u64,
        no_price_after: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        resolution_time: u64,
        treasury_value: u64,
        total_winning_shares: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        winning_shares: u64,
        payout: u64,
    }

    struct MarketCancelled has copy, drop {
        market_id: 0x2::object::ID,
        refund_pool: u64,
    }

    struct RefundClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        refund: u64,
    }

    struct ResolutionProposed has copy, drop {
        proposal_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        proposed_outcome: u8,
        proposer: address,
    }

    struct ResolutionApproved has copy, drop {
        proposal_id: 0x2::object::ID,
        approver: address,
        total_approvals: u64,
    }

    struct LiquidityAdded has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
        provider: address,
    }

    public entry fun add_liquidity<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = v0 / 2;
        arg1.yes_reserve = arg1.yes_reserve + v1;
        arg1.no_reserve = arg1.no_reserve + v0 - v1;
        0x2::balance::join<T0>(&mut arg1.treasury, 0x2::coin::into_balance<T0>(arg2));
        let v2 = LiquidityAdded{
            market_id : 0x2::object::id<Market<T0>>(arg1),
            amount    : v0,
            provider  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LiquidityAdded>(v2);
    }

    public entry fun add_signer(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        let v0 = &arg1.authorized_signers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                return
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(&mut arg1.authorized_signers, arg2);
    }

    public entry fun approve_resolution(arg0: &PlatformConfig, arg1: &mut ResolutionProposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized_signer(arg0, v0), 14);
        assert!(!arg1.executed, 17);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.created_at + 172800000, 18);
        assert!(!0x2::vec_set::contains<address>(&arg1.approvals, &v0), 15);
        0x2::vec_set::insert<address>(&mut arg1.approvals, v0);
        let v1 = ResolutionApproved{
            proposal_id     : 0x2::object::id<ResolutionProposal>(arg1),
            approver        : v0,
            total_approvals : 0x2::vec_set::size<address>(&arg1.approvals),
        };
        0x2::event::emit<ResolutionApproved>(v1);
    }

    public entry fun burn_position<T0>(arg0: Position<T0>) {
        assert!(arg0.yes_shares == 0 && arg0.no_shares == 0, 24);
        let Position {
            id             : v0,
            market_id      : _,
            yes_shares     : _,
            no_shares      : _,
            total_invested : _,
            claimed        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun buy_shares<T0>(arg0: &mut Market<T0>, arg1: &PlatformConfig, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 22);
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.end_time, 2);
        assert!(arg3 == 0 || arg3 == 1, 8);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        assert!(v0 <= arg0.max_bet, 10);
        let v1 = v0 * arg0.fee_bps / 10000;
        let v2 = v0 - v1;
        let v3 = if (arg3 == 0) {
            cpmm_buy(arg0.yes_reserve, arg0.no_reserve, v2)
        } else {
            cpmm_buy(arg0.no_reserve, arg0.yes_reserve, v2)
        };
        assert!(v3 >= arg4, 11);
        assert!(v3 > 0, 13);
        if (arg3 == 0) {
            arg0.no_reserve = arg0.no_reserve + v2;
            assert!(arg0.yes_reserve >= v3, 21);
            arg0.yes_reserve = arg0.yes_reserve - v3;
            arg0.total_yes_shares = arg0.total_yes_shares + v3;
        } else {
            arg0.yes_reserve = arg0.yes_reserve + v2;
            assert!(arg0.no_reserve >= v3, 21);
            arg0.no_reserve = arg0.no_reserve - v3;
            arg0.total_no_shares = arg0.total_no_shares + v3;
        };
        arg0.total_volume = arg0.total_volume + v0;
        arg0.participant_count = arg0.participant_count + 1;
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.collected_fees, 0x2::balance::split<T0>(&mut v4, v1));
        };
        0x2::balance::join<T0>(&mut arg0.treasury, v4);
        let (v5, v6) = get_prices_internal(arg0.yes_reserve, arg0.no_reserve);
        let v7 = SharesPurchased{
            market_id       : 0x2::object::id<Market<T0>>(arg0),
            buyer           : 0x2::tx_context::sender(arg6),
            side            : arg3,
            amount_paid     : v0,
            shares_received : v3,
            fee_paid        : v1,
            yes_price_after : v5,
            no_price_after  : v6,
        };
        0x2::event::emit<SharesPurchased>(v7);
        let v8 = if (arg3 == 0) {
            v3
        } else {
            0
        };
        let v9 = if (arg3 == 1) {
            v3
        } else {
            0
        };
        let v10 = Position<T0>{
            id             : 0x2::object::new(arg6),
            market_id      : 0x2::object::id<Market<T0>>(arg0),
            yes_shares     : v8,
            no_shares      : v9,
            total_invested : v0,
            claimed        : false,
        };
        0x2::transfer::transfer<Position<T0>>(v10, 0x2::tx_context::sender(arg6));
    }

    public entry fun cancel_market<T0>(arg0: &AdminCap, arg1: &mut Market<T0>) {
        assert!(arg1.status == 0 || arg1.status == 1, 1);
        arg1.status = 4;
        let v0 = MarketCancelled{
            market_id   : 0x2::object::id<Market<T0>>(arg1),
            refund_pool : 0x2::balance::value<T0>(&arg1.treasury),
        };
        0x2::event::emit<MarketCancelled>(v0);
    }

    public entry fun claim_refund<T0>(arg0: &mut Market<T0>, arg1: &mut Position<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 19);
        assert!(arg1.market_id == 0x2::object::id<Market<T0>>(arg0), 12);
        assert!(!arg1.claimed, 7);
        let v0 = arg1.yes_shares + arg1.no_shares;
        assert!(v0 > 0, 5);
        let v1 = arg0.total_yes_shares + arg0.total_no_shares;
        let v2 = 0x2::balance::value<T0>(&arg0.treasury);
        assert!(v1 > 0, 5);
        let v3 = (((v2 as u128) * (v0 as u128) / (v1 as u128)) as u64);
        let v4 = v3;
        if (v3 > v2) {
            v4 = v2;
        };
        assert!(v4 > 0, 4);
        arg1.claimed = true;
        arg0.total_yes_shares = arg0.total_yes_shares - arg1.yes_shares;
        arg0.total_no_shares = arg0.total_no_shares - arg1.no_shares;
        let v5 = RefundClaimed{
            market_id : 0x2::object::id<Market<T0>>(arg0),
            claimer   : 0x2::tx_context::sender(arg2),
            refund    : v4,
        };
        0x2::event::emit<RefundClaimed>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v4), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_winnings<T0>(arg0: &mut Market<T0>, arg1: &mut Position<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2 || arg0.status == 3, 6);
        assert!(arg1.market_id == 0x2::object::id<Market<T0>>(arg0), 12);
        assert!(!arg1.claimed, 7);
        let v0 = if (arg0.resolved_outcome == 2) {
            arg1.yes_shares
        } else {
            arg1.no_shares
        };
        assert!(v0 > 0, 5);
        let v1 = if (arg0.resolved_outcome == 2) {
            arg0.total_yes_shares
        } else {
            arg0.total_no_shares
        };
        let v2 = 0x2::balance::value<T0>(&arg0.treasury);
        assert!(v1 > 0, 5);
        let v3 = (((v2 as u128) * (v0 as u128) / (v1 as u128)) as u64);
        assert!(v3 > 0, 5);
        assert!(v3 <= v2, 21);
        arg1.claimed = true;
        if (arg0.resolved_outcome == 2) {
            arg0.total_yes_shares = arg0.total_yes_shares - v0;
        } else {
            arg0.total_no_shares = arg0.total_no_shares - v0;
        };
        let v4 = WinningsClaimed{
            market_id      : 0x2::object::id<Market<T0>>(arg0),
            claimer        : 0x2::tx_context::sender(arg2),
            winning_shares : v0,
            payout         : v3,
        };
        0x2::event::emit<WinningsClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v3), arg2), 0x2::tx_context::sender(arg2));
    }

    fun cpmm_buy(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) - (arg0 as u128) * (arg1 as u128) / ((arg1 as u128) + (arg2 as u128))) as u64)
    }

    fun cpmm_sell(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) - (arg0 as u128) * (arg1 as u128) / ((arg0 as u128) + (arg2 as u128))) as u64)
    }

    public entry fun create_market<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 22);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 > v0, 2);
        assert!(arg7 <= 500, 8);
        assert!(arg6 >= 100, 4);
        let v1 = Market<T0>{
            id                : 0x2::object::new(arg10),
            title             : arg2,
            description       : arg3,
            category          : arg4,
            creator           : 0x2::tx_context::sender(arg10),
            created_at        : v0,
            end_time          : arg5,
            status            : 0,
            yes_reserve       : arg6,
            no_reserve        : arg6,
            initial_liquidity : arg6,
            treasury          : 0x2::balance::zero<T0>(),
            collected_fees    : 0x2::balance::zero<T0>(),
            fee_bps           : arg7,
            total_yes_shares  : 0,
            total_no_shares   : 0,
            total_volume      : 0,
            participant_count : 0,
            resolved_outcome  : 0,
            resolution_time   : 0,
            max_bet           : arg8,
        };
        arg1.total_markets_created = arg1.total_markets_created + 1;
        let v2 = MarketCreated{
            market_id         : 0x2::object::id<Market<T0>>(&v1),
            title             : v1.title,
            category          : v1.category,
            end_time          : arg5,
            initial_liquidity : arg6,
            fee_bps           : arg7,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market<T0>>(v1);
    }

    public entry fun create_market_funded<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 22);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg5 > v0, 2);
        assert!(arg7 <= 500, 8);
        assert!(arg6 >= 100, 4);
        let v1 = Market<T0>{
            id                : 0x2::object::new(arg11),
            title             : arg2,
            description       : arg3,
            category          : arg4,
            creator           : 0x2::tx_context::sender(arg11),
            created_at        : v0,
            end_time          : arg5,
            status            : 0,
            yes_reserve       : arg6,
            no_reserve        : arg6,
            initial_liquidity : arg6,
            treasury          : 0x2::coin::into_balance<T0>(arg9),
            collected_fees    : 0x2::balance::zero<T0>(),
            fee_bps           : arg7,
            total_yes_shares  : 0,
            total_no_shares   : 0,
            total_volume      : 0,
            participant_count : 0,
            resolved_outcome  : 0,
            resolution_time   : 0,
            max_bet           : arg8,
        };
        arg1.total_markets_created = arg1.total_markets_created + 1;
        let v2 = MarketCreated{
            market_id         : 0x2::object::id<Market<T0>>(&v1),
            title             : v1.title,
            category          : v1.category,
            end_time          : arg5,
            initial_liquidity : arg6,
            fee_bps           : arg7,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market<T0>>(v1);
    }

    public fun estimate_buy_shares<T0>(arg0: &Market<T0>, arg1: u8, arg2: u64) : u64 {
        if (arg1 == 0) {
            cpmm_buy(arg0.yes_reserve, arg0.no_reserve, arg2 - arg2 * arg0.fee_bps / 10000)
        } else {
            cpmm_buy(arg0.no_reserve, arg0.yes_reserve, arg2 - arg2 * arg0.fee_bps / 10000)
        }
    }

    public fun estimate_sell_payout<T0>(arg0: &Market<T0>, arg1: u8, arg2: u64) : u64 {
        let v0 = if (arg1 == 0) {
            cpmm_sell(arg0.yes_reserve, arg0.no_reserve, arg2)
        } else {
            cpmm_sell(arg0.no_reserve, arg0.yes_reserve, arg2)
        };
        v0 - v0 * arg0.fee_bps / 10000
    }

    public entry fun execute_resolution<T0>(arg0: &mut ResolutionProposal, arg1: &mut Market<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.executed, 17);
        assert!(0x2::vec_set::size<address>(&arg0.approvals) >= arg0.required_approvals, 16);
        assert!(arg0.market_id == 0x2::object::id<Market<T0>>(arg1), 12);
        assert!(arg1.status == 0 || arg1.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.created_at + 172800000, 18);
        arg1.status = arg0.proposed_outcome;
        arg1.resolved_outcome = arg0.proposed_outcome;
        arg1.resolution_time = v0;
        arg0.executed = true;
        let v1 = if (arg0.proposed_outcome == 2) {
            arg1.total_yes_shares
        } else {
            arg1.total_no_shares
        };
        let v2 = MarketResolved{
            market_id            : 0x2::object::id<Market<T0>>(arg1),
            outcome              : arg0.proposed_outcome,
            resolution_time      : v0,
            treasury_value       : 0x2::balance::value<T0>(&arg1.treasury),
            total_winning_shares : v1,
        };
        0x2::event::emit<MarketResolved>(v2);
    }

    public fun get_fees_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collected_fees)
    }

    public fun get_market_end_time<T0>(arg0: &Market<T0>) : u64 {
        arg0.end_time
    }

    public fun get_market_fee<T0>(arg0: &Market<T0>) : u64 {
        arg0.fee_bps
    }

    public fun get_no_price<T0>(arg0: &Market<T0>) : u64 {
        let (_, v1) = get_prices_internal(arg0.yes_reserve, arg0.no_reserve);
        v1
    }

    public fun get_position_info<T0>(arg0: &Position<T0>) : (0x2::object::ID, u64, u64, u64, bool) {
        (arg0.market_id, arg0.yes_shares, arg0.no_shares, arg0.total_invested, arg0.claimed)
    }

    fun get_prices_internal(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 == 0) {
            return (5000, 5000)
        };
        let v1 = (((arg1 as u128) * (10000 as u128) / v0) as u64);
        (v1, 10000 - v1)
    }

    public fun get_reserves<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.yes_reserve, arg0.no_reserve)
    }

    public fun get_shares_outstanding<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.total_yes_shares, arg0.total_no_shares)
    }

    public fun get_status<T0>(arg0: &Market<T0>) : u8 {
        arg0.status
    }

    public fun get_treasury_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun get_volume<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_volume
    }

    public fun get_yes_price<T0>(arg0: &Market<T0>) : u64 {
        let (v0, _) = get_prices_internal(arg0.yes_reserve, arg0.no_reserve);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = PlatformConfig{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            default_fee_bps       : 200,
            default_max_bet       : 10000000000000,
            paused                : false,
            total_markets_created : 0,
            authorized_signers    : v1,
            required_approvals    : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PlatformConfig>(v2);
    }

    fun is_authorized_signer(arg0: &PlatformConfig, arg1: address) : bool {
        let v0 = &arg0.authorized_signers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public entry fun merge_positions<T0>(arg0: &mut Position<T0>, arg1: Position<T0>) {
        assert!(arg0.market_id == arg1.market_id, 12);
        assert!(!arg0.claimed && !arg1.claimed, 7);
        arg0.yes_shares = arg0.yes_shares + arg1.yes_shares;
        arg0.no_shares = arg0.no_shares + arg1.no_shares;
        arg0.total_invested = arg0.total_invested + arg1.total_invested;
        let Position {
            id             : v0,
            market_id      : _,
            yes_shares     : _,
            no_shares      : _,
            total_invested : _,
            claimed        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun propose_resolution(arg0: &PlatformConfig, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 2 || arg2 == 3, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_authorized_signer(arg0, v0), 14);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = ResolutionProposal{
            id                 : 0x2::object::new(arg4),
            market_id          : arg1,
            proposed_outcome   : arg2,
            proposer           : v0,
            approvals          : v1,
            required_approvals : arg0.required_approvals,
            created_at         : 0x2::clock::timestamp_ms(arg3),
            executed           : false,
        };
        let v3 = ResolutionProposed{
            proposal_id      : 0x2::object::id<ResolutionProposal>(&v2),
            market_id        : arg1,
            proposed_outcome : arg2,
            proposer         : v0,
        };
        0x2::event::emit<ResolutionProposed>(v3);
        0x2::transfer::share_object<ResolutionProposal>(v2);
    }

    public entry fun remove_signer(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        let v0 = &mut arg1.authorized_signers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                0x1::vector::swap_remove<address>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public entry fun resolve_market_direct<T0>(arg0: &AdminCap, arg1: &PlatformConfig, arg2: &mut Market<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg1.required_approvals <= 1, 16);
        assert!(arg3 == 2 || arg3 == 3, 8);
        assert!(arg2.status == 0 || arg2.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.status = arg3;
        arg2.resolved_outcome = arg3;
        arg2.resolution_time = v0;
        let v1 = if (arg3 == 2) {
            arg2.total_yes_shares
        } else {
            arg2.total_no_shares
        };
        let v2 = MarketResolved{
            market_id            : 0x2::object::id<Market<T0>>(arg2),
            outcome              : arg3,
            resolution_time      : v0,
            treasury_value       : 0x2::balance::value<T0>(&arg2.treasury),
            total_winning_shares : v1,
        };
        0x2::event::emit<MarketResolved>(v2);
    }

    public entry fun sell_shares<T0>(arg0: &mut Market<T0>, arg1: &PlatformConfig, arg2: &mut Position<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 22);
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.end_time, 2);
        assert!(arg2.market_id == 0x2::object::id<Market<T0>>(arg0), 12);
        assert!(arg3 == 0 || arg3 == 1, 8);
        let v0 = if (arg3 == 0) {
            arg2.yes_shares
        } else {
            arg2.no_shares
        };
        assert!(arg4 > 0 && arg4 <= v0, 5);
        let v1 = if (arg3 == 0) {
            cpmm_sell(arg0.yes_reserve, arg0.no_reserve, arg4)
        } else {
            cpmm_sell(arg0.no_reserve, arg0.yes_reserve, arg4)
        };
        let v2 = v1 * arg0.fee_bps / 10000;
        let v3 = v1 - v2;
        assert!(v3 >= arg5, 11);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.treasury), 23);
        if (arg3 == 0) {
            arg0.yes_reserve = arg0.yes_reserve + arg4;
            arg0.no_reserve = arg0.no_reserve - v1;
            arg2.yes_shares = arg2.yes_shares - arg4;
            arg0.total_yes_shares = arg0.total_yes_shares - arg4;
        } else {
            arg0.no_reserve = arg0.no_reserve + arg4;
            arg0.yes_reserve = arg0.yes_reserve - v1;
            arg2.no_shares = arg2.no_shares - arg4;
            arg0.total_no_shares = arg0.total_no_shares - arg4;
        };
        if (v0 > 0) {
            let v4 = (((arg2.total_invested as u128) * (arg4 as u128) / (v0 as u128)) as u64);
            if (v4 <= arg2.total_invested) {
                arg2.total_invested = arg2.total_invested - v4;
            };
        };
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut arg0.collected_fees, 0x2::balance::split<T0>(&mut arg0.treasury, v2));
        };
        let (v5, v6) = get_prices_internal(arg0.yes_reserve, arg0.no_reserve);
        let v7 = SharesSold{
            market_id       : 0x2::object::id<Market<T0>>(arg0),
            seller          : 0x2::tx_context::sender(arg7),
            side            : arg3,
            shares_sold     : arg4,
            amount_received : v3,
            fee_paid        : v2,
            yes_price_after : v5,
            no_price_after  : v6,
        };
        0x2::event::emit<SharesSold>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v3), arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun set_default_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 <= 500, 8);
        arg1.default_fee_bps = arg2;
    }

    public entry fun set_default_max_bet(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.default_max_bet = arg2;
    }

    public entry fun set_market_fee<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: u64) {
        assert!(arg2 <= 500, 8);
        arg1.fee_bps = arg2;
    }

    public entry fun set_market_max_bet<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: u64) {
        arg1.max_bet = arg2;
    }

    public entry fun set_market_pause<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: bool) {
        if (arg2) {
            assert!(arg1.status == 0, 1);
            arg1.status = 1;
        } else {
            assert!(arg1.status == 1, 1);
            arg1.status = 0;
        };
    }

    public entry fun set_platform_pause(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_required_approvals(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 > 0, 8);
        assert!(arg2 <= 0x1::vector::length<address>(&arg1.authorized_signers), 8);
        arg1.required_approvals = arg2;
    }

    public entry fun sweep_remaining<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2 || arg1.status == 3, 6);
        let v0 = if (arg1.resolved_outcome == 2) {
            arg1.total_yes_shares
        } else {
            arg1.total_no_shares
        };
        assert!(v0 == 0, 24);
        let v1 = 0x2::balance::value<T0>(&arg1.treasury);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury, v1), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.collected_fees);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collected_fees, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

