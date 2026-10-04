module 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin {
    struct PlayCoinAccount has store {
        balance: u64,
        issuance_seq: u64,
        delegated_backing: u64,
        execution_credit_total: u64,
    }

    struct PlayCoinLedger has key {
        id: 0x2::object::UID,
        contract_schema_version: u16,
        issuance_policy_version: u16,
        module_version: u64,
        shard_ids: vector<0x2::object::ID>,
        escrow_book_id: 0x2::object::ID,
        eligibility_registry_id: 0x2::object::ID,
    }

    struct ExecutionCreditKey has copy, drop, store {
        holder: address,
        execution_id: vector<u8>,
    }

    struct PlayCoinShard has key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        index: u8,
        module_version: u64,
        accounts: 0x2::table::Table<address, PlayCoinAccount>,
        execution_credit: 0x2::table::Table<ExecutionCreditKey, u64>,
        total_issued: u64,
        total_burned: u64,
        total_held: u64,
        total_released_in: u64,
    }

    struct PlayCoinEscrowBook has key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        module_version: u64,
        total_escrowed: u64,
        total_burned: u64,
        escrow_accounts: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct PlayCoinIssuerCap has key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
    }

    struct FaucetDerivedObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WalletDomainKey has copy, drop, store {
        holder: address,
    }

    struct WalletFundingDomainV1 has store {
        domain_id: vector<u8>,
        epoch: u64,
        fresh_public_key: vector<u8>,
        terminal: bool,
    }

    struct FaucetRegistration has key {
        id: 0x2::object::UID,
    }

    struct PlayCoinIssued has copy, drop {
        ledger_id: 0x2::object::ID,
        holder: address,
        amount: u64,
        balance: u64,
        issuance_seq: u64,
        issuance_policy_version: u16,
    }

    struct PlayCoinBalanceCorrected has copy, drop {
        ledger_id: 0x2::object::ID,
        holder: address,
        previous_balance: u64,
        corrected_balance: u64,
        issuance_seq: u64,
        issuance_policy_version: u16,
    }

    struct PlayCoinLedgerContractSchemaVersion has copy, drop {
        ledger_id: 0x2::object::ID,
        ledger_contract_schema_version: u16,
    }

    struct PlayCoinContributionEscrowed has copy, drop {
        ledger_id: 0x2::object::ID,
        escrow_account: 0x2::object::ID,
        holder: address,
        amount: u64,
        balance: u64,
        total_escrowed: u64,
    }

    struct PlayCoinReleasedToHolder has copy, drop {
        ledger_id: 0x2::object::ID,
        escrow_account: 0x2::object::ID,
        holder: address,
        amount: u64,
        balance: u64,
        total_escrowed: u64,
    }

    struct PlayCoinEscrowBurned has copy, drop {
        ledger_id: 0x2::object::ID,
        escrow_account: 0x2::object::ID,
        amount: u64,
        total_escrowed: u64,
    }

    struct InPlayStakeOpened has copy, drop {
        reserve_id: 0x2::object::ID,
        holder: address,
        amount: u64,
    }

    struct InPlayStakeSettled has copy, drop {
        reserve_id: 0x2::object::ID,
        holder: address,
        amount: u64,
    }

    public(friend) fun assert_admitted_version(arg0: &PlayCoinLedger) {
        assert!(is_admitted_version(arg0), 13906837185118142506);
    }

    public(friend) fun add_execution_credit(arg0: &mut PlayCoinShard, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = ExecutionCreditKey{
            holder       : arg1,
            execution_id : arg2,
        };
        if (0x2::table::contains<ExecutionCreditKey, u64>(&arg0.execution_credit, v0)) {
            let v1 = 0x2::table::borrow_mut<ExecutionCreditKey, u64>(&mut arg0.execution_credit, v0);
            *v1 = *v1 + arg3;
        } else {
            0x2::table::add<ExecutionCreditKey, u64>(&mut arg0.execution_credit, v0, arg3);
        };
        ensure_account(arg0, arg1);
        let v2 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg0.accounts, arg1);
        v2.execution_credit_total = v2.execution_credit_total + arg3;
    }

    public(friend) fun add_wallet_domain(arg0: &mut PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admitted_version(arg0);
        assert_shard_admitted_version(arg1);
        assert!(!is_enrolled(arg0, arg2), 13906838860154863650);
        assert_holder_shard(arg0, arg1, arg2);
        if (0x2::table::contains<address, PlayCoinAccount>(&arg1.accounts, arg2)) {
            0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg2).delegated_backing = balance_of(arg1, arg2);
        };
        let v0 = WalletDomainKey{holder: arg2};
        let v1 = WalletFundingDomainV1{
            domain_id        : arg3,
            epoch            : arg4,
            fresh_public_key : arg5,
            terminal         : false,
        };
        0x2::dynamic_field::add<WalletDomainKey, WalletFundingDomainV1>(&mut arg0.id, v0, v1);
    }

    fun apply_escrow(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: &mut PlayCoinEscrowBook, arg3: 0x2::object::ID, arg4: address, arg5: u64) {
        assert_escrow_book(arg0, arg2);
        assert!(arg5 > 0, 13906837928145256456);
        assert!(0x2::table::contains<address, PlayCoinAccount>(&arg1.accounts, arg4), 13906837932440616974);
        let v0 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg4);
        assert!(v0.balance >= arg5, 13906837949620617232);
        v0.balance = v0.balance - arg5;
        arg1.total_held = arg1.total_held - arg5;
        arg2.total_escrowed = arg2.total_escrowed + arg5;
        credit_escrow_account(arg2, arg3, arg5);
        assert_shard_held(arg1);
        let v1 = PlayCoinContributionEscrowed{
            ledger_id      : 0x2::object::id<PlayCoinLedger>(arg0),
            escrow_account : arg3,
            holder         : arg4,
            amount         : arg5,
            balance        : v0.balance,
            total_escrowed : arg2.total_escrowed,
        };
        0x2::event::emit<PlayCoinContributionEscrowed>(v1);
    }

    fun apply_issuance(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg3 > 0, 13906837704806957064);
        assert!(arg3 <= 1000000000, 13906837709102055434);
        ensure_account(arg1, arg2);
        let v0 = 0x2::object::id<PlayCoinLedger>(arg0);
        let v1 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg2);
        assert!(arg4 > v1.issuance_seq, 13906837730577022988);
        v1.issuance_seq = arg4;
        v1.balance = v1.balance + arg3;
        arg1.total_issued = arg1.total_issued + arg3;
        arg1.total_held = arg1.total_held + arg3;
        assert_shard_held(arg1);
        let v2 = PlayCoinIssued{
            ledger_id               : v0,
            holder                  : arg2,
            amount                  : arg3,
            balance                 : v1.balance,
            issuance_seq            : arg4,
            issuance_policy_version : arg0.issuance_policy_version,
        };
        0x2::event::emit<PlayCoinIssued>(v2);
        if (is_enrolled(arg0, arg2)) {
            increase_delegated_backing(arg0, arg1, arg2, arg3);
        };
        let v3 = PlayCoinLedgerContractSchemaVersion{
            ledger_id                      : v0,
            ledger_contract_schema_version : arg0.contract_schema_version,
        };
        0x2::event::emit<PlayCoinLedgerContractSchemaVersion>(v3);
    }

    public(friend) fun assert_book_admitted_version(arg0: &PlayCoinEscrowBook) {
        assert!(version_is_admitted(2, arg0.module_version), 13906837240952717354);
    }

    fun assert_bound_cap(arg0: &PlayCoinIssuerCap, arg1: &PlayCoinLedger) {
        assert!(arg0.ledger_id == 0x2::object::id<PlayCoinLedger>(arg1), 13906837039086895110);
    }

    public(friend) fun assert_enrolled(arg0: &PlayCoinLedger, arg1: address) {
        assert!(is_enrolled(arg0, arg1), 13906838675471138848);
    }

    fun assert_escrow_book(arg0: &PlayCoinLedger, arg1: &PlayCoinEscrowBook) {
        assert!(arg1.ledger_id == 0x2::object::id<PlayCoinLedger>(arg0), 13906837636089577512);
        assert!(0x2::object::id<PlayCoinEscrowBook>(arg1) == arg0.escrow_book_id, 13906837640384544808);
    }

    fun assert_holder_shard(arg0: &PlayCoinLedger, arg1: &PlayCoinShard, arg2: address) {
        assert_shard(arg0, arg1);
        assert!(holder_shard_index(arg2) == (arg1.index as u64), 13906837618909577254);
    }

    public(friend) fun assert_not_enrolled(arg0: &PlayCoinLedger, arg1: address) {
        assert!(!is_enrolled(arg0, arg1), 13906838658291007516);
    }

    fun assert_shard(arg0: &PlayCoinLedger, arg1: &PlayCoinShard) {
        assert!(arg1.ledger_id == 0x2::object::id<PlayCoinLedger>(arg0), 13906837588844675108);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.shard_ids, (arg1.index as u64)) == 0x2::object::id<PlayCoinShard>(arg1), 13906837597434609700);
    }

    public(friend) fun assert_shard_admitted_version(arg0: &PlayCoinShard) {
        assert!(version_is_admitted(2, arg0.module_version), 13906837210887946282);
    }

    fun assert_shard_held(arg0: &PlayCoinShard) {
        assert!(arg0.total_issued + arg0.total_released_in - arg0.total_burned >= arg0.total_held, 13906838228793622546);
    }

    public(friend) fun balance_of(arg0: &PlayCoinShard, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayCoinAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, PlayCoinAccount>(&arg0.accounts, arg1).balance
        } else {
            0
        }
    }

    public fun book_total_burned(arg0: &PlayCoinEscrowBook) : u64 {
        arg0.total_burned
    }

    fun borrow_domain(arg0: &PlayCoinLedger, arg1: address) : &WalletFundingDomainV1 {
        let v0 = WalletDomainKey{holder: arg1};
        assert!(0x2::dynamic_field::exists_with_type<WalletDomainKey, WalletFundingDomainV1>(&arg0.id, v0), 13906839504399826976);
        0x2::dynamic_field::borrow<WalletDomainKey, WalletFundingDomainV1>(&arg0.id, v0)
    }

    fun borrow_domain_mut(arg0: &mut PlayCoinLedger, arg1: address) : &mut WalletFundingDomainV1 {
        let v0 = WalletDomainKey{holder: arg1};
        assert!(0x2::dynamic_field::exists_with_type<WalletDomainKey, WalletFundingDomainV1>(&arg0.id, v0), 13906839543054532640);
        0x2::dynamic_field::borrow_mut<WalletDomainKey, WalletFundingDomainV1>(&mut arg0.id, v0)
    }

    public(friend) fun burn_from_escrow(arg0: &PlayCoinLedger, arg1: &mut PlayCoinEscrowBook, arg2: 0x2::object::ID, arg3: u64) {
        assert_admitted_version(arg0);
        assert_book_admitted_version(arg1);
        assert_escrow_book(arg0, arg1);
        assert!(arg3 > 0, 13906836957482647560);
        debit_escrow_account(arg1, arg2, arg3);
        arg1.total_escrowed = arg1.total_escrowed - arg3;
        arg1.total_burned = arg1.total_burned + arg3;
        let v0 = PlayCoinEscrowBurned{
            ledger_id      : 0x2::object::id<PlayCoinLedger>(arg0),
            escrow_account : arg2,
            amount         : arg3,
            total_escrowed : arg1.total_escrowed,
        };
        0x2::event::emit<PlayCoinEscrowBurned>(v0);
    }

    public(friend) fun claim_faucet_registration(arg0: &mut PlayCoinLedger) : FaucetRegistration {
        assert_admitted_version(arg0);
        let v0 = FaucetDerivedObjectKey{dummy_field: false};
        FaucetRegistration{id: 0x2::derived_object::claim<FaucetDerivedObjectKey>(&mut arg0.id, v0)}
    }

    public fun contract_schema_version(arg0: &PlayCoinLedger) : u16 {
        arg0.contract_schema_version
    }

    public fun correct_balance(arg0: &PlayCoinIssuerCap, arg1: &PlayCoinLedger, arg2: &mut PlayCoinShard, arg3: address, arg4: u64, arg5: u64) {
        assert_admitted_version(arg1);
        assert_shard_admitted_version(arg2);
        assert_bound_cap(arg0, arg1);
        assert_holder_shard(arg1, arg2, arg3);
        assert!(arg4 <= 1000000000, 13906836072719515658);
        assert!(0x2::table::contains<address, PlayCoinAccount>(&arg2.accounts, arg3), 13906836077014745102);
        if (is_enrolled(arg1, arg3)) {
            assert!(arg4 >= delegated_backing(arg1, arg2, arg3), 13906836089900695582);
        };
        let v0 = 0x2::object::id<PlayCoinLedger>(arg1);
        let v1 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg2.accounts, arg3);
        assert!(arg5 > v1.issuance_seq, 13906836111374352396);
        v1.issuance_seq = arg5;
        let v2 = v1.balance;
        v1.balance = arg4;
        if (arg4 >= v2) {
            let v3 = arg4 - v2;
            arg2.total_issued = arg2.total_issued + v3;
            arg2.total_held = arg2.total_held + v3;
        } else {
            let v4 = v2 - arg4;
            arg2.total_burned = arg2.total_burned + v4;
            arg2.total_held = arg2.total_held - v4;
        };
        assert_shard_held(arg2);
        if (is_enrolled(arg1, arg3) && arg4 > v2) {
            increase_delegated_backing(arg1, arg2, arg3, arg4 - v2);
        };
        let v5 = PlayCoinBalanceCorrected{
            ledger_id               : v0,
            holder                  : arg3,
            previous_balance        : v2,
            corrected_balance       : arg4,
            issuance_seq            : arg5,
            issuance_policy_version : arg1.issuance_policy_version,
        };
        0x2::event::emit<PlayCoinBalanceCorrected>(v5);
        let v6 = PlayCoinLedgerContractSchemaVersion{
            ledger_id                      : v0,
            ledger_contract_schema_version : arg1.contract_schema_version,
        };
        0x2::event::emit<PlayCoinLedgerContractSchemaVersion>(v6);
    }

    fun credit_escrow_account(arg0: &mut PlayCoinEscrowBook, arg1: 0x2::object::ID, arg2: u64) {
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.escrow_accounts, arg1)) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.escrow_accounts, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.escrow_accounts, arg1);
        *v0 = *v0 + arg2;
    }

    public fun current_module_version() : u64 {
        2
    }

    fun debit_escrow_account(arg0: &mut PlayCoinEscrowBook, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.escrow_accounts, arg1), 13906838142894407700);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.escrow_accounts, arg1);
        assert!(*v0 >= arg2, 13906838151484342292);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.escrow_accounts, arg1);
        };
    }

    public(friend) fun decrease_delegated_backing(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: address, arg3: u64) {
        assert_holder_shard(arg0, arg1, arg2);
        assert!(0x2::table::contains<address, PlayCoinAccount>(&arg1.accounts, arg2), 13906839143621394446);
        let v0 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg2);
        assert!(v0.delegated_backing >= arg3, 13906839152212377630);
        v0.delegated_backing = v0.delegated_backing - arg3;
    }

    public(friend) fun delegated_backing(arg0: &PlayCoinLedger, arg1: &PlayCoinShard, arg2: address) : u64 {
        assert_holder_shard(arg0, arg1, arg2);
        if (0x2::table::contains<address, PlayCoinAccount>(&arg1.accounts, arg2)) {
            0x2::table::borrow<address, PlayCoinAccount>(&arg1.accounts, arg2).delegated_backing
        } else {
            0
        }
    }

    public(friend) fun destroy_faucet_registration(arg0: FaucetRegistration) {
        let FaucetRegistration { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun domain_epoch(arg0: &PlayCoinLedger, arg1: address) : u64 {
        borrow_domain(arg0, arg1).epoch
    }

    public(friend) fun domain_fresh_key(arg0: &PlayCoinLedger, arg1: address) : vector<u8> {
        borrow_domain(arg0, arg1).fresh_public_key
    }

    public(friend) fun domain_id(arg0: &PlayCoinLedger, arg1: address) : vector<u8> {
        borrow_domain(arg0, arg1).domain_id
    }

    public(friend) fun domain_terminal(arg0: &PlayCoinLedger, arg1: address) : bool {
        borrow_domain(arg0, arg1).terminal
    }

    public fun eligibility_registry_id(arg0: &PlayCoinLedger) : 0x2::object::ID {
        arg0.eligibility_registry_id
    }

    public(friend) fun emit_inplay_stake_opened(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = InPlayStakeOpened{
            reserve_id : arg0,
            holder     : arg1,
            amount     : arg2,
        };
        0x2::event::emit<InPlayStakeOpened>(v0);
    }

    public(friend) fun emit_inplay_stake_settled(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = InPlayStakeSettled{
            reserve_id : arg0,
            holder     : arg1,
            amount     : arg2,
        };
        0x2::event::emit<InPlayStakeSettled>(v0);
    }

    fun ensure_account(arg0: &mut PlayCoinShard, arg1: address) {
        if (!0x2::table::contains<address, PlayCoinAccount>(&arg0.accounts, arg1)) {
            let v0 = PlayCoinAccount{
                balance                : 0,
                issuance_seq           : 0,
                delegated_backing      : 0,
                execution_credit_total : 0,
            };
            0x2::table::add<address, PlayCoinAccount>(&mut arg0.accounts, arg1, v0);
        };
    }

    public(friend) fun escrow_account_balance(arg0: &PlayCoinEscrowBook, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.escrow_accounts, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.escrow_accounts, arg1)
        } else {
            0
        }
    }

    public fun escrow_book_module_version(arg0: &PlayCoinEscrowBook) : u64 {
        arg0.module_version
    }

    public(friend) fun escrow_contribution(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: &mut PlayCoinEscrowBook, arg3: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg4: 0x2::object::ID, arg5: address, arg6: u64) {
        assert_admitted_version(arg0);
        assert_shard_admitted_version(arg1);
        assert_book_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::assert_admitted_version(arg3);
        assert!(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry>(arg3) == arg0.eligibility_registry_id, 13906836403432783894);
        assert_not_enrolled(arg0, arg5);
        assert_holder_shard(arg0, arg1, arg5);
        assert!(!0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::is_excluded(arg3, arg5), 13906836437792653336);
        apply_escrow(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    public(friend) fun escrow_contribution_for_domain(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: &mut PlayCoinEscrowBook, arg3: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg4: 0x2::object::ID, arg5: address, arg6: u64) {
        assert_admitted_version(arg0);
        assert_shard_admitted_version(arg1);
        assert_book_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::assert_admitted_version(arg3);
        assert!(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry>(arg3) == arg0.eligibility_registry_id, 13906839457154531350);
        assert_enrolled(arg0, arg5);
        assert_holder_shard(arg0, arg1, arg5);
        assert!(!0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::is_excluded(arg3, arg5), 13906839470039564312);
        apply_escrow(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    public(friend) fun execution_credit(arg0: &PlayCoinShard, arg1: address, arg2: vector<u8>) : u64 {
        let v0 = ExecutionCreditKey{
            holder       : arg1,
            execution_id : arg2,
        };
        if (0x2::table::contains<ExecutionCreditKey, u64>(&arg0.execution_credit, v0)) {
            *0x2::table::borrow<ExecutionCreditKey, u64>(&arg0.execution_credit, v0)
        } else {
            0
        }
    }

    public(friend) fun execution_credit_total(arg0: &PlayCoinShard, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayCoinAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, PlayCoinAccount>(&arg0.accounts, arg1).execution_credit_total
        } else {
            0
        }
    }

    public(friend) fun faucet_issue(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: address, arg3: u64, arg4: u64) {
        assert_admitted_version(arg0);
        assert_shard_admitted_version(arg1);
        assert_holder_shard(arg0, arg1, arg2);
        apply_issuance(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun has_escrow_account(arg0: &PlayCoinEscrowBook, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.escrow_accounts, arg1)
    }

    public fun holder_shard_id(arg0: &PlayCoinLedger, arg1: address) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_ids, holder_shard_index(arg1))
    }

    public fun holder_shard_index(arg0: address) : u64 {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        (*0x1::vector::borrow<u8>(&v0, 0x1::vector::length<u8>(&v0) - 1) as u64) % 64
    }

    public(friend) fun increase_delegated_backing(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: address, arg3: u64) {
        assert_holder_shard(arg0, arg1, arg2);
        assert!(0x2::table::contains<address, PlayCoinAccount>(&arg1.accounts, arg2), 13906839092081786894);
        let v0 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg2);
        v0.delegated_backing = v0.delegated_backing + arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 64) {
            let v4 = PlayCoinShard{
                id                : 0x2::object::new(arg0),
                ledger_id         : v1,
                index             : (v3 as u8),
                module_version    : 2,
                accounts          : 0x2::table::new<address, PlayCoinAccount>(arg0),
                execution_credit  : 0x2::table::new<ExecutionCreditKey, u64>(arg0),
                total_issued      : 0,
                total_burned      : 0,
                total_held        : 0,
                total_released_in : 0,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<PlayCoinShard>(&v4));
            0x2::transfer::share_object<PlayCoinShard>(v4);
            v3 = v3 + 1;
        };
        let v5 = PlayCoinEscrowBook{
            id              : 0x2::object::new(arg0),
            ledger_id       : v1,
            module_version  : 2,
            total_escrowed  : 0,
            total_burned    : 0,
            escrow_accounts : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::share_object<PlayCoinEscrowBook>(v5);
        let v6 = PlayCoinIssuerCap{
            id        : 0x2::object::new(arg0),
            ledger_id : v1,
        };
        0x2::transfer::transfer<PlayCoinIssuerCap>(v6, 0x2::tx_context::sender(arg0));
        let v7 = PlayCoinLedger{
            id                      : v0,
            contract_schema_version : 3,
            issuance_policy_version : 1,
            module_version          : 2,
            shard_ids               : v2,
            escrow_book_id          : 0x2::object::id<PlayCoinEscrowBook>(&v5),
            eligibility_registry_id : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::create_registry(arg0),
        };
        0x2::transfer::share_object<PlayCoinLedger>(v7);
    }

    public fun is_admitted_version(arg0: &PlayCoinLedger) : bool {
        version_is_admitted(2, arg0.module_version)
    }

    public(friend) fun is_enrolled(arg0: &PlayCoinLedger, arg1: address) : bool {
        let v0 = WalletDomainKey{holder: arg1};
        0x2::dynamic_field::exists_with_type<WalletDomainKey, WalletFundingDomainV1>(&arg0.id, v0)
    }

    public(friend) fun is_registered(arg0: &PlayCoinShard, arg1: address) : bool {
        0x2::table::contains<address, PlayCoinAccount>(&arg0.accounts, arg1)
    }

    public fun issuance_policy_version(arg0: &PlayCoinLedger) : u16 {
        arg0.issuance_policy_version
    }

    public fun issuance_seq(arg0: &PlayCoinShard, arg1: address) : u64 {
        issuance_seq_of(arg0, arg1)
    }

    public(friend) fun issuance_seq_of(arg0: &PlayCoinShard, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayCoinAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, PlayCoinAccount>(&arg0.accounts, arg1).issuance_seq
        } else {
            0
        }
    }

    public fun issue(arg0: &PlayCoinIssuerCap, arg1: &PlayCoinLedger, arg2: &mut PlayCoinShard, arg3: address, arg4: u64, arg5: u64) {
        assert_admitted_version(arg1);
        assert_shard_admitted_version(arg2);
        assert_bound_cap(arg0, arg1);
        assert_holder_shard(arg1, arg2, arg3);
        apply_issuance(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun issue_into_escrow(arg0: &PlayCoinIssuerCap, arg1: &PlayCoinLedger, arg2: &mut PlayCoinShard, arg3: &mut PlayCoinEscrowBook, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: u64) {
        assert_admitted_version(arg1);
        assert_shard_admitted_version(arg2);
        assert_book_admitted_version(arg3);
        assert_bound_cap(arg0, arg1);
        assert_holder_shard(arg1, arg2, arg5);
        apply_issuance(arg1, arg2, arg5, arg6, arg7);
        apply_escrow(arg1, arg2, arg3, arg4, arg5, arg6);
        if (is_enrolled(arg1, arg5)) {
            decrease_delegated_backing(arg1, arg2, arg5, arg6);
        };
    }

    public(friend) fun issuer_cap_ledger_id(arg0: &PlayCoinIssuerCap) : 0x2::object::ID {
        arg0.ledger_id
    }

    public fun ledger_escrow_book_id(arg0: &PlayCoinLedger) : 0x2::object::ID {
        arg0.escrow_book_id
    }

    public fun ledger_shard_ids(arg0: &PlayCoinLedger) : &vector<0x2::object::ID> {
        &arg0.shard_ids
    }

    public(friend) fun max_issue_per_call() : u64 {
        1000000000
    }

    public fun migrate_escrow_book_version(arg0: &mut PlayCoinEscrowBook, arg1: &PlayCoinIssuerCap) : u64 {
        assert!(arg1.ledger_id == arg0.ledger_id, 13906837352619507718);
        assert_book_admitted_version(arg0);
        if (arg0.module_version == 2) {
            return 2
        };
        arg0.module_version = 2;
        2
    }

    public fun migrate_shard_version(arg0: &mut PlayCoinShard, arg1: &PlayCoinIssuerCap) : u64 {
        assert!(arg1.ledger_id == arg0.ledger_id, 13906837318259769350);
        assert_shard_admitted_version(arg0);
        if (arg0.module_version == 2) {
            return 2
        };
        arg0.module_version = 2;
        2
    }

    public fun migrate_version(arg0: &mut PlayCoinLedger, arg1: &PlayCoinIssuerCap) : u64 {
        assert_bound_cap(arg1, arg0);
        if (arg0.module_version == 2) {
            return 2
        };
        assert!(arg0.module_version < 2, 13906837292492324906);
        arg0.module_version = 2;
        2
    }

    public fun module_version(arg0: &PlayCoinLedger) : u64 {
        arg0.module_version
    }

    public(friend) fun release_to_holder(arg0: &PlayCoinLedger, arg1: &mut PlayCoinShard, arg2: &mut PlayCoinEscrowBook, arg3: 0x2::object::ID, arg4: address, arg5: u64) {
        assert_admitted_version(arg0);
        assert_shard_admitted_version(arg1);
        assert_book_admitted_version(arg2);
        assert_holder_shard(arg0, arg1, arg4);
        assert_escrow_book(arg0, arg2);
        assert!(arg5 > 0, 13906836729849380872);
        ensure_account(arg1, arg4);
        debit_escrow_account(arg2, arg3, arg5);
        let v0 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg1.accounts, arg4);
        v0.balance = v0.balance + arg5;
        arg2.total_escrowed = arg2.total_escrowed - arg5;
        arg1.total_held = arg1.total_held + arg5;
        arg1.total_released_in = arg1.total_released_in + arg5;
        assert_shard_held(arg1);
        if (is_enrolled(arg0, arg4)) {
            increase_delegated_backing(arg0, arg1, arg4, arg5);
        };
        let v1 = PlayCoinReleasedToHolder{
            ledger_id      : 0x2::object::id<PlayCoinLedger>(arg0),
            escrow_account : arg3,
            holder         : arg4,
            amount         : arg5,
            balance        : v0.balance,
            total_escrowed : arg2.total_escrowed,
        };
        0x2::event::emit<PlayCoinReleasedToHolder>(v1);
    }

    public(friend) fun set_domain_epoch_and_key(arg0: &mut PlayCoinLedger, arg1: address, arg2: u64, arg3: vector<u8>) {
        assert_admitted_version(arg0);
        let v0 = borrow_domain_mut(arg0, arg1);
        v0.epoch = arg2;
        v0.fresh_public_key = arg3;
    }

    public(friend) fun set_domain_terminal(arg0: &mut PlayCoinLedger, arg1: address) {
        assert_admitted_version(arg0);
        borrow_domain_mut(arg0, arg1).terminal = true;
    }

    public fun shard_count() : u64 {
        64
    }

    public fun shard_id_at(arg0: &PlayCoinLedger, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_ids, arg1)
    }

    public fun shard_index(arg0: &PlayCoinShard) : u8 {
        arg0.index
    }

    public fun shard_module_version(arg0: &PlayCoinShard) : u64 {
        arg0.module_version
    }

    public fun shard_total_burned(arg0: &PlayCoinShard) : u64 {
        arg0.total_burned
    }

    public fun shard_total_held(arg0: &PlayCoinShard) : u64 {
        arg0.total_held
    }

    public fun shard_total_issued(arg0: &PlayCoinShard) : u64 {
        arg0.total_issued
    }

    public fun shard_total_released_in(arg0: &PlayCoinShard) : u64 {
        arg0.total_released_in
    }

    public(friend) fun take_execution_credit(arg0: &mut PlayCoinShard, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = ExecutionCreditKey{
            holder       : arg1,
            execution_id : arg2,
        };
        assert!(0x2::table::contains<ExecutionCreditKey, u64>(&arg0.execution_credit, v0), 13906839362664857616);
        let v1 = 0x2::table::borrow_mut<ExecutionCreditKey, u64>(&mut arg0.execution_credit, v0);
        assert!(*v1 >= arg3, 13906839371254792208);
        *v1 = *v1 - arg3;
        let v2 = 0x2::table::borrow_mut<address, PlayCoinAccount>(&mut arg0.accounts, arg1);
        v2.execution_credit_total = v2.execution_credit_total - arg3;
    }

    public(friend) fun total_burned(arg0: &PlayCoinShard) : u64 {
        arg0.total_burned
    }

    public fun total_escrowed(arg0: &PlayCoinEscrowBook) : u64 {
        arg0.total_escrowed
    }

    public(friend) fun total_held(arg0: &PlayCoinShard) : u64 {
        arg0.total_held
    }

    public(friend) fun total_in_circulation(arg0: &PlayCoinShard) : u64 {
        arg0.total_issued - arg0.total_burned
    }

    public(friend) fun total_issued(arg0: &PlayCoinShard) : u64 {
        arg0.total_issued
    }

    public fun transfer_issuer_cap(arg0: PlayCoinIssuerCap, arg1: address) {
        assert!(arg1 != @0x0, 13906835716238278682);
        0x2::transfer::transfer<PlayCoinIssuerCap>(arg0, arg1);
    }

    public(friend) fun uid(arg0: &PlayCoinLedger) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut PlayCoinLedger) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0
    }

    // decompiled from Move bytecode v7
}

