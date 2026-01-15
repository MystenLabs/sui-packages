module 0x17fb0204ea475c2f6ccafbc5cc1bc757f106b6c6983b989dc863fdec316b7502::vault_governance {
    struct VAULT_GOVERNANCE has drop {
        dummy_field: bool,
    }

    struct GovernanceRegistry has key {
        id: 0x2::object::UID,
        admin_set: AdminSet,
        withdrawal_set: WithdrawalSet,
        proposal_counter: u64,
        admin_proposals: 0x2::table::Table<u64, AdminProposal>,
        whitelist_proposals: 0x2::table::Table<u64, WhitelistProposal>,
        governance_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminSet has store {
        addresses: vector<address>,
        is_initialized: bool,
    }

    struct WithdrawalSet has store {
        addresses: 0x2::vec_set::VecSet<address>,
        is_initialized: bool,
    }

    struct AdminProposal has store {
        proposal_type: u8,
        target_address: address,
        replacement_address: 0x1::option::Option<address>,
        signatures: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        executed: bool,
    }

    struct WhitelistProposal has store {
        proposal_type: u8,
        target_address: address,
        signatures: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        executed: bool,
    }

    struct GovernanceInitializedEvent has copy, drop {
        admin_count: u64,
        whitelist_count: u64,
    }

    struct GovernancePausedEvent has copy, drop {
        paused: bool,
        admin: address,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: u64,
        proposal_type: 0x1::string::String,
        creator: address,
    }

    struct ProposalExecutedEvent has copy, drop {
        proposal_id: u64,
        proposal_type: 0x1::string::String,
    }

    fun admin_set_add(arg0: &mut AdminSet, arg1: address) {
        assert!(admin_set_size(arg0) < 7, 2);
        assert!(!admin_set_contains(arg0, &arg1), 12);
        0x1::vector::push_back<address>(&mut arg0.addresses, arg1);
    }

    fun admin_set_contains(arg0: &AdminSet, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.addresses, arg1)
    }

    fun admin_set_remove(arg0: &mut AdminSet, arg1: &address) {
        assert!(admin_set_size(arg0) > 5, 3);
        assert!(admin_set_contains(arg0, arg1), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.addresses)) {
            if (0x1::vector::borrow<address>(&arg0.addresses, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.addresses, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    fun admin_set_size(arg0: &AdminSet) : u64 {
        0x1::vector::length<address>(&arg0.addresses)
    }

    public fun cleanup_expired_admin_proposals(arg0: &mut GovernanceRegistry, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (0x2::table::contains<u64, AdminProposal>(&arg0.admin_proposals, v2)) {
                let v3 = 0x2::table::borrow<u64, AdminProposal>(&arg0.admin_proposals, v2);
                if (v3.created_at + 604800000 <= 0x2::tx_context::epoch_timestamp_ms(arg2) && !v3.executed) {
                    let AdminProposal {
                        proposal_type       : _,
                        target_address      : _,
                        replacement_address : _,
                        signatures          : _,
                        created_at          : _,
                        executed            : _,
                    } = 0x2::table::remove<u64, AdminProposal>(&mut arg0.admin_proposals, v2);
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun cleanup_expired_whitelist_proposals(arg0: &mut GovernanceRegistry, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (0x2::table::contains<u64, WhitelistProposal>(&arg0.whitelist_proposals, v2)) {
                let v3 = 0x2::table::borrow<u64, WhitelistProposal>(&arg0.whitelist_proposals, v2);
                if (v3.created_at + 604800000 <= 0x2::tx_context::epoch_timestamp_ms(arg2) && !v3.executed) {
                    let WhitelistProposal {
                        proposal_type  : _,
                        target_address : _,
                        signatures     : _,
                        created_at     : _,
                        executed       : _,
                    } = 0x2::table::remove<u64, WhitelistProposal>(&mut arg0.whitelist_proposals, v2);
                };
            };
            v1 = v1 + 1;
        };
    }

    fun create_admin_set() : AdminSet {
        AdminSet{
            addresses      : 0x1::vector::empty<address>(),
            is_initialized : false,
        }
    }

    fun create_withdrawal_set() : WithdrawalSet {
        WithdrawalSet{
            addresses      : 0x2::vec_set::empty<address>(),
            is_initialized : false,
        }
    }

    public fun get_admin_addresses(arg0: &GovernanceRegistry) : vector<address> {
        arg0.admin_set.addresses
    }

    public fun get_withdrawal_addresses(arg0: &GovernanceRegistry) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.withdrawal_set.addresses)
    }

    fun init(arg0: VAULT_GOVERNANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = GovernanceRegistry{
            id                  : 0x2::object::new(arg1),
            admin_set           : create_admin_set(),
            withdrawal_set      : create_withdrawal_set(),
            proposal_counter    : 0,
            admin_proposals     : 0x2::table::new<u64, AdminProposal>(arg1),
            whitelist_proposals : 0x2::table::new<u64, WhitelistProposal>(arg1),
            governance_paused   : false,
        };
        0x2::transfer::share_object<GovernanceRegistry>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_admins(arg0: &AdminCap, arg1: &mut GovernanceRegistry, arg2: vector<address>) {
        assert!(!arg1.admin_set.is_initialized, 11);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 >= 5 && v0 <= 7, 4);
        let v1 = 0;
        while (v1 < v0) {
            0x1::vector::push_back<address>(&mut arg1.admin_set.addresses, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        arg1.admin_set.is_initialized = true;
        let v2 = GovernanceInitializedEvent{
            admin_count     : 0x1::vector::length<address>(&arg2),
            whitelist_count : 0x2::vec_set::size<address>(&arg1.withdrawal_set.addresses),
        };
        0x2::event::emit<GovernanceInitializedEvent>(v2);
    }

    public fun initialize_whitelist(arg0: &AdminCap, arg1: &mut GovernanceRegistry, arg2: vector<address>) {
        assert!(!arg1.withdrawal_set.is_initialized, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.withdrawal_set.addresses, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
        arg1.withdrawal_set.is_initialized = true;
        let v1 = GovernanceInitializedEvent{
            admin_count     : admin_set_size(&arg1.admin_set),
            whitelist_count : 0x1::vector::length<address>(&arg2),
        };
        0x2::event::emit<GovernanceInitializedEvent>(v1);
    }

    public fun is_admin(arg0: &GovernanceRegistry, arg1: address) : bool {
        admin_set_contains(&arg0.admin_set, &arg1)
    }

    public fun is_governance_paused(arg0: &GovernanceRegistry) : bool {
        arg0.governance_paused
    }

    public fun is_top_three_admin(arg0: &AdminSet, arg1: &address) : bool {
        let v0 = 0x1::vector::length<address>(&arg0.addresses);
        let v1 = if (v0 < 3) {
            v0
        } else {
            3
        };
        let v2 = 0;
        while (v2 < v1) {
            if (0x1::vector::borrow<address>(&arg0.addresses, v2) == arg1) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun is_top_three_admin_from_registry(arg0: &GovernanceRegistry, arg1: &address) : bool {
        is_top_three_admin(&arg0.admin_set, arg1)
    }

    public fun is_whitelisted(arg0: &GovernanceRegistry, arg1: address) : bool {
        withdrawal_set_contains(&arg0.withdrawal_set, &arg1)
    }

    public fun propose_add_admin(arg0: &mut GovernanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(admin_set_size(&arg0.admin_set) < 7, 2);
        let v1 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = AdminProposal{
            proposal_type       : 0,
            target_address      : arg1,
            replacement_address : 0x1::option::none<address>(),
            signatures          : v2,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg2),
            executed            : false,
        };
        0x2::table::add<u64, AdminProposal>(&mut arg0.admin_proposals, v1, v3);
        let v4 = ProposalCreatedEvent{
            proposal_id   : v1,
            proposal_type : 0x1::string::utf8(b"add_admin"),
            creator       : v0,
        };
        0x2::event::emit<ProposalCreatedEvent>(v4);
    }

    public fun propose_add_whitelist(arg0: &mut GovernanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(!withdrawal_set_contains(&arg0.withdrawal_set, &arg1), 15);
        let v1 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = WhitelistProposal{
            proposal_type  : 0,
            target_address : arg1,
            signatures     : v2,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg2),
            executed       : false,
        };
        0x2::table::add<u64, WhitelistProposal>(&mut arg0.whitelist_proposals, v1, v3);
        let v4 = ProposalCreatedEvent{
            proposal_id   : v1,
            proposal_type : 0x1::string::utf8(b"add_whitelist"),
            creator       : v0,
        };
        0x2::event::emit<ProposalCreatedEvent>(v4);
    }

    public fun propose_remove_admin(arg0: &mut GovernanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(admin_set_size(&arg0.admin_set) > 5, 3);
        let v1 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = AdminProposal{
            proposal_type       : 1,
            target_address      : arg1,
            replacement_address : 0x1::option::none<address>(),
            signatures          : v2,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg2),
            executed            : false,
        };
        0x2::table::add<u64, AdminProposal>(&mut arg0.admin_proposals, v1, v3);
        let v4 = ProposalCreatedEvent{
            proposal_id   : v1,
            proposal_type : 0x1::string::utf8(b"remove_admin"),
            creator       : v0,
        };
        0x2::event::emit<ProposalCreatedEvent>(v4);
    }

    public fun propose_remove_whitelist(arg0: &mut GovernanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(withdrawal_set_contains(&arg0.withdrawal_set, &arg1), 16);
        let v1 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = WhitelistProposal{
            proposal_type  : 1,
            target_address : arg1,
            signatures     : v2,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg2),
            executed       : false,
        };
        0x2::table::add<u64, WhitelistProposal>(&mut arg0.whitelist_proposals, v1, v3);
        let v4 = ProposalCreatedEvent{
            proposal_id   : v1,
            proposal_type : 0x1::string::utf8(b"remove_whitelist"),
            creator       : v0,
        };
        0x2::event::emit<ProposalCreatedEvent>(v4);
    }

    public fun propose_replace_admin(arg0: &mut GovernanceRegistry, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(admin_set_contains(&arg0.admin_set, &arg1), 1);
        assert!(!admin_set_contains(&arg0.admin_set, &arg2), 12);
        let v1 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = AdminProposal{
            proposal_type       : 2,
            target_address      : arg1,
            replacement_address : 0x1::option::some<address>(arg2),
            signatures          : v2,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg3),
            executed            : false,
        };
        0x2::table::add<u64, AdminProposal>(&mut arg0.admin_proposals, v1, v3);
        let v4 = ProposalCreatedEvent{
            proposal_id   : v1,
            proposal_type : 0x1::string::utf8(b"replace_admin"),
            creator       : v0,
        };
        0x2::event::emit<ProposalCreatedEvent>(v4);
    }

    public fun set_governance_pause(arg0: &mut GovernanceRegistry, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        if (arg0.governance_paused == arg1) {
            return
        };
        arg0.governance_paused = arg1;
        let v1 = GovernancePausedEvent{
            paused : arg1,
            admin  : v0,
        };
        0x2::event::emit<GovernancePausedEvent>(v1);
    }

    public fun sign_admin_proposal(arg0: &mut GovernanceRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.admin_proposals, arg1), 24);
        let v1 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.admin_proposals, arg1);
        assert!(!v1.executed, 26);
        assert!(v1.created_at + 604800000 > 0x2::tx_context::epoch_timestamp_ms(arg2), 25);
        assert!(!0x2::vec_set::contains<address>(&v1.signatures, &v0), 14);
        0x2::vec_set::insert<address>(&mut v1.signatures, v0);
        if (0x2::vec_set::size<address>(&v1.signatures) >= 5) {
            v1.executed = true;
            if (v1.proposal_type == 0) {
                let v2 = &mut arg0.admin_set;
                admin_set_add(v2, v1.target_address);
            } else if (v1.proposal_type == 1) {
                let v3 = &mut arg0.admin_set;
                admin_set_remove(v3, &v1.target_address);
            } else if (v1.proposal_type == 2) {
                let v4 = &mut arg0.admin_set;
                admin_set_remove(v4, &v1.target_address);
                let v5 = &mut arg0.admin_set;
                admin_set_add(v5, *0x1::option::borrow<address>(&v1.replacement_address));
            };
            let v6 = ProposalExecutedEvent{
                proposal_id   : arg1,
                proposal_type : 0x1::string::utf8(b"admin"),
            };
            0x2::event::emit<ProposalExecutedEvent>(v6);
        };
    }

    public fun sign_whitelist_proposal(arg0: &mut GovernanceRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_set_contains(&arg0.admin_set, &v0), 1);
        assert!(0x2::table::contains<u64, WhitelistProposal>(&arg0.whitelist_proposals, arg1), 27);
        let v1 = 0x2::table::borrow_mut<u64, WhitelistProposal>(&mut arg0.whitelist_proposals, arg1);
        assert!(!v1.executed, 29);
        assert!(v1.created_at + 604800000 > 0x2::tx_context::epoch_timestamp_ms(arg2), 28);
        assert!(!0x2::vec_set::contains<address>(&v1.signatures, &v0), 14);
        0x2::vec_set::insert<address>(&mut v1.signatures, v0);
        if (0x2::vec_set::size<address>(&v1.signatures) >= 5) {
            v1.executed = true;
            if (v1.proposal_type == 0) {
                let v2 = &mut arg0.withdrawal_set;
                withdrawal_set_add(v2, v1.target_address);
            } else if (v1.proposal_type == 1) {
                let v3 = &mut arg0.withdrawal_set;
                withdrawal_set_remove(v3, &v1.target_address);
            };
            let v4 = ProposalExecutedEvent{
                proposal_id   : arg1,
                proposal_type : 0x1::string::utf8(b"whitelist"),
            };
            0x2::event::emit<ProposalExecutedEvent>(v4);
        };
    }

    fun withdrawal_set_add(arg0: &mut WithdrawalSet, arg1: address) {
        assert!(!withdrawal_set_contains(arg0, &arg1), 13);
        0x2::vec_set::insert<address>(&mut arg0.addresses, arg1);
    }

    fun withdrawal_set_contains(arg0: &WithdrawalSet, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.addresses, arg1)
    }

    fun withdrawal_set_remove(arg0: &mut WithdrawalSet, arg1: &address) {
        assert!(withdrawal_set_contains(arg0, arg1), 5);
        0x2::vec_set::remove<address>(&mut arg0.addresses, arg1);
    }

    // decompiled from Move bytecode v6
}

