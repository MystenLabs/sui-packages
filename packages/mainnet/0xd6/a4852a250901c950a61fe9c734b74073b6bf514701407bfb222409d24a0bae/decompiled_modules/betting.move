module 0x95432fe09ab4d17afeb874366fbb611d625bfabe3cbcae75dd07b328c5951ac7::betting {
    struct BETTING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct BettingPlatform has key {
        id: 0x2::object::UID,
        treasury_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_volume_sui: u64,
        total_potential_liability_sui: u64,
        accrued_fees_sui: u64,
        treasury_sbets: 0x2::balance::Balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>,
        total_volume_sbets: u64,
        total_potential_liability_sbets: u64,
        accrued_fees_sbets: u64,
        platform_fee_bps: u64,
        total_bets: u64,
        paused: bool,
        min_bet_sui: u64,
        max_bet_sui: u64,
        min_bet_sbets: u64,
        max_bet_sbets: u64,
        oracle_public_key: vector<u8>,
        bet_expiry_ms: u64,
        last_withdrawal_at: u64,
    }

    struct UsdsuiKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdsuiState has store {
        treasury: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        total_volume: u64,
        total_potential_liability: u64,
        accrued_fees: u64,
        min_bet: u64,
        max_bet: u64,
    }

    struct Bet has store, key {
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
        coin_type: u8,
        deadline: u64,
    }

    struct BetPlaced has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        event_id: vector<u8>,
        prediction: vector<u8>,
        odds: u64,
        stake: u64,
        potential_payout: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct BetSettled has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        status: u8,
        payout: u64,
        coin_type: u8,
        timestamp: u64,
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
        coin_type: u8,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type: u8,
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
        coin_type: u8,
        timestamp: u64,
    }

    struct PhantomBetVoided has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        stake: u64,
        liability_freed: u64,
        coin_type: u8,
        timestamp: u64,
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

    struct WithdrawalProposal has key {
        id: 0x2::object::UID,
        proposer: address,
        amount: u64,
        coin_type: u8,
        withdrawal_type: u8,
        recipient: address,
        approvals: vector<address>,
        executed: bool,
        created_at: u64,
        expires_at: u64,
        guard_id: 0x2::object::ID,
        platform_id: 0x2::object::ID,
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
        coin_type: u8,
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
        coin_type: u8,
        withdrawal_type: u8,
        recipient: address,
        approval_count: u64,
        timestamp: u64,
    }

    struct DirectWithdrawalsLocked has copy, drop {
        platform_id: 0x2::object::ID,
        locked: bool,
        timestamp: u64,
    }

    public entry fun admin_reset_liability_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        arg1.total_potential_liability_sbets = arg2;
    }

    public entry fun admin_reset_liability_sui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        arg1.total_potential_liability_sui = arg2;
    }

    public entry fun admin_reset_liability_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        let v0 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v0), 28);
        let v1 = UsdsuiKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1).total_potential_liability = arg2;
    }

    public entry fun approve_withdrawal(arg0: &MultisigGuard, arg1: &mut WithdrawalProposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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
            proposal_id    : 0x2::object::id<WithdrawalProposal>(arg1),
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

    public entry fun claim_expired_refund_sbets(arg0: &mut BettingPlatform, arg1: &mut Bet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 1);
        assert!(arg1.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.deadline, 14);
        assert!(0x2::tx_context::sender(arg3) == arg1.bettor, 2);
        arg1.status = 3;
        arg1.settled_at = v0;
        arg0.total_potential_liability_sbets = arg0.total_potential_liability_sbets - arg1.potential_payout;
        let v1 = arg1.stake;
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg0.treasury_sbets) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg0.treasury_sbets, v1), arg3), arg1.bettor);
        let v2 = ExpiredBetRefunded{
            bet_id        : 0x2::object::id<Bet>(arg1),
            bettor        : arg1.bettor,
            refund_amount : v1,
            coin_type     : 1,
            timestamp     : v0,
        };
        0x2::event::emit<ExpiredBetRefunded>(v2);
    }

    public entry fun claim_expired_refund_sui(arg0: &mut BettingPlatform, arg1: &mut Bet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 1);
        assert!(arg1.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.deadline, 14);
        assert!(0x2::tx_context::sender(arg3) == arg1.bettor, 2);
        arg1.status = 3;
        arg1.settled_at = v0;
        arg0.total_potential_liability_sui = arg0.total_potential_liability_sui - arg1.potential_payout;
        let v1 = arg1.stake;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_sui, v1), arg3), arg1.bettor);
        let v2 = ExpiredBetRefunded{
            bet_id        : 0x2::object::id<Bet>(arg1),
            bettor        : arg1.bettor,
            refund_amount : v1,
            coin_type     : 0,
            timestamp     : v0,
        };
        0x2::event::emit<ExpiredBetRefunded>(v2);
    }

    public entry fun claim_expired_refund_usdsui(arg0: &mut BettingPlatform, arg1: &mut Bet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 1);
        assert!(arg1.coin_type == 2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.deadline, 14);
        assert!(0x2::tx_context::sender(arg3) == arg1.bettor, 2);
        arg1.status = 3;
        arg1.settled_at = v0;
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg0.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg1.potential_payout;
        let v3 = arg1.stake;
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.treasury) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.treasury, v3), arg3), arg1.bettor);
        let v4 = ExpiredBetRefunded{
            bet_id        : 0x2::object::id<Bet>(arg1),
            bettor        : arg1.bettor,
            refund_amount : v3,
            coin_type     : 2,
            timestamp     : v0,
        };
        0x2::event::emit<ExpiredBetRefunded>(v4);
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

    public entry fun create_multisig_guard(arg0: &AdminCap, arg1: &BettingPlatform, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg3 > 0 && arg3 <= v0, 26);
        assert!(v0 >= 2, 26);
        validate_unique_signers(&arg2);
        let v1 = MultisigGuard{
            id          : 0x2::object::new(arg5),
            signers     : arg2,
            threshold   : arg3,
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
        };
        let v2 = MultisigGuardCreated{
            guard_id    : 0x2::object::id<MultisigGuard>(&v1),
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            threshold   : arg3,
            num_signers : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MultisigGuardCreated>(v2);
        0x2::transfer::share_object<MultisigGuard>(v1);
    }

    public entry fun deposit_liquidity(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = LiquidityDeposited{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            depositor   : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            coin_type   : 0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v0);
    }

    public entry fun deposit_liquidity_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, 0x2::coin::into_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(arg2));
        let v0 = LiquidityDeposited{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            depositor   : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg2),
            coin_type   : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v0);
    }

    public entry fun deposit_liquidity_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v0), 28);
        let v1 = UsdsuiKey{dummy_field: false};
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1).treasury, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg2));
        let v2 = LiquidityDeposited{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            depositor   : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2),
            coin_type   : 2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v2);
    }

    public entry fun execute_withdrawal_fees_sbets(arg0: &MultisigGuard, arg1: &mut WithdrawalProposal, arg2: &AdminCap, arg3: &mut BettingPlatform, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg1.coin_type == 1, 6);
        assert!(arg1.withdrawal_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = arg1.amount;
        assert!(v1 <= arg3.accrued_fees_sbets, 0);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg3.treasury_sbets) >= v1, 11);
        assert!(v1 <= 500000000000000000, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        arg3.accrued_fees_sbets = arg3.accrued_fees_sbets - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg3.treasury_sbets, v1), arg5), arg1.recipient);
        let v2 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposal>(arg1),
            amount          : v1,
            coin_type       : 1,
            withdrawal_type : 0,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v2);
    }

    public entry fun execute_withdrawal_fees_sui(arg0: &MultisigGuard, arg1: &mut WithdrawalProposal, arg2: &AdminCap, arg3: &mut BettingPlatform, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg1.coin_type == 0, 6);
        assert!(arg1.withdrawal_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = arg1.amount;
        assert!(v1 <= arg3.accrued_fees_sui, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.treasury_sui) >= v1, 11);
        assert!(v1 <= 500000000000, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        arg3.accrued_fees_sui = arg3.accrued_fees_sui - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.treasury_sui, v1), arg5), arg1.recipient);
        let v2 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposal>(arg1),
            amount          : v1,
            coin_type       : 0,
            withdrawal_type : 0,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v2);
    }

    public entry fun execute_withdrawal_treasury_sbets(arg0: &MultisigGuard, arg1: &mut WithdrawalProposal, arg2: &AdminCap, arg3: &mut BettingPlatform, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg1.coin_type == 1, 6);
        assert!(arg1.withdrawal_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = arg1.amount;
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg3.treasury_sbets) >= v1, 11);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg3.treasury_sbets) - v1 >= arg3.total_potential_liability_sbets, 0);
        assert!(v1 <= 500000000000000000, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg3.treasury_sbets, v1), arg5), arg1.recipient);
        let v2 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposal>(arg1),
            amount          : v1,
            coin_type       : 1,
            withdrawal_type : 1,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v2);
    }

    public entry fun execute_withdrawal_treasury_sui(arg0: &MultisigGuard, arg1: &mut WithdrawalProposal, arg2: &AdminCap, arg3: &mut BettingPlatform, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 25);
        assert!(arg1.guard_id == 0x2::object::id<MultisigGuard>(arg0), 2);
        assert!(arg1.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg0.platform_id == 0x2::object::id<BettingPlatform>(arg3), 2);
        assert!(arg1.coin_type == 0, 6);
        assert!(arg1.withdrawal_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expires_at, 24);
        assert!(count_valid_approvals(arg0, &arg1.approvals) >= arg0.threshold, 23);
        let v1 = arg1.amount;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.treasury_sui) >= v1, 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.treasury_sui) - v1 >= arg3.total_potential_liability_sui, 0);
        assert!(v1 <= 500000000000, 17);
        assert!(v0 >= arg3.last_withdrawal_at + 3600000, 17);
        arg3.last_withdrawal_at = v0;
        arg1.executed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.treasury_sui, v1), arg5), arg1.recipient);
        let v2 = MultisigWithdrawalExecuted{
            proposal_id     : 0x2::object::id<WithdrawalProposal>(arg1),
            amount          : v1,
            coin_type       : 0,
            withdrawal_type : 1,
            recipient       : arg1.recipient,
            approval_count  : 0x1::vector::length<address>(&arg1.approvals),
            timestamp       : v0,
        };
        0x2::event::emit<MultisigWithdrawalExecuted>(v2);
    }

    public fun get_accrued_fees(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.accrued_fees_sui, arg0.accrued_fees_sbets)
    }

    public fun get_bet_deadline(arg0: &Bet) : u64 {
        arg0.deadline
    }

    public fun get_bet_event_id(arg0: &Bet) : vector<u8> {
        arg0.event_id
    }

    public fun get_bet_info(arg0: &Bet) : (address, u64, u64, u64, u8, u8) {
        (arg0.bettor, arg0.stake, arg0.odds, arg0.potential_payout, arg0.status, arg0.coin_type)
    }

    public fun get_bet_limits_sbets(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.min_bet_sbets, arg0.max_bet_sbets)
    }

    public fun get_bet_limits_sui(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.min_bet_sui, arg0.max_bet_sui)
    }

    public fun get_bet_market_id(arg0: &Bet) : vector<u8> {
        arg0.market_id
    }

    public fun get_bet_prediction(arg0: &Bet) : vector<u8> {
        arg0.prediction
    }

    public fun get_multisig_info(arg0: &MultisigGuard) : (vector<address>, u64, 0x2::object::ID) {
        (arg0.signers, arg0.threshold, arg0.platform_id)
    }

    public fun get_platform_stats(arg0: &BettingPlatform) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui), 0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg0.treasury_sbets), arg0.total_bets, arg0.total_volume_sui, arg0.total_volume_sbets, arg0.total_potential_liability_sui, arg0.total_potential_liability_sbets, arg0.platform_fee_bps, arg0.paused)
    }

    public fun get_proposal_info(arg0: &WithdrawalProposal) : (address, u64, u8, u8, address, u64, bool, u64, u64) {
        (arg0.proposer, arg0.amount, arg0.coin_type, arg0.withdrawal_type, arg0.recipient, 0x1::vector::length<address>(&arg0.approvals), arg0.executed, arg0.created_at, arg0.expires_at)
    }

    public fun get_usdsui_stats(arg0: &BettingPlatform) : (u64, u64, u64, u64, u64, u64) {
        let v0 = UsdsuiKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<UsdsuiKey>(&arg0.id, v0)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<UsdsuiKey, UsdsuiState>(&arg0.id, v1);
        (0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.treasury), v2.total_volume, v2.total_potential_liability, v2.accrued_fees, v2.min_bet, v2.max_bet)
    }

    fun init(arg0: BETTING, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<BETTING>(&arg0), 10);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = BettingPlatform{
            id                              : 0x2::object::new(arg1),
            treasury_sui                    : 0x2::balance::zero<0x2::sui::SUI>(),
            total_volume_sui                : 0,
            total_potential_liability_sui   : 0,
            accrued_fees_sui                : 0,
            treasury_sbets                  : 0x2::balance::zero<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(),
            total_volume_sbets              : 0,
            total_potential_liability_sbets : 0,
            accrued_fees_sbets              : 0,
            platform_fee_bps                : 100,
            total_bets                      : 0,
            paused                          : true,
            min_bet_sui                     : 50000000,
            max_bet_sui                     : 100000000000,
            min_bet_sbets                   : 1000000000000,
            max_bet_sbets                   : 100000000000000000,
            oracle_public_key               : 0x1::vector::empty<u8>(),
            bet_expiry_ms                   : 604800000,
            last_withdrawal_at              : 0,
        };
        let v2 = PlatformCreated{
            platform_id  : 0x2::object::id<BettingPlatform>(&v1),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            fee_bps      : 100,
        };
        0x2::event::emit<PlatformCreated>(v2);
        0x2::transfer::share_object<BettingPlatform>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_usdsui_state(arg0: &AdminCap, arg1: &mut BettingPlatform) {
        let v0 = UsdsuiKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v0), 27);
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = UsdsuiState{
            treasury                  : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            total_volume              : 0,
            total_potential_liability : 0,
            accrued_fees              : 0,
            min_bet                   : 1000000,
            max_bet                   : 10000000000,
        };
        0x2::dynamic_field::add<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1, v2);
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

    public fun is_withdrawal_locked(arg0: &BettingPlatform) : bool {
        let v0 = WithdrawalLockKey{dummy_field: false};
        0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg0.id, v0)
    }

    public entry fun lock_direct_withdrawals(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &0x2::clock::Clock) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0)) {
            let v1 = WithdrawalLockKey{dummy_field: false};
            0x2::dynamic_field::add<WithdrawalLockKey, bool>(&mut arg1.id, v1, true);
        };
        let v2 = DirectWithdrawalsLocked{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
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

    public entry fun place_bet(arg0: &mut BettingPlatform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = &arg0.oracle_public_key;
        assert!(0x1::vector::length<u8>(v0) == 32, 16);
        let v1 = build_oracle_message(&arg2, arg5, arg6, 0x2::tx_context::sender(arg10), &arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg7, v0, &v1), 12);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        assert!(v2 <= arg6, 13);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v3 > 0, 6);
        assert!(v3 >= arg0.min_bet_sui, 9);
        assert!(v3 <= arg0.max_bet_sui, 8);
        assert!(v3 <= 1000000000000, 15);
        assert!(arg5 >= 100, 3);
        assert!(arg5 <= 100000, 3);
        let v4 = (v3 as u128) * (arg5 as u128) / 100;
        assert!(v4 <= 18446744073709551615, 6);
        let v5 = (v4 as u64);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui) + v3 >= arg0.total_potential_liability_sui + v5, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume_sui = arg0.total_volume_sui + v3;
        arg0.total_potential_liability_sui = arg0.total_potential_liability_sui + v5;
        let v6 = 0x2::tx_context::sender(arg10);
        let v7 = Bet{
            id               : 0x2::object::new(arg10),
            bettor           : v6,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v3,
            potential_payout : v5,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v2,
            settled_at       : 0,
            walrus_blob_id   : arg8,
            coin_type        : 0,
            deadline         : v2 + arg0.bet_expiry_ms,
        };
        let v8 = BetPlaced{
            bet_id           : 0x2::object::id<Bet>(&v7),
            bettor           : v6,
            event_id         : v7.event_id,
            prediction       : v7.prediction,
            odds             : arg5,
            stake            : v3,
            potential_payout : v5,
            coin_type        : 0,
            timestamp        : v2,
        };
        0x2::event::emit<BetPlaced>(v8);
        0x2::transfer::share_object<Bet>(v7);
    }

    public entry fun place_bet_sbets(arg0: &mut BettingPlatform, arg1: 0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = &arg0.oracle_public_key;
        assert!(0x1::vector::length<u8>(v0) == 32, 16);
        let v1 = build_oracle_message(&arg2, arg5, arg6, 0x2::tx_context::sender(arg10), &arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg7, v0, &v1), 12);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        assert!(v2 <= arg6, 13);
        let v3 = 0x2::coin::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1);
        assert!(v3 > 0, 6);
        assert!(v3 >= arg0.min_bet_sbets, 9);
        assert!(v3 <= arg0.max_bet_sbets, 8);
        assert!(v3 <= 1000000000000000000, 15);
        assert!(arg5 >= 100, 3);
        assert!(arg5 <= 100000, 3);
        let v4 = (v3 as u128) * (arg5 as u128) / 100;
        assert!(v4 <= 18446744073709551615, 6);
        let v5 = (v4 as u64);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg0.treasury_sbets) + v3 >= arg0.total_potential_liability_sbets + v5, 0);
        0x2::balance::join<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg0.treasury_sbets, 0x2::coin::into_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(arg1));
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume_sbets = arg0.total_volume_sbets + v3;
        arg0.total_potential_liability_sbets = arg0.total_potential_liability_sbets + v5;
        let v6 = 0x2::tx_context::sender(arg10);
        let v7 = Bet{
            id               : 0x2::object::new(arg10),
            bettor           : v6,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v3,
            potential_payout : v5,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v2,
            settled_at       : 0,
            walrus_blob_id   : arg8,
            coin_type        : 1,
            deadline         : v2 + arg0.bet_expiry_ms,
        };
        let v8 = BetPlaced{
            bet_id           : 0x2::object::id<Bet>(&v7),
            bettor           : v6,
            event_id         : v7.event_id,
            prediction       : v7.prediction,
            odds             : arg5,
            stake            : v3,
            potential_payout : v5,
            coin_type        : 1,
            timestamp        : v2,
        };
        0x2::event::emit<BetPlaced>(v8);
        0x2::transfer::share_object<Bet>(v7);
    }

    public entry fun place_bet_usdsui(arg0: &mut BettingPlatform, arg1: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg0.id, v0), 28);
        let v1 = &arg0.oracle_public_key;
        assert!(0x1::vector::length<u8>(v1) == 32, 16);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = build_oracle_message(&arg2, arg5, arg6, v2, &arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg7, v1, &v3), 12);
        let v4 = 0x2::clock::timestamp_ms(arg9);
        assert!(v4 <= arg6, 13);
        let v5 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg1);
        assert!(v5 > 0, 6);
        assert!(arg5 >= 100, 3);
        assert!(arg5 <= 100000, 3);
        assert!(v5 <= 100000000000, 15);
        let v6 = (v5 as u128) * (arg5 as u128) / 100;
        assert!(v6 <= 18446744073709551615, 6);
        let v7 = (v6 as u64);
        let v8 = UsdsuiKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg0.id, v8);
        assert!(v5 >= v9.min_bet, 9);
        assert!(v5 <= v9.max_bet, 8);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v9.treasury) + v5 >= v9.total_potential_liability + v7, 0);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v9.treasury, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg1));
        v9.total_volume = v9.total_volume + v5;
        v9.total_potential_liability = v9.total_potential_liability + v7;
        arg0.total_bets = arg0.total_bets + 1;
        let v10 = Bet{
            id               : 0x2::object::new(arg10),
            bettor           : v2,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v5,
            potential_payout : v7,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v4,
            settled_at       : 0,
            walrus_blob_id   : arg8,
            coin_type        : 2,
            deadline         : v4 + arg0.bet_expiry_ms,
        };
        let v11 = BetPlaced{
            bet_id           : 0x2::object::id<Bet>(&v10),
            bettor           : v2,
            event_id         : v10.event_id,
            prediction       : v10.prediction,
            odds             : arg5,
            stake            : v5,
            potential_payout : v7,
            coin_type        : 2,
            timestamp        : v4,
        };
        0x2::event::emit<BetPlaced>(v11);
        0x2::transfer::share_object<Bet>(v10);
    }

    public entry fun propose_withdrawal(arg0: &MultisigGuard, arg1: u64, arg2: u8, arg3: u8, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(is_signer(arg0, v0), 21);
        assert!(arg2 == 0 || arg2 == 1, 6);
        assert!(arg3 == 0 || arg3 == 1, 6);
        assert!(arg1 > 0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = WithdrawalProposal{
            id              : 0x2::object::new(arg6),
            proposer        : v0,
            amount          : arg1,
            coin_type       : arg2,
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
            proposal_id     : 0x2::object::id<WithdrawalProposal>(&v3),
            proposer        : v0,
            amount          : arg1,
            coin_type       : arg2,
            withdrawal_type : arg3,
            recipient       : arg4,
            timestamp       : v1,
        };
        0x2::event::emit<WithdrawalProposed>(v4);
        0x2::transfer::share_object<WithdrawalProposal>(v3);
    }

    public entry fun receive_sbets_coins(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::transfer::public_receive<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(&mut arg1.id, arg2), 0x2::tx_context::sender(arg3));
    }

    public entry fun receive_sui_coins(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, arg2), 0x2::tx_context::sender(arg3));
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

    public entry fun set_oracle_public_key(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 18);
        arg1.oracle_public_key = arg2;
        let v0 = OracleKeyUpdated{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OracleKeyUpdated>(v0);
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = PlatformPaused{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            paused      : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun settle_bet(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_sbets(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_sbets_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_usdsui(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v3 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v4 = arg2.potential_payout - v3;
            v2.accrued_fees = v2.accrued_fees + v3;
            arg2.platform_fee = v3;
            assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.treasury) >= v4, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.treasury, v4), arg5), arg2.bettor);
            let v5 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v4,
                coin_type : 2,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v5);
        } else {
            arg2.status = 2;
            v2.accrued_fees = v2.accrued_fees + arg2.stake;
            let v6 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 2,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v6);
        };
    }

    public entry fun settle_bet_usdsui_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v3 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v4 = arg2.potential_payout - v3;
            v2.accrued_fees = v2.accrued_fees + v3;
            arg2.platform_fee = v3;
            assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v2.treasury) >= v4, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.treasury, v4), arg5), arg2.bettor);
            let v5 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v4,
                coin_type : 2,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v5);
        } else {
            arg2.status = 2;
            v2.accrued_fees = v2.accrued_fees + arg2.stake;
            let v6 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 2,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v6);
        };
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &0x2::clock::Clock) {
        arg1.paused = !arg1.paused;
        let v0 = PlatformPaused{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            paused      : arg1.paused,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun unlock_direct_withdrawals(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &0x2::clock::Clock) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0)) {
            let v1 = WithdrawalLockKey{dummy_field: false};
            0x2::dynamic_field::remove<WithdrawalLockKey, bool>(&mut arg1.id, v1);
        };
        let v2 = DirectWithdrawalsLocked{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            locked      : false,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DirectWithdrawalsLocked>(v2);
    }

    public entry fun update_bet_expiry(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        arg1.bet_expiry_ms = arg2;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        assert!(arg2 <= 1000, 2);
        arg1.platform_fee_bps = arg2;
    }

    public entry fun update_limits_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: u64) {
        assert!(arg3 <= 1000000000000000000, 15);
        arg1.min_bet_sbets = arg2;
        arg1.max_bet_sbets = arg3;
    }

    public entry fun update_limits_sui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: u64) {
        assert!(arg3 <= 1000000000000, 15);
        arg1.min_bet_sui = arg2;
        arg1.max_bet_sui = arg3;
    }

    public entry fun update_limits_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: u64) {
        let v0 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v0), 28);
        assert!(arg3 <= 100000000000, 15);
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1);
        v2.min_bet = arg2;
        v2.max_bet = arg3;
    }

    public entry fun update_multisig_signers(arg0: &AdminCap, arg1: &mut MultisigGuard, arg2: vector<address>, arg3: u64) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg3 > 0 && arg3 <= v0, 26);
        assert!(v0 >= 2, 26);
        validate_unique_signers(&arg2);
        arg1.signers = arg2;
        arg1.threshold = arg3;
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

    public entry fun void_bet(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        let v0 = arg2.stake;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v0), arg4), arg2.bettor);
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 0,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        let v0 = arg2.stake;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v0), arg4), arg2.bettor);
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 0,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_sbets(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        let v0 = arg2.stake;
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, v0), arg4), arg2.bettor);
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 1,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_sbets_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        let v0 = arg2.stake;
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, v0), arg4), arg2.bettor);
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 1,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_usdsui(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 2, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = UsdsuiKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v0);
        v1.total_potential_liability = v1.total_potential_liability - arg2.potential_payout;
        let v2 = arg2.stake;
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1.treasury) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.treasury, v2), arg4), arg2.bettor);
        let v3 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v2,
            coin_type : 2,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v3);
    }

    public entry fun void_bet_usdsui_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 2, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = UsdsuiKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v0);
        v1.total_potential_liability = v1.total_potential_liability - arg2.potential_payout;
        let v2 = arg2.stake;
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v1.treasury) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.treasury, v2), arg4), arg2.bettor);
        let v3 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v2,
            coin_type : 2,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v3);
    }

    public entry fun void_phantom_bet(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg2.status = 3;
        arg2.settled_at = v0;
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        let v1 = PhantomBetVoided{
            bet_id          : 0x2::object::id<Bet>(arg2),
            bettor          : arg2.bettor,
            stake           : arg2.stake,
            liability_freed : arg2.potential_payout,
            coin_type       : 0,
            timestamp       : v0,
        };
        0x2::event::emit<PhantomBetVoided>(v1);
    }

    public entry fun void_phantom_bet_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg2.status = 3;
        arg2.settled_at = v0;
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        let v1 = PhantomBetVoided{
            bet_id          : 0x2::object::id<Bet>(arg2),
            bettor          : arg2.bettor,
            stake           : arg2.stake,
            liability_freed : arg2.potential_payout,
            coin_type       : 1,
            timestamp       : v0,
        };
        0x2::event::emit<PhantomBetVoided>(v1);
    }

    public entry fun void_phantom_bet_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg2.status = 3;
        arg2.settled_at = v0;
        let v1 = UsdsuiKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v1);
        v2.total_potential_liability = v2.total_potential_liability - arg2.potential_payout;
        let v3 = PhantomBetVoided{
            bet_id          : 0x2::object::id<Bet>(arg2),
            bettor          : arg2.bettor,
            stake           : arg2.stake,
            liability_freed : arg2.potential_payout,
            coin_type       : 2,
            timestamp       : v0,
        };
        0x2::event::emit<PhantomBetVoided>(v3);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        assert!(arg2 <= arg1.accrued_fees_sui, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= arg2, 11);
        assert!(arg2 <= 500000000000, 17);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, arg2), arg4), 0x2::tx_context::sender(arg4));
        arg1.accrued_fees_sui = arg1.accrued_fees_sui - arg2;
        let v2 = FeesWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 0,
            timestamp   : v1,
        };
        0x2::event::emit<FeesWithdrawn>(v2);
    }

    public entry fun withdraw_fees_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        assert!(arg2 <= arg1.accrued_fees_sbets, 0);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= arg2, 11);
        assert!(arg2 <= 500000000000000000, 17);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, arg2), arg4), 0x2::tx_context::sender(arg4));
        arg1.accrued_fees_sbets = arg1.accrued_fees_sbets - arg2;
        let v2 = FeesWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 1,
            timestamp   : v1,
        };
        0x2::event::emit<FeesWithdrawn>(v2);
    }

    public entry fun withdraw_fees_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        let v1 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v1), 28);
        assert!(arg2 <= 500000000000, 17);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v2;
        let v3 = UsdsuiKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v3);
        assert!(arg2 <= v4.accrued_fees, 0);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.treasury) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v4.treasury, arg2), arg4), 0x2::tx_context::sender(arg4));
        v4.accrued_fees = v4.accrued_fees - arg2;
        let v5 = FeesWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 2,
            timestamp   : v2,
        };
        0x2::event::emit<FeesWithdrawn>(v5);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= arg2, 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) - arg2 >= arg1.total_potential_liability_sui, 0);
        assert!(arg2 <= 500000000000, 17);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v2 = TreasuryWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 0,
            timestamp   : v1,
        };
        0x2::event::emit<TreasuryWithdrawn>(v2);
    }

    public entry fun withdraw_treasury_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) >= arg2, 11);
        assert!(0x2::balance::value<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&arg1.treasury_sbets) - arg2 >= arg1.total_potential_liability_sbets, 0);
        assert!(arg2 <= 500000000000000000, 17);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>>(0x2::coin::from_balance<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(0x2::balance::split<0x999d696dad9e4684068fa74ef9c5d3afc411d3ba62973bd5d54830f324f29502::sbets::SBETS>(&mut arg1.treasury_sbets, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v2 = TreasuryWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 1,
            timestamp   : v1,
        };
        0x2::event::emit<TreasuryWithdrawn>(v2);
    }

    public entry fun withdraw_treasury_usdsui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawalLockKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<WithdrawalLockKey>(&arg1.id, v0), 20);
        let v1 = UsdsuiKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdsuiKey>(&arg1.id, v1), 28);
        assert!(arg2 <= 500000000000, 17);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg1.last_withdrawal_at + 3600000, 17);
        arg1.last_withdrawal_at = v2;
        let v3 = UsdsuiKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<UsdsuiKey, UsdsuiState>(&mut arg1.id, v3);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.treasury) >= arg2, 11);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&v4.treasury) - arg2 >= v4.total_potential_liability, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v4.treasury, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v5 = TreasuryWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 2,
            timestamp   : v2,
        };
        0x2::event::emit<TreasuryWithdrawn>(v5);
    }

    // decompiled from Move bytecode v6
}

