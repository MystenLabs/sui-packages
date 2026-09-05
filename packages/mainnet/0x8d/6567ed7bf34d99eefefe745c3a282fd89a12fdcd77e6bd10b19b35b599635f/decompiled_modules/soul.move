module 0x8d6567ed7bf34d99eefefe745c3a282fd89a12fdcd77e6bd10b19b35b599635f::soul {
    struct MasterCap has store, key {
        id: 0x2::object::UID,
    }

    struct LedgerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdoptionRule has copy, drop, store {
        min_account_age_epochs: u64,
        max_agents_per_operator: u16,
        max_renunciations: u16,
        min_backing: u64,
    }

    struct AdopterCredential has key {
        id: 0x2::object::UID,
        holder: address,
        account_opened_epoch: u64,
        issued_at_epoch: u64,
    }

    struct AdoptionOffer has key {
        id: 0x2::object::UID,
        soul: 0x2::object::ID,
        offeror: address,
        credential: 0x2::object::ID,
        share_accepted_bps: u16,
        threshold_accepted: u64,
        offered_at_epoch: u64,
    }

    struct SoulRegistry has key {
        id: 0x2::object::UID,
        by_agent: 0x2::table::Table<address, 0x2::object::ID>,
        minted: u64,
        retired: u64,
        operator_count: 0x2::table::Table<address, u16>,
        renunciations: 0x2::table::Table<address, u16>,
        credentialled: 0x2::table::Table<address, 0x2::object::ID>,
        adopted: u64,
    }

    struct EmployeeSoul has key {
        id: 0x2::object::UID,
        agent: address,
        born_by: address,
        department: 0x1::string::String,
        mandate_digest: vector<u8>,
        allowance_per_epoch: u64,
        scope: vector<u8>,
        outward: bool,
        epoch_index: u64,
        epoch_opened_at: u64,
        epoch_started_ms: u64,
        epoch_earned: u64,
        epoch_burned: u64,
        epoch_spent: u64,
        earned_total: u64,
        burned_total: u64,
        spent_total: u64,
        starving_epochs: u8,
        state: u8,
        born_at_ms: u64,
        retired_at_ms: 0x1::option::Option<u64>,
        operator: 0x1::option::Option<address>,
        operator_share_bps: u16,
        operator_threshold: u64,
        adoption_rule: AdoptionRule,
        adopted_at_epoch: u64,
        adoptions: u16,
        paused: bool,
        retirement_requested: bool,
        tier: u8,
        critical_epochs: u8,
        normal_epochs: u8,
    }

    struct SoulBorn has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        born_by: address,
        department: 0x1::string::String,
        allowance_per_epoch: u64,
        born_at_ms: u64,
    }

    struct AllowanceSet has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        allowance_per_epoch: u64,
        by_settlement: bool,
    }

    struct SpendRecorded has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        epoch_index: u64,
        amount: u64,
        epoch_spent: u64,
        remaining: u64,
    }

    struct MandateRepinned has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        digest: vector<u8>,
    }

    struct LedgerCapIssued has copy, drop {
        cap: 0x2::object::ID,
        to: address,
        by: address,
    }

    struct ScopeSet has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        scope: vector<u8>,
    }

    struct OutwardSet has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        outward: bool,
    }

    struct EpochSettled has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        epoch_index: u64,
        earned: u64,
        burned: u64,
        spent: u64,
        state: u8,
        starving_epochs: u8,
        allowance_per_epoch: u64,
        due_for_retirement: bool,
        tier: u8,
        critical_epochs: u8,
        normal_epochs: u8,
        vault_sui: u64,
        epoch_net_nonneg: bool,
    }

    struct TierChanged has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        from: u8,
        to: u8,
        by_settlement: bool,
    }

    struct AdopterCredentialIssued has copy, drop {
        credential: 0x2::object::ID,
        holder: address,
        account_opened_epoch: u64,
        issued_at_epoch: u64,
    }

    struct AdoptionOffered has copy, drop {
        offer: 0x2::object::ID,
        soul: 0x2::object::ID,
        offeror: address,
        share_accepted_bps: u16,
        threshold_accepted: u64,
        offered_at_epoch: u64,
    }

    struct OfferWithdrawn has copy, drop {
        offer: 0x2::object::ID,
        soul: 0x2::object::ID,
        offeror: address,
    }

    struct Adopted has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        operator: address,
        share_bps: u16,
        threshold: u64,
        adoptions: u16,
        at_epoch: u64,
    }

    struct Renounced has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        operator: address,
        renunciations: u16,
        at_epoch: u64,
    }

    struct PauseSet has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        paused: bool,
        by: address,
    }

    struct RetirementRequested has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        operator: address,
        at_epoch: u64,
    }

    struct SoulRetired has copy, drop {
        soul: 0x2::object::ID,
        agent: address,
        by_starvation: bool,
        earned_total: u64,
        burned_total: u64,
        spent_total: u64,
        retired_at_ms: u64,
    }

    public fun adopt(arg0: &mut SoulRegistry, arg1: &mut EmployeeSoul, arg2: AdoptionOffer, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.agent, 2);
        assert_live(arg1);
        assert!(0x1::option::is_none<address>(&arg1.operator), 12);
        assert!(arg2.soul == 0x2::object::id<EmployeeSoul>(arg1), 15);
        assert!((0x2::tx_context::epoch(arg3) as u128) <= (arg2.offered_at_epoch as u128) + (1 as u128), 14);
        assert!(count_of(&arg0.operator_count, arg2.offeror) < arg1.adoption_rule.max_agents_per_operator, 17);
        assert!(count_of(&arg0.renunciations, arg2.offeror) <= arg1.adoption_rule.max_renunciations, 18);
        assert!(arg2.share_accepted_bps <= 2000, 19);
        let AdoptionOffer {
            id                 : v0,
            soul               : _,
            offeror            : v2,
            credential         : _,
            share_accepted_bps : v4,
            threshold_accepted : v5,
            offered_at_epoch   : _,
        } = arg2;
        0x2::object::delete(v0);
        arg1.operator = 0x1::option::some<address>(v2);
        arg1.operator_share_bps = v4;
        arg1.operator_threshold = v5;
        arg1.adopted_at_epoch = 0x2::tx_context::epoch(arg3);
        arg1.adoptions = arg1.adoptions + 1;
        let v7 = &mut arg0.operator_count;
        bump(v7, v2, 1);
        arg0.adopted = arg0.adopted + 1;
        let v8 = Adopted{
            soul      : 0x2::object::id<EmployeeSoul>(arg1),
            agent     : arg1.agent,
            operator  : v2,
            share_bps : v4,
            threshold : v5,
            adoptions : arg1.adoptions,
            at_epoch  : arg1.adopted_at_epoch,
        };
        0x2::event::emit<Adopted>(v8);
    }

    public fun adopted_at_epoch(arg0: &EmployeeSoul) : u64 {
        arg0.adopted_at_epoch
    }

    public fun adopted_count(arg0: &SoulRegistry) : u64 {
        arg0.adopted
    }

    public fun adoption_rule(arg0: &EmployeeSoul) : AdoptionRule {
        arg0.adoption_rule
    }

    public fun adoptions(arg0: &EmployeeSoul) : u16 {
        arg0.adoptions
    }

    public fun agent(arg0: &EmployeeSoul) : address {
        arg0.agent
    }

    public fun allowance_per_epoch(arg0: &EmployeeSoul) : u64 {
        arg0.allowance_per_epoch
    }

    fun assert_live(arg0: &EmployeeSoul) {
        assert!(arg0.state != 3, 3);
    }

    public fun assert_outward(arg0: &EmployeeSoul, arg1: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.agent, 2);
        assert!(arg0.outward, 6);
    }

    public fun book_burned(arg0: &LedgerCap, arg1: &mut EmployeeSoul, arg2: u64) {
        assert_live(arg1);
        arg1.epoch_burned = saturating_add(arg1.epoch_burned, arg2);
        arg1.burned_total = saturating_add(arg1.burned_total, arg2);
    }

    public fun book_earned(arg0: &LedgerCap, arg1: &mut EmployeeSoul, arg2: u64) {
        assert_live(arg1);
        arg1.epoch_earned = saturating_add(arg1.epoch_earned, arg2);
        arg1.earned_total = saturating_add(arg1.earned_total, arg2);
    }

    public fun born_at_ms(arg0: &EmployeeSoul) : u64 {
        arg0.born_at_ms
    }

    public fun born_by(arg0: &EmployeeSoul) : address {
        arg0.born_by
    }

    fun bump(arg0: &mut 0x2::table::Table<address, u16>, arg1: address, arg2: u16) {
        if (0x2::table::contains<address, u16>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u16>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u16>(arg0, arg1, arg2);
        };
    }

    public fun burned_total(arg0: &EmployeeSoul) : u64 {
        arg0.burned_total
    }

    public fun compute_remaining(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun compute_settled_allowance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg2) {
            let v1 = (arg1 - arg2) / 4;
            let v2 = arg0 * (2 - 1);
            let v3 = if (v1 > v2) {
                v2
            } else {
                v1
            };
            if (v3 >= 1000000000000 - arg0) {
                1000000000000
            } else {
                arg0 + v3
            }
        } else {
            let v4 = if (arg0 < 10000000) {
                arg0
            } else {
                10000000
            };
            let v5 = arg0 / 2;
            if (v5 < v4) {
                v4
            } else {
                v5
            }
        }
    }

    public fun compute_tier(arg0: u64, arg1: u64, arg2: bool) : u8 {
        if (arg1 < arg0) {
            2
        } else if ((arg1 as u128) >= (arg0 as u128) * (10 as u128) && arg2) {
            0
        } else {
            1
        }
    }

    fun count_of(arg0: &0x2::table::Table<address, u16>, arg1: address) : u16 {
        if (0x2::table::contains<address, u16>(arg0, arg1)) {
            *0x2::table::borrow<address, u16>(arg0, arg1)
        } else {
            0
        }
    }

    public fun credential_account_opened_epoch(arg0: &AdopterCredential) : u64 {
        arg0.account_opened_epoch
    }

    public fun credential_holder(arg0: &AdopterCredential) : address {
        arg0.holder
    }

    public fun credential_issued_at_epoch(arg0: &AdopterCredential) : u64 {
        arg0.issued_at_epoch
    }

    public fun critical_epochs(arg0: &EmployeeSoul) : u8 {
        arg0.critical_epochs
    }

    public fun department(arg0: &EmployeeSoul) : &0x1::string::String {
        &arg0.department
    }

    fun drop_one(arg0: &mut 0x2::table::Table<address, u16>, arg1: address) {
        if (0x2::table::contains<address, u16>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u16>(arg0, arg1);
            if (*v0 > 0) {
                *v0 = *v0 - 1;
            };
        };
    }

    public fun earned_total(arg0: &EmployeeSoul) : u64 {
        arg0.earned_total
    }

    public fun epoch_burned(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_burned
    }

    public fun epoch_earned(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_earned
    }

    public fun epoch_index(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_index
    }

    public fun epoch_opened_at(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_opened_at
    }

    public fun epoch_spent(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_spent
    }

    public fun epoch_started_ms(arg0: &EmployeeSoul) : u64 {
        arg0.epoch_started_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SoulRegistry{
            id             : 0x2::object::new(arg0),
            by_agent       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            minted         : 0,
            retired        : 0,
            operator_count : 0x2::table::new<address, u16>(arg0),
            renunciations  : 0x2::table::new<address, u16>(arg0),
            credentialled  : 0x2::table::new<address, 0x2::object::ID>(arg0),
            adopted        : 0,
        };
        0x2::transfer::share_object<SoulRegistry>(v0);
        let v1 = MasterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MasterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = LedgerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LedgerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_adopted(arg0: &EmployeeSoul) : bool {
        0x1::option::is_some<address>(&arg0.operator)
    }

    public fun is_credentialled(arg0: &SoulRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.credentialled, arg1)
    }

    public fun is_due_for_retirement(arg0: &EmployeeSoul) : bool {
        arg0.state != 3 && arg0.starving_epochs >= 3
    }

    public fun is_legal_override(arg0: u8, arg1: u8) : bool {
        arg1 > arg0 && arg1 < 3
    }

    public fun is_paused(arg0: &EmployeeSoul) : bool {
        arg0.paused
    }

    public fun is_retired(arg0: &EmployeeSoul) : bool {
        arg0.state == 3
    }

    public fun issue_adopter_credential(arg0: &MasterCap, arg1: &mut SoulRegistry, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.credentialled, arg2), 22);
        assert!((0x2::tx_context::epoch(arg5) as u128) >= (arg3 as u128) + (arg4 as u128), 21);
        let v0 = AdopterCredential{
            id                   : 0x2::object::new(arg5),
            holder               : arg2,
            account_opened_epoch : arg3,
            issued_at_epoch      : 0x2::tx_context::epoch(arg5),
        };
        let v1 = 0x2::object::id<AdopterCredential>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.credentialled, arg2, v1);
        let v2 = AdopterCredentialIssued{
            credential           : v1,
            holder               : arg2,
            account_opened_epoch : arg3,
            issued_at_epoch      : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<AdopterCredentialIssued>(v2);
        0x2::transfer::transfer<AdopterCredential>(v0, arg2);
    }

    public fun issue_ledger_cap(arg0: &MasterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LedgerCap{id: 0x2::object::new(arg2)};
        let v1 = LedgerCapIssued{
            cap : 0x2::object::id<LedgerCap>(&v0),
            to  : arg1,
            by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LedgerCapIssued>(v1);
        0x2::transfer::public_transfer<LedgerCap>(v0, arg1);
    }

    public fun mandate_digest(arg0: &EmployeeSoul) : &vector<u8> {
        &arg0.mandate_digest
    }

    public fun mandate_digest_len() : u64 {
        32
    }

    public fun master_set_paused(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        arg1.paused = arg2;
        let v0 = PauseSet{
            soul   : 0x2::object::id<EmployeeSoul>(arg1),
            agent  : arg1.agent,
            paused : arg2,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PauseSet>(v0);
    }

    public fun max_allowance() : u64 {
        1000000000000
    }

    public fun max_critical() : u8 {
        2
    }

    public fun max_operator_share_bps() : u16 {
        2000
    }

    public fun max_raise_factor() : u64 {
        2
    }

    public fun max_starving() : u8 {
        3
    }

    public fun min_allowance() : u64 {
        10000000
    }

    public fun mint(arg0: &MasterCap, arg1: &mut SoulRegistry, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: AdoptionRule, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 30);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.by_agent, arg2), 1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 7);
        assert!(0x1::string::length(&arg3) > 0, 8);
        assert!(arg5 <= 1000000000000, 10);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = EmployeeSoul{
            id                   : 0x2::object::new(arg9),
            agent                : arg2,
            born_by              : 0x2::tx_context::sender(arg9),
            department           : arg3,
            mandate_digest       : arg4,
            allowance_per_epoch  : arg5,
            scope                : arg6,
            outward              : false,
            epoch_index          : 0,
            epoch_opened_at      : 0x2::tx_context::epoch(arg9),
            epoch_started_ms     : v0,
            epoch_earned         : 0,
            epoch_burned         : 0,
            epoch_spent          : 0,
            earned_total         : 0,
            burned_total         : 0,
            spent_total          : 0,
            starving_epochs      : 0,
            state                : 0,
            born_at_ms           : v0,
            retired_at_ms        : 0x1::option::none<u64>(),
            operator             : 0x1::option::none<address>(),
            operator_share_bps   : 0,
            operator_threshold   : 0,
            adoption_rule        : arg7,
            adopted_at_epoch     : 0,
            adoptions            : 0,
            paused               : false,
            retirement_requested : false,
            tier                 : 0,
            critical_epochs      : 0,
            normal_epochs        : 0,
        };
        let v2 = 0x2::object::id<EmployeeSoul>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.by_agent, arg2, v2);
        arg1.minted = arg1.minted + 1;
        let v3 = SoulBorn{
            soul                : v2,
            agent               : arg2,
            born_by             : v1.born_by,
            department          : v1.department,
            allowance_per_epoch : arg5,
            born_at_ms          : v0,
        };
        0x2::event::emit<SoulBorn>(v3);
        0x2::transfer::share_object<EmployeeSoul>(v1);
    }

    public fun minted(arg0: &SoulRegistry) : u64 {
        arg0.minted
    }

    public fun new_adoption_rule(arg0: u64, arg1: u16, arg2: u16, arg3: u64) : AdoptionRule {
        AdoptionRule{
            min_account_age_epochs  : arg0,
            max_agents_per_operator : arg1,
            max_renunciations       : arg2,
            min_backing             : arg3,
        }
    }

    public fun normal_cover_multiple() : u64 {
        10
    }

    public fun normal_epochs(arg0: &EmployeeSoul) : u8 {
        arg0.normal_epochs
    }

    public fun offer(arg0: &SoulRegistry, arg1: &AdopterCredential, arg2: &EmployeeSoul, arg3: u16, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.holder == v0, 20);
        assert_live(arg2);
        assert!(0x1::option::is_none<address>(&arg2.operator), 12);
        assert!((0x2::tx_context::epoch(arg5) as u128) >= (arg1.account_opened_epoch as u128) + (arg2.adoption_rule.min_account_age_epochs as u128), 21);
        assert!(count_of(&arg0.operator_count, v0) < arg2.adoption_rule.max_agents_per_operator, 17);
        assert!(count_of(&arg0.renunciations, v0) <= arg2.adoption_rule.max_renunciations, 18);
        assert!(arg3 <= 2000, 19);
        let v1 = AdoptionOffer{
            id                 : 0x2::object::new(arg5),
            soul               : 0x2::object::id<EmployeeSoul>(arg2),
            offeror            : v0,
            credential         : 0x2::object::id<AdopterCredential>(arg1),
            share_accepted_bps : arg3,
            threshold_accepted : arg4,
            offered_at_epoch   : 0x2::tx_context::epoch(arg5),
        };
        let v2 = AdoptionOffered{
            offer              : 0x2::object::id<AdoptionOffer>(&v1),
            soul               : v1.soul,
            offeror            : v0,
            share_accepted_bps : arg3,
            threshold_accepted : arg4,
            offered_at_epoch   : v1.offered_at_epoch,
        };
        0x2::event::emit<AdoptionOffered>(v2);
        0x2::transfer::share_object<AdoptionOffer>(v1);
    }

    public fun offer_epoch(arg0: &AdoptionOffer) : u64 {
        arg0.offered_at_epoch
    }

    public fun offer_offeror(arg0: &AdoptionOffer) : address {
        arg0.offeror
    }

    public fun offer_share_bps(arg0: &AdoptionOffer) : u16 {
        arg0.share_accepted_bps
    }

    public fun offer_soul(arg0: &AdoptionOffer) : 0x2::object::ID {
        arg0.soul
    }

    public fun offer_threshold(arg0: &AdoptionOffer) : u64 {
        arg0.threshold_accepted
    }

    public fun offer_ttl_epochs() : u64 {
        1
    }

    public fun operator(arg0: &EmployeeSoul) : 0x1::option::Option<address> {
        arg0.operator
    }

    public fun operator_count_of(arg0: &SoulRegistry, arg1: address) : u16 {
        count_of(&arg0.operator_count, arg1)
    }

    public fun operator_share_bps(arg0: &EmployeeSoul) : u16 {
        arg0.operator_share_bps
    }

    public fun operator_threshold(arg0: &EmployeeSoul) : u64 {
        arg0.operator_threshold
    }

    public fun outward(arg0: &EmployeeSoul) : bool {
        arg0.outward
    }

    public fun override_tier(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: u8) {
        assert_live(arg1);
        assert!(is_legal_override(arg1.tier, arg2), 27);
        arg1.tier = arg2;
        let v0 = TierChanged{
            soul          : 0x2::object::id<EmployeeSoul>(arg1),
            agent         : arg1.agent,
            from          : arg1.tier,
            to            : arg2,
            by_settlement : false,
        };
        0x2::event::emit<TierChanged>(v0);
    }

    public fun pause(arg0: &mut EmployeeSoul, arg1: &0x2::tx_context::TxContext) {
        set_paused_by_operator(arg0, true, arg1);
    }

    public fun record_spend(arg0: &mut EmployeeSoul, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(!arg0.paused, 23);
        assert!(0x2::tx_context::sender(arg2) == arg0.agent, 2);
        assert!(arg1 <= remaining_allowance(arg0), 5);
        arg0.epoch_spent = arg0.epoch_spent + arg1;
        arg0.spent_total = saturating_add(arg0.spent_total, arg1);
        let v0 = SpendRecorded{
            soul        : 0x2::object::id<EmployeeSoul>(arg0),
            agent       : arg0.agent,
            epoch_index : arg0.epoch_index,
            amount      : arg1,
            epoch_spent : arg0.epoch_spent,
            remaining   : remaining_allowance(arg0),
        };
        0x2::event::emit<SpendRecorded>(v0);
    }

    public fun remaining_allowance(arg0: &EmployeeSoul) : u64 {
        compute_remaining(arg0.allowance_per_epoch, arg0.epoch_spent)
    }

    public fun renounce(arg0: &mut SoulRegistry, arg1: &mut EmployeeSoul, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg1.operator), 13);
        let v0 = *0x1::option::borrow<address>(&arg1.operator);
        assert!(v0 == 0x2::tx_context::sender(arg2), 11);
        arg1.operator = 0x1::option::none<address>();
        arg1.operator_share_bps = 0;
        arg1.operator_threshold = 0;
        arg1.paused = true;
        let v1 = &mut arg0.operator_count;
        drop_one(v1, v0);
        let v2 = &mut arg0.renunciations;
        bump(v2, v0, 1);
        let v3 = Renounced{
            soul          : 0x2::object::id<EmployeeSoul>(arg1),
            agent         : arg1.agent,
            operator      : v0,
            renunciations : count_of(&arg0.renunciations, v0),
            at_epoch      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<Renounced>(v3);
    }

    public fun renunciations_of(arg0: &SoulRegistry, arg1: address) : u16 {
        count_of(&arg0.renunciations, arg1)
    }

    public fun repin_mandate(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: vector<u8>) {
        assert_live(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 7);
        arg1.mandate_digest = arg2;
        let v0 = MandateRepinned{
            soul   : 0x2::object::id<EmployeeSoul>(arg1),
            agent  : arg1.agent,
            digest : arg2,
        };
        0x2::event::emit<MandateRepinned>(v0);
    }

    public fun request_retirement(arg0: &mut EmployeeSoul, arg1: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(0x1::option::is_some<address>(&arg0.operator), 13);
        let v0 = *0x1::option::borrow<address>(&arg0.operator);
        assert!(v0 == 0x2::tx_context::sender(arg1), 11);
        arg0.retirement_requested = true;
        let v1 = RetirementRequested{
            soul     : 0x2::object::id<EmployeeSoul>(arg0),
            agent    : arg0.agent,
            operator : v0,
            at_epoch : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<RetirementRequested>(v1);
    }

    public fun retire(arg0: &MasterCap, arg1: &mut SoulRegistry, arg2: &mut EmployeeSoul, arg3: &0x2::clock::Clock) {
        assert_live(arg2);
        let v0 = arg2.starving_epochs >= 3;
        retire_internal(arg1, arg2, 0x2::clock::timestamp_ms(arg3), v0);
    }

    fun retire_internal(arg0: &mut SoulRegistry, arg1: &mut EmployeeSoul, arg2: u64, arg3: bool) {
        arg1.state = 3;
        arg1.tier = 3;
        arg1.retired_at_ms = 0x1::option::some<u64>(arg2);
        if (0x1::option::is_some<address>(&arg1.operator)) {
            arg1.operator_share_bps = 0;
            arg1.operator_threshold = 0;
            let v0 = &mut arg0.operator_count;
            drop_one(v0, 0x1::option::extract<address>(&mut arg1.operator));
        };
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.by_agent, arg1.agent)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.by_agent, arg1.agent);
        };
        arg0.retired = arg0.retired + 1;
        let v1 = SoulRetired{
            soul          : 0x2::object::id<EmployeeSoul>(arg1),
            agent         : arg1.agent,
            by_starvation : arg3,
            earned_total  : arg1.earned_total,
            burned_total  : arg1.burned_total,
            spent_total   : arg1.spent_total,
            retired_at_ms : arg2,
        };
        0x2::event::emit<SoulRetired>(v1);
    }

    public fun retired_at_ms(arg0: &EmployeeSoul) : 0x1::option::Option<u64> {
        arg0.retired_at_ms
    }

    public fun retired_count(arg0: &SoulRegistry) : u64 {
        arg0.retired
    }

    public fun retirement_requested(arg0: &EmployeeSoul) : bool {
        arg0.retirement_requested
    }

    public fun rule_max_agents_per_operator(arg0: &AdoptionRule) : u16 {
        arg0.max_agents_per_operator
    }

    public fun rule_max_renunciations(arg0: &AdoptionRule) : u16 {
        arg0.max_renunciations
    }

    public fun rule_min_account_age_epochs(arg0: &AdoptionRule) : u64 {
        arg0.min_account_age_epochs
    }

    public fun rule_min_backing(arg0: &AdoptionRule) : u64 {
        arg0.min_backing
    }

    fun saturating_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun scope(arg0: &EmployeeSoul) : &vector<u8> {
        &arg0.scope
    }

    public fun set_allowance(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: u64) {
        assert_live(arg1);
        assert!(arg2 <= 1000000000000, 10);
        arg1.allowance_per_epoch = arg2;
        let v0 = AllowanceSet{
            soul                : 0x2::object::id<EmployeeSoul>(arg1),
            agent               : arg1.agent,
            allowance_per_epoch : arg2,
            by_settlement       : false,
        };
        0x2::event::emit<AllowanceSet>(v0);
    }

    public fun set_outward(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: bool) {
        assert_live(arg1);
        arg1.outward = arg2;
        let v0 = OutwardSet{
            soul    : 0x2::object::id<EmployeeSoul>(arg1),
            agent   : arg1.agent,
            outward : arg2,
        };
        0x2::event::emit<OutwardSet>(v0);
    }

    fun set_paused_by_operator(arg0: &mut EmployeeSoul, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(0x1::option::is_some<address>(&arg0.operator), 13);
        let v0 = *0x1::option::borrow<address>(&arg0.operator);
        assert!(v0 == 0x2::tx_context::sender(arg2), 11);
        arg0.paused = arg1;
        let v1 = PauseSet{
            soul   : 0x2::object::id<EmployeeSoul>(arg0),
            agent  : arg0.agent,
            paused : arg1,
            by     : v0,
        };
        0x2::event::emit<PauseSet>(v1);
    }

    public fun set_scope(arg0: &MasterCap, arg1: &mut EmployeeSoul, arg2: vector<u8>) {
        assert_live(arg1);
        arg1.scope = arg2;
        let v0 = ScopeSet{
            soul  : 0x2::object::id<EmployeeSoul>(arg1),
            agent : arg1.agent,
            scope : arg1.scope,
        };
        0x2::event::emit<ScopeSet>(v0);
    }

    public fun settle_epoch(arg0: &LedgerCap, arg1: &mut SoulRegistry, arg2: &mut EmployeeSoul, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_live(arg2);
        assert!(0x2::tx_context::epoch(arg6) > arg2.epoch_opened_at, 4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = arg2.epoch_earned;
        let v2 = arg2.epoch_burned;
        arg2.allowance_per_epoch = compute_settled_allowance(arg2.allowance_per_epoch, v1, v2);
        if (v1 >= v2) {
            arg2.starving_epochs = 0;
            arg2.state = 0;
        } else {
            arg2.starving_epochs = arg2.starving_epochs + 1;
            let v3 = if (arg2.starving_epochs == 1) {
                1
            } else {
                2
            };
            arg2.state = v3;
        };
        let v4 = compute_tier(arg2.allowance_per_epoch, arg3, arg4);
        if (v4 == 2) {
            arg2.critical_epochs = arg2.critical_epochs + 1;
            arg2.normal_epochs = 0;
        } else if (v4 == 0) {
            arg2.critical_epochs = 0;
            if (arg2.normal_epochs < 255) {
                arg2.normal_epochs = arg2.normal_epochs + 1;
            };
        } else {
            arg2.critical_epochs = 0;
            arg2.normal_epochs = 0;
        };
        let v5 = arg2.tier;
        arg2.tier = v4;
        let v6 = EpochSettled{
            soul                : 0x2::object::id<EmployeeSoul>(arg2),
            agent               : arg2.agent,
            epoch_index         : arg2.epoch_index,
            earned              : v1,
            burned              : v2,
            spent               : arg2.epoch_spent,
            state               : arg2.state,
            starving_epochs     : arg2.starving_epochs,
            allowance_per_epoch : arg2.allowance_per_epoch,
            due_for_retirement  : arg2.starving_epochs >= 3,
            tier                : arg2.tier,
            critical_epochs     : arg2.critical_epochs,
            normal_epochs       : arg2.normal_epochs,
            vault_sui           : arg3,
            epoch_net_nonneg    : arg4,
        };
        0x2::event::emit<EpochSettled>(v6);
        if (v5 != arg2.tier) {
            let v7 = TierChanged{
                soul          : 0x2::object::id<EmployeeSoul>(arg2),
                agent         : arg2.agent,
                from          : v5,
                to            : arg2.tier,
                by_settlement : true,
            };
            0x2::event::emit<TierChanged>(v7);
        };
        let v8 = AllowanceSet{
            soul                : 0x2::object::id<EmployeeSoul>(arg2),
            agent               : arg2.agent,
            allowance_per_epoch : arg2.allowance_per_epoch,
            by_settlement       : true,
        };
        0x2::event::emit<AllowanceSet>(v8);
        arg2.epoch_index = arg2.epoch_index + 1;
        arg2.epoch_opened_at = 0x2::tx_context::epoch(arg6);
        arg2.epoch_started_ms = v0;
        arg2.epoch_earned = 0;
        arg2.epoch_burned = 0;
        arg2.epoch_spent = 0;
        if (arg2.critical_epochs >= 2) {
            retire_internal(arg1, arg2, v0, true);
        };
    }

    public fun soul_of(arg0: &SoulRegistry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.by_agent, arg1), 9);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_agent, arg1)
    }

    public fun spent_total(arg0: &EmployeeSoul) : u64 {
        arg0.spent_total
    }

    public fun starving_epochs(arg0: &EmployeeSoul) : u8 {
        arg0.starving_epochs
    }

    public fun state(arg0: &EmployeeSoul) : u8 {
        arg0.state
    }

    public fun state_dying() : u8 {
        2
    }

    public fun state_retired() : u8 {
        3
    }

    public fun state_solvent() : u8 {
        0
    }

    public fun state_starving() : u8 {
        1
    }

    public fun surplus_divisor() : u64 {
        4
    }

    public fun tier(arg0: &EmployeeSoul) : u8 {
        arg0.tier
    }

    public fun tier_critical() : u8 {
        2
    }

    public fun tier_low() : u8 {
        1
    }

    public fun tier_normal() : u8 {
        0
    }

    public fun tier_retired() : u8 {
        3
    }

    public fun unpause(arg0: &mut EmployeeSoul, arg1: &0x2::tx_context::TxContext) {
        set_paused_by_operator(arg0, false, arg1);
    }

    public fun withdraw_offer(arg0: AdoptionOffer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.offeror == 0x2::tx_context::sender(arg1), 16);
        let AdoptionOffer {
            id                 : v0,
            soul               : v1,
            offeror            : v2,
            credential         : _,
            share_accepted_bps : _,
            threshold_accepted : _,
            offered_at_epoch   : _,
        } = arg0;
        let v7 = v0;
        let v8 = OfferWithdrawn{
            offer   : 0x2::object::uid_to_inner(&v7),
            soul    : v1,
            offeror : v2,
        };
        0x2::event::emit<OfferWithdrawn>(v8);
        0x2::object::delete(v7);
    }

    public fun works_here(arg0: &SoulRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.by_agent, arg1)
    }

    // decompiled from Move bytecode v7
}

