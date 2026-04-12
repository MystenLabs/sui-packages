module 0xc6ea3100c63cd2e27f9a75b9a6ea2db33f58be4b39a07bb11bf5f424b212aa76::betting_tb2 {
    struct BETTING_TB2 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct BettingPlatformTb2 has key {
        id: 0x2::object::UID,
        platform_fee_bps: u64,
        total_bets: u64,
        paused: bool,
        oracle_public_key: vector<u8>,
        bet_expiry_ms: u64,
        last_withdrawal_at: u64,
    }

    struct TokenStateKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenState<phantom T0> has store {
        treasury: 0x2::balance::Balance<T0>,
        total_volume: u64,
        total_potential_liability: u64,
        accrued_fees: u64,
        min_bet: u64,
        max_bet: u64,
        absolute_max_bet: u64,
        max_single_withdrawal: u64,
        enabled: bool,
    }

    struct BetTb2 has store, key {
        id: 0x2::object::UID,
        bettor: address,
        event_id: vector<u8>,
        market_id: vector<u8>,
        prediction: vector<u8>,
        odds: u64,
        stake: u64,
        potential_payout: u64,
        platform_fee: u64,
        status: u8,
        placed_at: u64,
        settled_at: u64,
        walrus_blob_id: vector<u8>,
        coin_type_name: vector<u8>,
        deadline: u64,
    }

    struct WithdrawalLockKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MultisigGuard has key {
        id: 0x2::object::UID,
        signers: vector<address>,
        threshold: u64,
        platform_id: 0x2::object::ID,
    }

    struct WithdrawalProposalTb2 has key {
        id: 0x2::object::UID,
        proposer: address,
        amount: u64,
        coin_type_name: vector<u8>,
        withdrawal_type: u8,
        recipient: address,
        approvals: vector<address>,
        executed: bool,
        created_at: u64,
        expires_at: u64,
        guard_id: 0x2::object::ID,
        platform_id: 0x2::object::ID,
    }

    struct PlatformCreated has copy, drop {
        platform_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct PlatformPaused has copy, drop {
        platform_id: 0x2::object::ID,
        paused: bool,
        timestamp: u64,
    }

    struct TokenRegistered has copy, drop {
        platform_id: 0x2::object::ID,
        coin_type_name: vector<u8>,
        min_bet: u64,
        max_bet: u64,
        absolute_max_bet: u64,
        timestamp: u64,
    }

    struct TokenStatusChanged has copy, drop {
        platform_id: 0x2::object::ID,
        coin_type_name: vector<u8>,
        enabled: bool,
        timestamp: u64,
    }

    struct BetPlaced has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        event_id: vector<u8>,
        prediction: vector<u8>,
        odds: u64,
        stake: u64,
        potential_payout: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct BetSettled has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        status: u8,
        payout: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct OracleCapMinted has copy, drop {
        oracle_cap_id: 0x2::object::ID,
        recipient: address,
        timestamp: u64,
    }

    struct OracleCapRevoked has copy, drop {
        oracle_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct LiquidityDeposited has copy, drop {
        platform_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct OracleKeyUpdated has copy, drop {
        platform_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ExpiredBetRefunded has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        refund_amount: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct PhantomBetVoided has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        stake: u64,
        liability_freed: u64,
        coin_type_name: vector<u8>,
        timestamp: u64,
    }

    struct DirectWithdrawalsLocked has copy, drop {
        platform_id: 0x2::object::ID,
        locked: bool,
        timestamp: u64,
    }

    struct MultisigGuardCreated has copy, drop {
        guard_id: 0x2::object::ID,
        platform_id: 0x2::object::ID,
        threshold: u64,
        num_signers: u64,
        timestamp: u64,
    }

    struct WithdrawalProposed has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        amount: u64,
        coin_type_name: vector<u8>,
        withdrawal_type: u8,
        recipient: address,
        timestamp: u64,
    }

    struct WithdrawalApprovedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        approver: address,
        approval_count: u64,
        threshold: u64,
        timestamp: u64,
    }

    struct MultisigWithdrawalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        amount: u64,
        coin_type_name: vector<u8>,
        withdrawal_type: u8,
        recipient: address,
        approval_count: u64,
        timestamp: u64,
    }

    public entry fun admin_reset_liability<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1).total_potential_liability = arg2;
    }

    public entry fun admin_reset_liability_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        admin_reset_liability<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2);
    }

    public entry fun approve_withdrawal(arg0: &MultisigGuard, arg1: &mut WithdrawalProposalTb2, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_signer(arg0, v0), 21);
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 <= arg1.expires_at, 24);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1.approvals)) {
            assert!(*0x1::vector::borrow<address>(&arg1.approvals, v2) != v0, 22);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<address>(&mut arg1.approvals, v0);
        let v3 = WithdrawalApprovedEvent{
            proposal_id    : 0x2::object::id<WithdrawalProposalTb2>(arg1),
            approver       : v0,
            approval_count : 0x1::vector::length<address>(&arg1.approvals),
            threshold      : arg0.threshold,
            timestamp      : v1,
        };
        0x2::event::emit<WithdrawalApprovedEvent>(v3);
    }

    fun build_oracle_message(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: address, arg4: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        v0
    }

    public entry fun claim_expired_refund<T0>(arg0: &mut BettingPlatformTb2, arg1: &mut BetTb2, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 1);
        assert!(arg1.coin_type_name == get_coin_type_name<T0>(), 29);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.deadline, 14);
        assert!(0x2::tx_context::sender(arg3) == arg1.bettor, 2);
        arg1.status = 3;
        arg1.settled_at = v0;
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg0.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg1.potential_payout;
        let v3 = arg1.stake;
        assert!(0x2::balance::value<T0>(&v2.treasury) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.treasury, v3), arg3), arg1.bettor);
        let v4 = ExpiredBetRefunded{
            bet_id         : 0x2::object::id<BetTb2>(arg1),
            bettor         : arg1.bettor,
            refund_amount  : v3,
            coin_type_name : arg1.coin_type_name,
            timestamp      : v0,
        };
        0x2::event::emit<ExpiredBetRefunded>(v4);
    }

    public entry fun claim_expired_refund_td2(arg0: &mut BettingPlatformTb2, arg1: &mut BetTb2, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg0.id, v0), 32);
        claim_expired_refund<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3);
    }

    fun count_valid_approvals(arg0: &MultisigGuard, arg1: &vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            if (is_signer(arg0, *0x1::vector::borrow<address>(arg1, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_multisig_guard(arg0: &AdminCap, arg1: &BettingPlatformTb2, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg3 > 0 && arg3 <= v0, 26);
        assert!(v0 >= 2, 26);
        validate_unique_signers(&arg2);
        let v1 = MultisigGuard{
            id          : 0x2::object::new(arg5),
            signers     : arg2,
            threshold   : arg3,
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
        };
        let v2 = MultisigGuardCreated{
            guard_id    : 0x2::object::id<MultisigGuard>(&v1),
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            threshold   : arg3,
            num_signers : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MultisigGuardCreated>(v2);
        0x2::transfer::share_object<MultisigGuard>(v1);
    }

    public entry fun deposit_liquidity<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1).treasury, 0x2::coin::into_balance<T0>(arg2));
        let v2 = LiquidityDeposited{
            platform_id    : 0x2::object::id<BettingPlatformTb2>(arg1),
            depositor      : 0x2::tx_context::sender(arg4),
            amount         : 0x2::coin::value<T0>(&arg2),
            coin_type_name : get_coin_type_name<T0>(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v2);
    }

    public entry fun deposit_liquidity_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        deposit_liquidity<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun disable_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        disable_token<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2);
    }

    public entry fun disable_token<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1).enabled = false;
        let v2 = TokenStatusChanged{
            platform_id    : 0x2::object::id<BettingPlatformTb2>(arg1),
            coin_type_name : get_coin_type_name<T0>(),
            enabled        : false,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenStatusChanged>(v2);
    }

    public entry fun enable_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        enable_token<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2);
    }

    public entry fun enable_token<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1).enabled = true;
        let v2 = TokenStatusChanged{
            platform_id    : 0x2::object::id<BettingPlatformTb2>(arg1),
            coin_type_name : get_coin_type_name<T0>(),
            enabled        : true,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenStatusChanged>(v2);
    }

    public entry fun execute_withdrawal_fees<T0>(arg0: &MultisigGuard, arg1: &mut WithdrawalProposalTb2, arg2: &AdminCap, arg3: &mut BettingPlatformTb2, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatformTb2>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatformTb2>(arg3), 2);
        assert!(arg1.withdrawal_type == 0, 6);
        assert!(arg1.coin_type_name == get_coin_type_name<T0>(), 29);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg3.id, v1);
        let v3 = arg1.amount;
        assert!(v3 <= v2.accrued_fees, 0);
        assert!(0x2::balance::value<T0>(&v2.treasury) >= v3, 11);
        assert!(v3 <= v2.max_single_withdrawal, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        v2.accrued_fees = v2.accrued_fees - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.treasury, v3), arg5), arg1.recipient);
        let v4 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposalTb2>(arg1),
            amount          : v3,
            coin_type_name  : arg1.coin_type_name,
            withdrawal_type : 0,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v4);
    }

    public entry fun execute_withdrawal_fees_td2(arg0: &MultisigGuard, arg1: &mut WithdrawalProposalTb2, arg2: &AdminCap, arg3: &mut BettingPlatformTb2, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg3.id, v0), 32);
        execute_withdrawal_fees<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun execute_withdrawal_treasury<T0>(arg0: &MultisigGuard, arg1: &mut WithdrawalProposalTb2, arg2: &AdminCap, arg3: &mut BettingPlatformTb2, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatformTb2>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatformTb2>(arg3), 2);
        assert!(arg1.withdrawal_type == 1, 6);
        assert!(arg1.coin_type_name == get_coin_type_name<T0>(), 29);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg3.id, v1);
        let v3 = arg1.amount;
        assert!(0x2::balance::value<T0>(&v2.treasury) >= v3, 11);
        assert!(0x2::balance::value<T0>(&v2.treasury) - v3 >= v2.total_potential_liability, 0);
        assert!(v3 <= v2.max_single_withdrawal, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.treasury, v3), arg5), arg1.recipient);
        let v4 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposalTb2>(arg1),
            amount          : v3,
            coin_type_name  : arg1.coin_type_name,
            withdrawal_type : 1,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v4);
    }

    public entry fun execute_withdrawal_treasury_td2(arg0: &MultisigGuard, arg1: &mut WithdrawalProposalTb2, arg2: &AdminCap, arg3: &mut BettingPlatformTb2, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg3.id, v0), 32);
        execute_withdrawal_treasury<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_bet_deadline(arg0: &BetTb2) : u64 {
        arg0.deadline
    }

    public fun get_bet_event_id(arg0: &BetTb2) : vector<u8> {
        arg0.event_id
    }

    public fun get_bet_info(arg0: &BetTb2) : (address, u64, u64, u64, u8, vector<u8>) {
        (arg0.bettor, arg0.stake, arg0.odds, arg0.potential_payout, arg0.status, arg0.coin_type_name)
    }

    public fun get_bet_market_id(arg0: &BetTb2) : vector<u8> {
        arg0.market_id
    }

    public fun get_bet_prediction(arg0: &BetTb2) : vector<u8> {
        arg0.prediction
    }

    fun get_coin_type_name<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun get_multisig_info(arg0: &MultisigGuard) : (vector<address>, u64, 0x2::object::ID) {
        (arg0.signers, arg0.threshold, arg0.platform_id)
    }

    public fun get_platform_info(arg0: &BettingPlatformTb2) : (u64, u64, bool, u64) {
        (arg0.platform_fee_bps, arg0.total_bets, arg0.paused, arg0.bet_expiry_ms)
    }

    public fun get_proposal_info(arg0: &WithdrawalProposalTb2) : (address, u64, vector<u8>, u8, address, u64, bool, u64, u64) {
        (arg0.proposer, arg0.amount, arg0.coin_type_name, arg0.withdrawal_type, arg0.recipient, 0x1::vector::length<address>(&arg0.approvals), arg0.executed, arg0.created_at, arg0.expires_at)
    }

    public fun get_td2_stats(arg0: &BettingPlatformTb2) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg0.id, v0), 32);
        get_token_stats<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0)
    }

    public fun get_token_stats<T0>(arg0: &BettingPlatformTb2) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg0.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TokenStateKey<T0>, TokenState<T0>>(&arg0.id, v1);
        (0x2::balance::value<T0>(&v2.treasury), v2.total_volume, v2.total_potential_liability, v2.accrued_fees, v2.min_bet, v2.max_bet, v2.absolute_max_bet, v2.max_single_withdrawal, v2.enabled)
    }

    fun init(arg0: BETTING_TB2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<BETTING_TB2>(&arg0), 10);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = BettingPlatformTb2{
            id                 : 0x2::object::new(arg1),
            platform_fee_bps   : 100,
            total_bets         : 0,
            paused             : true,
            oracle_public_key  : 0x1::vector::empty<u8>(),
            bet_expiry_ms      : 604800000,
            last_withdrawal_at : 0,
        };
        let v2 = PlatformCreated{
            platform_id  : 0x2::object::id<BettingPlatformTb2>(&v1),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            fee_bps      : 100,
        };
        0x2::event::emit<PlatformCreated>(v2);
        0x2::transfer::share_object<BettingPlatformTb2>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_td2_state(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 31);
        let v1 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        let v2 = TokenState<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{
            treasury                  : 0x2::balance::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(),
            total_volume              : 0,
            total_potential_liability : 0,
            accrued_fees              : 0,
            min_bet                   : 1000000,
            max_bet                   : 10000000000,
            absolute_max_bet          : 100000000000,
            max_single_withdrawal     : 50000000000,
            enabled                   : true,
        };
        0x2::dynamic_field::add<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, TokenState<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&mut arg1.id, v1, v2);
        let v3 = TokenRegistered{
            platform_id      : 0x2::object::id<BettingPlatformTb2>(arg1),
            coin_type_name   : get_coin_type_name<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(),
            min_bet          : 1000000,
            max_bet          : 10000000000,
            absolute_max_bet : 100000000000,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenRegistered>(v3);
    }

    fun is_signer(arg0: &MultisigGuard, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.signers)) {
            if (*0x1::vector::borrow<address>(&arg0.signers, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_withdrawal_locked(arg0: &BettingPlatformTb2) : bool {
        let v0 = WithdrawalLockKey{dummy_field: false};
        0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg0.id, v0)
    }

    public entry fun lock_direct_withdrawals(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0)) {
            let v1 = WithdrawalLockKey{dummy_field: false};
            0x2::dynamic_field::add<WithdrawalLockKey, bool>(&mut arg1.id, v1, true);
        };
        let v2 = DirectWithdrawalsLocked{
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            locked      : true,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DirectWithdrawalsLocked>(v2);
    }

    public entry fun mint_oracle_cap(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg3)};
        let v1 = OracleCapMinted{
            oracle_cap_id : 0x2::object::id<OracleCap>(&v0),
            recipient     : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OracleCapMinted>(v1);
        0x2::transfer::transfer<OracleCap>(v0, arg1);
    }

    public entry fun place_bet<T0>(arg0: &mut BettingPlatformTb2, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = &arg0.oracle_public_key;
        assert!(0x1::vector::length<u8>(v0) == 32, 16);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = build_oracle_message(&arg2, arg5, arg6, v1, &arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg7, v0, &v3), 12);
        assert!(v2 <= arg6, 13);
        assert!(arg5 >= 100, 3);
        assert!(arg5 <= 100000, 3);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 > 0, 6);
        let v5 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg0.id, v5), 27);
        let v6 = TokenStateKey<T0>{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg0.id, v6);
        assert!(v7.enabled, 30);
        assert!(v4 >= v7.min_bet, 9);
        assert!(v4 <= v7.max_bet, 8);
        assert!(v4 <= v7.absolute_max_bet, 15);
        let v8 = (v4 as u128) * (arg5 as u128) / 100;
        assert!(v8 <= 18446744073709551615, 6);
        let v9 = (v8 as u64);
        assert!(0x2::balance::value<T0>(&v7.treasury) + v4 >= v7.total_potential_liability + v9, 0);
        0x2::balance::join<T0>(&mut v7.treasury, 0x2::coin::into_balance<T0>(arg1));
        v7.total_volume = v7.total_volume + v4;
        v7.total_potential_liability = v7.total_potential_liability + v9;
        arg0.total_bets = arg0.total_bets + 1;
        let v10 = BetTb2{
            id               : 0x2::object::new(arg10),
            bettor           : v1,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v4,
            potential_payout : v9,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v2,
            settled_at       : 0,
            walrus_blob_id   : arg8,
            coin_type_name   : get_coin_type_name<T0>(),
            deadline         : v2 + arg0.bet_expiry_ms,
        };
        let v11 = BetPlaced{
            bet_id           : 0x2::object::id<BetTb2>(&v10),
            bettor           : v1,
            event_id         : v10.event_id,
            prediction       : v10.prediction,
            odds             : arg5,
            stake            : v4,
            potential_payout : v9,
            coin_type_name   : v10.coin_type_name,
            timestamp        : v2,
        };
        0x2::event::emit<BetPlaced>(v11);
        0x2::transfer::share_object<BetTb2>(v10);
    }

    public entry fun place_bet_td2(arg0: &mut BettingPlatformTb2, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg0.id, v0), 32);
        place_bet<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun propose_withdrawal(arg0: &MultisigGuard, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(is_signer(arg0, v0), 21);
        assert!(arg3 == 0 || arg3 == 1, 6);
        assert!(arg1 > 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = WithdrawalProposalTb2{
            id              : 0x2::object::new(arg6),
            proposer        : v0,
            amount          : arg1,
            coin_type_name  : arg2,
            withdrawal_type : arg3,
            recipient       : arg4,
            approvals       : v2,
            executed        : false,
            created_at      : v1,
            expires_at      : v1 + 86400000,
            guard_id        : 0x2::object::id<MultisigGuard>(arg0),
            platform_id     : arg0.platform_id,
        };
        let v4 = WithdrawalProposed{
            proposal_id     : 0x2::object::id<WithdrawalProposalTb2>(&v3),
            proposer        : v0,
            amount          : arg1,
            coin_type_name  : v3.coin_type_name,
            withdrawal_type : arg3,
            recipient       : arg4,
            timestamp       : v1,
        };
        0x2::event::emit<WithdrawalProposed>(v4);
        0x2::transfer::share_object<WithdrawalProposalTb2>(v3);
    }

    public entry fun register_token<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 28);
        assert!(arg3 <= arg4, 15);
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 6);
        assert!(arg5 > 0, 6);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = TokenState<T0>{
            treasury                  : 0x2::balance::zero<T0>(),
            total_volume              : 0,
            total_potential_liability : 0,
            accrued_fees              : 0,
            min_bet                   : arg2,
            max_bet                   : arg3,
            absolute_max_bet          : arg4,
            max_single_withdrawal     : arg5,
            enabled                   : true,
        };
        0x2::dynamic_field::add<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1, v2);
        let v3 = TokenRegistered{
            platform_id      : 0x2::object::id<BettingPlatformTb2>(arg1),
            coin_type_name   : get_coin_type_name<T0>(),
            min_bet          : arg2,
            max_bet          : arg3,
            absolute_max_bet : arg4,
            timestamp        : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TokenRegistered>(v3);
    }

    public entry fun revoke_oracle_cap(arg0: &AdminCap, arg1: OracleCap, arg2: &0x2::clock::Clock) {
        let OracleCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = OracleCapRevoked{
            oracle_cap_id : 0x2::object::id<OracleCap>(&arg1),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OracleCapRevoked>(v1);
    }

    public entry fun set_oracle_public_key(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 18);
        arg1.oracle_public_key = arg2;
        let v0 = OracleKeyUpdated{
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OracleKeyUpdated>(v0);
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = PlatformPaused{
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            paused      : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun settle_bet<T0>(arg0: &OracleCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type_name == get_coin_type_name<T0>(), 29);
        let v0 = TokenStateKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v2;
        v1.total_potential_liability = v1.total_potential_liability - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v3 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v4 = arg2.potential_payout - v3;
            v1.accrued_fees = v1.accrued_fees + v3;
            arg2.platform_fee = v3;
            assert!(0x2::balance::value<T0>(&v1.treasury) >= v4, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.treasury, v4), arg5), arg2.bettor);
            let v5 = BetSettled{
                bet_id         : 0x2::object::id<BetTb2>(arg2),
                bettor         : arg2.bettor,
                status         : 1,
                payout         : v4,
                coin_type_name : arg2.coin_type_name,
                timestamp      : v2,
            };
            0x2::event::emit<BetSettled>(v5);
        } else {
            arg2.status = 2;
            let v6 = BetSettled{
                bet_id         : 0x2::object::id<BetTb2>(arg2),
                bettor         : arg2.bettor,
                status         : 2,
                payout         : 0,
                coin_type_name : arg2.coin_type_name,
                timestamp      : v2,
            };
            0x2::event::emit<BetSettled>(v6);
        };
    }

    public entry fun settle_bet_td2(arg0: &OracleCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        settle_bet<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun td2_is_initialized(arg0: &BettingPlatformTb2) : bool {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg0.id, v0)
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        arg1.paused = !arg1.paused;
        let v0 = PlatformPaused{
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            paused      : arg1.paused,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public fun token_is_registered<T0>(arg0: &BettingPlatformTb2) : bool {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg0.id, v0)
    }

    public entry fun unlock_direct_withdrawals(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &0x2::clock::Clock) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0)) {
            let v1 = WithdrawalLockKey{dummy_field: false};
            0x2::dynamic_field::remove<WithdrawalLockKey, bool>(&mut arg1.id, v1);
        };
        let v2 = DirectWithdrawalsLocked{
            platform_id : 0x2::object::id<BettingPlatformTb2>(arg1),
            locked      : false,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DirectWithdrawalsLocked>(v2);
    }

    public entry fun update_bet_expiry(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        arg1.bet_expiry_ms = arg2;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        assert!(arg2 <= 1000, 2);
        arg1.platform_fee_bps = arg2;
    }

    public entry fun update_limits_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: u64) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        update_token_limits<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_multisig_signers(arg0: &AdminCap, arg1: &mut MultisigGuard, arg2: vector<address>, arg3: u64) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg3 > 0 && arg3 <= v0, 26);
        assert!(v0 >= 2, 26);
        validate_unique_signers(&arg2);
        arg1.signers = arg2;
        arg1.threshold = arg3;
    }

    public entry fun update_token_limits<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: u64) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1);
        assert!(arg3 <= v2.absolute_max_bet, 15);
        v2.min_bet = arg2;
        v2.max_bet = arg3;
    }

    public entry fun update_token_withdrawal_ceiling<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        let v0 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v0), 27);
        assert!(arg2 > 0, 6);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1).max_single_withdrawal = arg2;
    }

    public entry fun update_withdrawal_ceiling_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        update_token_withdrawal_ceiling<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2);
    }

    fun validate_unique_signers(arg0: &vector<address>) {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<address>(arg0, v2) != *0x1::vector::borrow<address>(arg0, v1), 26);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public entry fun void_bet<T0>(arg0: &OracleCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type_name == get_coin_type_name<T0>(), 29);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = TokenStateKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v0);
        v1.total_potential_liability = v1.total_potential_liability - arg2.potential_payout;
        let v2 = arg2.stake;
        assert!(0x2::balance::value<T0>(&v1.treasury) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.treasury, v2), arg4), arg2.bettor);
        let v3 = BetSettled{
            bet_id         : 0x2::object::id<BetTb2>(arg2),
            bettor         : arg2.bettor,
            status         : 3,
            payout         : v2,
            coin_type_name : arg2.coin_type_name,
            timestamp      : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v3);
    }

    public entry fun void_bet_admin<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type_name == get_coin_type_name<T0>(), 29);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = TokenStateKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v0);
        v1.total_potential_liability = v1.total_potential_liability - arg2.potential_payout;
        let v2 = arg2.stake;
        assert!(0x2::balance::value<T0>(&v1.treasury) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.treasury, v2), arg4), arg2.bettor);
        let v3 = BetSettled{
            bet_id         : 0x2::object::id<BetTb2>(arg2),
            bettor         : arg2.bettor,
            status         : 3,
            payout         : v2,
            coin_type_name : arg2.coin_type_name,
            timestamp      : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v3);
    }

    public entry fun void_bet_td2(arg0: &OracleCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        void_bet<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun void_bet_td2_admin(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        void_bet_admin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun void_phantom_bet<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type_name == get_coin_type_name<T0>(), 29);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg2.status = 3;
        arg2.settled_at = v0;
        let v1 = TokenStateKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg2.potential_payout;
        let v3 = PhantomBetVoided{
            bet_id          : 0x2::object::id<BetTb2>(arg2),
            bettor          : arg2.bettor,
            stake           : arg2.stake,
            liability_freed : arg2.potential_payout,
            coin_type_name  : arg2.coin_type_name,
            timestamp       : v0,
        };
        0x2::event::emit<PhantomBetVoided>(v3);
    }

    public entry fun void_phantom_bet_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: &mut BetTb2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        void_phantom_bet<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v1), 27);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg1.last_withdrawal_at + 3600000, 17);
        let v3 = TokenStateKey<T0>{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v3);
        assert!(arg2 <= v4.accrued_fees, 0);
        assert!(0x2::balance::value<T0>(&v4.treasury) >= arg2, 11);
        assert!(arg2 <= v4.max_single_withdrawal, 17);
        arg1.last_withdrawal_at = v2;
        v4.accrued_fees = v4.accrued_fees - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.treasury, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v5 = FeesWithdrawn{
            platform_id    : 0x2::object::id<BettingPlatformTb2>(arg1),
            amount         : arg2,
            coin_type_name : get_coin_type_name<T0>(),
            timestamp      : v2,
        };
        0x2::event::emit<FeesWithdrawn>(v5);
    }

    public entry fun withdraw_fees_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        withdraw_fees<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_treasury<T0>(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        let v1 = TokenStateKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<T0>>(&arg1.id, v1), 27);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg1.last_withdrawal_at + 3600000, 17);
        let v3 = TokenStateKey<T0>{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<TokenStateKey<T0>, TokenState<T0>>(&mut arg1.id, v3);
        assert!(0x2::balance::value<T0>(&v4.treasury) >= arg2, 11);
        assert!(0x2::balance::value<T0>(&v4.treasury) - arg2 >= v4.total_potential_liability, 0);
        assert!(arg2 <= v4.max_single_withdrawal, 17);
        arg1.last_withdrawal_at = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.treasury, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v5 = TreasuryWithdrawn{
            platform_id    : 0x2::object::id<BettingPlatformTb2>(arg1),
            amount         : arg2,
            coin_type_name : get_coin_type_name<T0>(),
            timestamp      : v2,
        };
        0x2::event::emit<TreasuryWithdrawn>(v5);
    }

    public entry fun withdraw_treasury_td2(arg0: &AdminCap, arg1: &mut BettingPlatformTb2, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TokenStateKey<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(&arg1.id, v0), 32);
        withdraw_treasury<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

