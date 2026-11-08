module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input {
    struct FactArg has copy, drop {
        class: 0x1::string::String,
        entry_hash: 0x1::string::String,
        record: vector<u8>,
    }

    struct RoomStateArg has copy, drop {
        room_id: 0x1::string::String,
        state: u8,
        host: 0x1::string::String,
        members_admitted: bool,
        charter_version: u64,
        opening_hash: 0x1::string::String,
        deadline: 0x1::string::String,
        funded: bool,
        next_seq: u64,
        resolver_key: 0x1::string::String,
        committed_count: u64,
        member_grant_counterparties: vector<vector<0x1::string::String>>,
        agreement: 0x1::option::Option<address>,
        escrow: 0x1::string::String,
        authorized_holds: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>,
        phase: 0x1::option::Option<0x1::string::String>,
        opening_snapshots: vector<SnapshotRefArg>,
        award_inputs: 0x1::option::Option<AwardInputsArg>,
    }

    struct SnapshotRefArg has copy, drop {
        class: 0x1::string::String,
        hash: address,
    }

    struct AwardOpeningArg has copy, drop {
        record_id: address,
        bid: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        commit_seq: u64,
    }

    struct AwardInputsArg has copy, drop {
        openings: vector<AwardOpeningArg>,
        bids_closed_seq: u64,
        bids_closed_root: address,
    }

    struct BudgetArg has copy, drop {
        value_cap: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        reserved: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        spent: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        available: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        attempts_used: u64,
        attempt_quota: u64,
        attempts_remaining: u64,
    }

    struct ProposalArg has copy, drop {
        kind: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind,
        author: 0x1::string::String,
        effector: 0x1::string::String,
        counterparty: 0x1::string::String,
        value: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        terms_object: bool,
        terms: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>,
        nonce: address,
        effect: address,
        proposal: address,
        agreement: 0x1::option::Option<address>,
        replaces: 0x1::option::Option<address>,
        binds: vector<BindArg>,
        commitment: 0x1::option::Option<address>,
        salt: 0x1::option::Option<vector<u8>>,
    }

    struct BindArg has copy, drop {
        proposal: address,
        holder: 0x1::string::String,
    }

    struct DecideInput has copy, drop {
        charter: vector<u8>,
        opening: vector<u8>,
        grant: vector<u8>,
        proposal: ProposalArg,
        facts: vector<FactArg>,
        room_state: RoomStateArg,
        budget: BudgetArg,
        clock: 0x1::string::String,
        chain: vector<vector<u8>>,
    }

    public fun agreement(arg0: &ProposalArg) : &0x1::option::Option<address> {
        &arg0.agreement
    }

    public fun author(arg0: &ProposalArg) : &0x1::string::String {
        &arg0.author
    }

    public fun authorized_holds(arg0: &RoomStateArg) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount> {
        &arg0.authorized_holds
    }

    public fun award_inputs(arg0: &RoomStateArg) : &0x1::option::Option<AwardInputsArg> {
        &arg0.award_inputs
    }

    public fun award_openings(arg0: &AwardInputsArg) : &vector<AwardOpeningArg> {
        &arg0.openings
    }

    public fun bids_closed_root(arg0: &AwardInputsArg) : address {
        arg0.bids_closed_root
    }

    public fun bids_closed_seq(arg0: &AwardInputsArg) : u64 {
        arg0.bids_closed_seq
    }

    public fun bind_holder(arg0: &BindArg) : &0x1::string::String {
        &arg0.holder
    }

    public fun bind_proposal(arg0: &BindArg) : address {
        arg0.proposal
    }

    public fun binds(arg0: &ProposalArg) : &vector<BindArg> {
        &arg0.binds
    }

    public fun budget(arg0: &DecideInput) : &BudgetArg {
        &arg0.budget
    }

    public fun budget_attempt_quota(arg0: &BudgetArg) : u64 {
        arg0.attempt_quota
    }

    public fun budget_attempts_remaining(arg0: &BudgetArg) : u64 {
        arg0.attempts_remaining
    }

    public fun budget_attempts_used(arg0: &BudgetArg) : u64 {
        arg0.attempts_used
    }

    public fun budget_available(arg0: &BudgetArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.available
    }

    public fun budget_reserved(arg0: &BudgetArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.reserved
    }

    public fun budget_spent(arg0: &BudgetArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.spent
    }

    public fun budget_value_cap(arg0: &BudgetArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.value_cap
    }

    public fun chain(arg0: &DecideInput) : &vector<vector<u8>> {
        &arg0.chain
    }

    public fun charter(arg0: &DecideInput) : &vector<u8> {
        &arg0.charter
    }

    public fun clock(arg0: &DecideInput) : &0x1::string::String {
        &arg0.clock
    }

    public fun commitment(arg0: &ProposalArg) : &0x1::option::Option<address> {
        &arg0.commitment
    }

    public fun committed_count(arg0: &RoomStateArg) : u64 {
        arg0.committed_count
    }

    public fun counterparty(arg0: &ProposalArg) : &0x1::string::String {
        &arg0.counterparty
    }

    public fun draft() : u8 {
        0
    }

    public fun effect(arg0: &ProposalArg) : address {
        arg0.effect
    }

    public fun effector(arg0: &ProposalArg) : &0x1::string::String {
        &arg0.effector
    }

    public fun escrow(arg0: &RoomStateArg) : &0x1::string::String {
        &arg0.escrow
    }

    public fun fact_class(arg0: &FactArg) : &0x1::string::String {
        &arg0.class
    }

    public fun fact_entry_hash(arg0: &FactArg) : &0x1::string::String {
        &arg0.entry_hash
    }

    public fun fact_record(arg0: &FactArg) : &vector<u8> {
        &arg0.record
    }

    public fun facts(arg0: &DecideInput) : &vector<FactArg> {
        &arg0.facts
    }

    public fun grant(arg0: &DecideInput) : &vector<u8> {
        &arg0.grant
    }

    public fun host(arg0: &RoomStateArg) : &0x1::string::String {
        &arg0.host
    }

    public fun kind(arg0: &ProposalArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind {
        &arg0.kind
    }

    public fun member_grant_counterparties(arg0: &RoomStateArg) : &vector<vector<0x1::string::String>> {
        &arg0.member_grant_counterparties
    }

    public fun members_admitted(arg0: &RoomStateArg) : bool {
        arg0.members_admitted
    }

    public fun next_seq(arg0: &RoomStateArg) : u64 {
        arg0.next_seq
    }

    public fun nonce(arg0: &ProposalArg) : address {
        arg0.nonce
    }

    public fun open() : u8 {
        1
    }

    public fun opening(arg0: &DecideInput) : &vector<u8> {
        &arg0.opening
    }

    public fun opening_bid(arg0: &AwardOpeningArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.bid
    }

    public fun opening_commit_seq(arg0: &AwardOpeningArg) : u64 {
        arg0.commit_seq
    }

    public fun opening_record_id(arg0: &AwardOpeningArg) : address {
        arg0.record_id
    }

    public fun opening_snapshots(arg0: &RoomStateArg) : &vector<SnapshotRefArg> {
        &arg0.opening_snapshots
    }

    public fun parse(arg0: vector<u8>) : 0x1::option::Option<DecideInput> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(arg0);
        let v1 = &mut v0;
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>();
        let v5 = 0;
        while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(&mut v4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::term(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0)));
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::empty<BindArg>();
        v5 = 0;
        while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            let v7 = BindArg{
                proposal : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
                holder   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            };
            0x1::vector::push_back<BindArg>(&mut v6, v7);
            v5 = v5 + 1;
        };
        let v8 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
            0x1::option::some<vector<u8>>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0))
        } else {
            0x1::option::none<vector<u8>>()
        };
        let v9 = ProposalArg{
            kind         : read_record_kind(v2),
            author       : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            effector     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            counterparty : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            value        : read_amount(v3),
            terms_object : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0),
            terms        : v4,
            nonce        : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
            effect       : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
            proposal     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
            agreement    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_address(&mut v0),
            replaces     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_address(&mut v0),
            binds        : v6,
            commitment   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_address(&mut v0),
            salt         : v8,
        };
        let v10 = 0x1::vector::empty<FactArg>();
        v5 = 0;
        while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            let v11 = FactArg{
                class      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
                entry_hash : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
                record     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0),
            };
            0x1::vector::push_back<FactArg>(&mut v10, v11);
            v5 = v5 + 1;
        };
        let v12 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u8(&mut v0);
        let v13 = 0x1::vector::empty<vector<0x1::string::String>>();
        v5 = 0;
        while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x1::vector::push_back<vector<0x1::string::String>>(&mut v13, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0));
            v5 = v5 + 1;
        };
        let v14 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
            let v15 = &mut v0;
            0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>(read_amount(v15))
        } else {
            0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>()
        };
        let v16 = 0x1::vector::empty<SnapshotRefArg>();
        v5 = 0;
        while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            let v17 = SnapshotRefArg{
                class : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
                hash  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
            };
            0x1::vector::push_back<SnapshotRefArg>(&mut v16, v17);
            v5 = v5 + 1;
        };
        let v18 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
            let v19 = 0x1::vector::empty<AwardOpeningArg>();
            v5 = 0;
            while (v5 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
                let v20 = &mut v0;
                let v21 = AwardOpeningArg{
                    record_id  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
                    bid        : read_amount(v20),
                    commit_seq : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
                };
                0x1::vector::push_back<AwardOpeningArg>(&mut v19, v21);
                v5 = v5 + 1;
            };
            let v22 = AwardInputsArg{
                openings         : v19,
                bids_closed_seq  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
                bids_closed_root : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_address(&mut v0),
            };
            0x1::option::some<AwardInputsArg>(v22)
        } else {
            0x1::option::none<AwardInputsArg>()
        };
        if (v12 > 8) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(&mut v0);
        };
        let v23 = RoomStateArg{
            room_id                     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            state                       : v12,
            host                        : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            members_admitted            : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0),
            charter_version             : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            opening_hash                : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            deadline                    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            funded                      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0),
            next_seq                    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            resolver_key                : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            committed_count             : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            member_grant_counterparties : v13,
            agreement                   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_address(&mut v0),
            escrow                      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            authorized_holds            : v14,
            phase                       : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_string(&mut v0),
            opening_snapshots           : v16,
            award_inputs                : v18,
        };
        let v24 = &mut v0;
        let v25 = &mut v0;
        let v26 = &mut v0;
        let v27 = &mut v0;
        let v28 = BudgetArg{
            value_cap          : read_amount(v24),
            reserved           : read_amount(v25),
            spent              : read_amount(v26),
            available          : read_amount(v27),
            attempts_used      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            attempt_quota      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            attempts_remaining : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
        };
        let v29 = if (read_input_version(v1) == 2) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_bytes(&mut v0)
        } else {
            vector[]
        };
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0)) {
            return 0x1::option::none<DecideInput>()
        };
        let v30 = DecideInput{
            charter    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0),
            opening    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0),
            grant      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0),
            proposal   : v9,
            facts      : v10,
            room_state : v23,
            budget     : v28,
            clock      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            chain      : v29,
        };
        0x1::option::some<DecideInput>(v30)
    }

    public fun phase(arg0: &RoomStateArg) : &0x1::option::Option<0x1::string::String> {
        &arg0.phase
    }

    public fun proposal(arg0: &DecideInput) : &ProposalArg {
        &arg0.proposal
    }

    public fun proposal_hash(arg0: &ProposalArg) : address {
        arg0.proposal
    }

    fun read_amount(arg0: &mut 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::Cursor) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::wire(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(arg0))
    }

    fun read_input_version(arg0: &mut 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::Cursor) : u64 {
        let v0 = *arg0;
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u8(&mut v0) != (2 as u8)) {
            return 1
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(arg0) != 2) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(arg0);
        };
        2
    }

    fun read_record_kind(arg0: &mut 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::Cursor) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_kind_from_tag(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0));
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(&v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(arg0);
            return 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_kind_from_tag(0))
        };
        0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v0)
    }

    public fun replaces(arg0: &ProposalArg) : &0x1::option::Option<address> {
        &arg0.replaces
    }

    public fun resolver_key(arg0: &RoomStateArg) : &0x1::string::String {
        &arg0.resolver_key
    }

    public fun room_agreement(arg0: &RoomStateArg) : &0x1::option::Option<address> {
        &arg0.agreement
    }

    public fun room_id(arg0: &RoomStateArg) : &0x1::string::String {
        &arg0.room_id
    }

    public fun room_state(arg0: &DecideInput) : &RoomStateArg {
        &arg0.room_state
    }

    public fun running() : u8 {
        2
    }

    public fun salt(arg0: &ProposalArg) : &0x1::option::Option<vector<u8>> {
        &arg0.salt
    }

    public fun snapshot_class(arg0: &SnapshotRefArg) : &0x1::string::String {
        &arg0.class
    }

    public fun snapshot_hash(arg0: &SnapshotRefArg) : address {
        arg0.hash
    }

    public fun state(arg0: &RoomStateArg) : u8 {
        arg0.state
    }

    public fun terms(arg0: &ProposalArg) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField> {
        &arg0.terms
    }

    public fun terms_object(arg0: &ProposalArg) : bool {
        arg0.terms_object
    }

    public fun value(arg0: &ProposalArg) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.value
    }

    // decompiled from Move bytecode v7
}

