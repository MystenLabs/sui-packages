module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::document_flow {
    struct ChainParticipant has copy, drop, store {
        address: address,
        name: 0x1::string::String,
        hierarchy_level: u64,
        role: 0x1::string::String,
    }

    struct DocumentFlow has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        organizer: address,
        chain_of_command: vector<ChainParticipant>,
        is_active: bool,
        created_at: u64,
    }

    struct DocumentSubmission has store, key {
        id: 0x2::object::UID,
        flow_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        organizer: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        document_uri: 0x1::string::String,
        document_type: 0x1::string::String,
        current_reviewer_level: u64,
        state: u8,
        approval_history: vector<ApprovalRecord>,
        submitted_at: u64,
        last_updated: u64,
    }

    struct ApprovalRecord has copy, drop, store {
        reviewer: address,
        reviewer_name: 0x1::string::String,
        hierarchy_level: u64,
        action: u8,
        comments: 0x1::string::String,
        timestamp: u64,
    }

    struct DocumentFlowRegistry has key {
        id: 0x2::object::UID,
        flows_by_event: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        submissions_by_event: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        submissions_by_user: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct FlowManagerCap has store, key {
        id: 0x2::object::UID,
        flow_id: 0x2::object::ID,
    }

    struct DocumentFlowCreated has copy, drop {
        flow_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        organizer: address,
        chain_size: u64,
    }

    struct DocumentSubmitted has copy, drop {
        submission_id: 0x2::object::ID,
        flow_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        organizer: address,
        title: 0x1::string::String,
    }

    struct DocumentApproved has copy, drop {
        submission_id: 0x2::object::ID,
        reviewer: address,
        hierarchy_level: u64,
        timestamp: u64,
    }

    struct DocumentRejected has copy, drop {
        submission_id: 0x2::object::ID,
        reviewer: address,
        hierarchy_level: u64,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct DocumentFullyApproved has copy, drop {
        submission_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        organizer: address,
    }

    struct BudgetReleased has copy, drop {
        submission_id: 0x2::object::ID,
        organizer: address,
        amount: u64,
        funded_by: address,
    }

    public fun approve_document(arg0: &mut DocumentSubmission, arg1: &DocumentFlow, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 0, 102);
        let v1 = get_participant_at_level(&arg1.chain_of_command, arg0.current_reviewer_level);
        assert!(v1.address == v0, 103);
        let v2 = ApprovalRecord{
            reviewer        : v0,
            reviewer_name   : v1.name,
            hierarchy_level : arg0.current_reviewer_level,
            action          : 1,
            comments        : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::vector::push_back<ApprovalRecord>(&mut arg0.approval_history, v2);
        if (arg0.current_reviewer_level == get_highest_hierarchy_level(&arg1.chain_of_command)) {
            arg0.state = 1;
            let v3 = DocumentFullyApproved{
                submission_id : 0x2::object::id<DocumentSubmission>(arg0),
                event_id      : arg0.event_id,
                organizer     : arg0.organizer,
            };
            0x2::event::emit<DocumentFullyApproved>(v3);
        } else {
            arg0.current_reviewer_level = get_next_hierarchy_level(&arg1.chain_of_command, arg0.current_reviewer_level);
        };
        arg0.last_updated = 0x2::clock::timestamp_ms(arg3);
        let v4 = DocumentApproved{
            submission_id   : 0x2::object::id<DocumentSubmission>(arg0),
            reviewer        : v0,
            hierarchy_level : v1.hierarchy_level,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DocumentApproved>(v4);
    }

    public fun create_chain_participant(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String) : ChainParticipant {
        ChainParticipant{
            address         : arg0,
            name            : arg1,
            hierarchy_level : arg2,
            role            : arg3,
        }
    }

    public fun create_document_flow(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: vector<ChainParticipant>, arg2: &0x2::clock::Clock, arg3: &mut DocumentFlowRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::ProfileRegistry, arg5: &mut 0x2::tx_context::TxContext) : FlowManagerCap {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_assignee(arg0);
        let v2 = if (v1 == 0x1::string::utf8(b"self")) {
            v0
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_address_from_x(arg4, v1)
        };
        assert!(v2 == 0x2::tx_context::sender(arg5) || v0 == 0x2::tx_context::sender(arg5), 100);
        validate_chain_hierarchy(&arg1);
        let v3 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        let v4 = DocumentFlow{
            id               : 0x2::object::new(arg5),
            event_id         : v3,
            organizer        : v0,
            chain_of_command : arg1,
            is_active        : true,
            created_at       : 0x2::clock::timestamp_ms(arg2),
        };
        let v5 = 0x2::object::id<DocumentFlow>(&v4);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg3.flows_by_event, v3, v5);
        0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg3.submissions_by_event, v3, 0x1::vector::empty<0x2::object::ID>());
        let v6 = DocumentFlowCreated{
            flow_id    : v5,
            event_id   : v3,
            organizer  : v0,
            chain_size : 0x1::vector::length<ChainParticipant>(&arg1),
        };
        0x2::event::emit<DocumentFlowCreated>(v6);
        0x2::transfer::share_object<DocumentFlow>(v4);
        FlowManagerCap{
            id      : 0x2::object::new(arg5),
            flow_id : v5,
        }
    }

    public fun fund_directly(arg0: &mut DocumentSubmission, arg1: address, arg2: &DocumentFlow, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.state == 1, 102);
        let v1 = get_participant_at_level(&arg2.chain_of_command, get_highest_hierarchy_level(&arg2.chain_of_command));
        assert!(v1.address == v0, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        arg0.state = 3;
        arg0.last_updated = 0x2::clock::timestamp_ms(arg4);
        let v2 = BudgetReleased{
            submission_id : 0x2::object::id<DocumentSubmission>(arg0),
            organizer     : arg0.organizer,
            amount        : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            funded_by     : v0,
        };
        0x2::event::emit<BudgetReleased>(v2);
    }

    public fun get_approval_history(arg0: &DocumentSubmission) : &vector<ApprovalRecord> {
        &arg0.approval_history
    }

    public fun get_chain_participants(arg0: &DocumentFlow) : &vector<ChainParticipant> {
        &arg0.chain_of_command
    }

    public fun get_current_reviewer_level(arg0: &DocumentSubmission) : u64 {
        arg0.current_reviewer_level
    }

    public fun get_document_uri(arg0: &DocumentSubmission) : 0x1::string::String {
        arg0.document_uri
    }

    fun get_highest_hierarchy_level(arg0: &vector<ChainParticipant>) : u64 {
        let v0 = 0x1::vector::borrow<ChainParticipant>(arg0, 0).hierarchy_level;
        let v1 = 1;
        while (v1 < 0x1::vector::length<ChainParticipant>(arg0)) {
            let v2 = 0x1::vector::borrow<ChainParticipant>(arg0, v1).hierarchy_level;
            if (v2 > v0) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_lowest_hierarchy_level(arg0: &vector<ChainParticipant>) : u64 {
        let v0 = 0x1::vector::borrow<ChainParticipant>(arg0, 0).hierarchy_level;
        let v1 = 1;
        while (v1 < 0x1::vector::length<ChainParticipant>(arg0)) {
            let v2 = 0x1::vector::borrow<ChainParticipant>(arg0, v1).hierarchy_level;
            if (v2 < v0) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_next_hierarchy_level(arg0: &vector<ChainParticipant>, arg1: u64) : u64 {
        let v0 = get_highest_hierarchy_level(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ChainParticipant>(arg0)) {
            let v2 = 0x1::vector::borrow<ChainParticipant>(arg0, v1);
            if (v2.hierarchy_level > arg1 && v2.hierarchy_level < v0) {
                v0 = v2.hierarchy_level;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_participant_address(arg0: &ChainParticipant) : address {
        arg0.address
    }

    fun get_participant_at_level(arg0: &vector<ChainParticipant>, arg1: u64) : ChainParticipant {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ChainParticipant>(arg0)) {
            let v1 = 0x1::vector::borrow<ChainParticipant>(arg0, v0);
            if (v1.hierarchy_level == arg1) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 101
    }

    public fun get_participant_details(arg0: &ChainParticipant) : (address, 0x1::string::String, u64, 0x1::string::String) {
        (arg0.address, arg0.name, arg0.hierarchy_level, arg0.role)
    }

    public fun get_participant_hierarchy_level(arg0: &ChainParticipant) : u64 {
        arg0.hierarchy_level
    }

    public fun get_participant_name(arg0: &ChainParticipant) : 0x1::string::String {
        arg0.name
    }

    public fun get_participant_role(arg0: &ChainParticipant) : 0x1::string::String {
        arg0.role
    }

    fun get_previous_hierarchy_level(arg0: &vector<ChainParticipant>, arg1: u64) : u64 {
        let v0 = get_lowest_hierarchy_level(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ChainParticipant>(arg0)) {
            let v2 = 0x1::vector::borrow<ChainParticipant>(arg0, v1);
            if (v2.hierarchy_level < arg1 && v2.hierarchy_level > v0) {
                v0 = v2.hierarchy_level;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_submission_state(arg0: &DocumentSubmission) : u8 {
        arg0.state
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DocumentFlowRegistry{
            id                   : 0x2::object::new(arg0),
            flows_by_event       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            submissions_by_event : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            submissions_by_user  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<DocumentFlowRegistry>(v0);
    }

    public fun is_user_current_reviewer(arg0: &DocumentSubmission, arg1: &DocumentFlow, arg2: address) : bool {
        if (arg0.state != 0) {
            return false
        };
        let v0 = get_participant_at_level(&arg1.chain_of_command, arg0.current_reviewer_level);
        v0.address == arg2
    }

    public fun reject_document(arg0: &mut DocumentSubmission, arg1: &DocumentFlow, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 0, 102);
        let v1 = get_participant_at_level(&arg1.chain_of_command, arg0.current_reviewer_level);
        assert!(v1.address == v0, 103);
        let v2 = ApprovalRecord{
            reviewer        : v0,
            reviewer_name   : v1.name,
            hierarchy_level : arg0.current_reviewer_level,
            action          : 2,
            comments        : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::vector::push_back<ApprovalRecord>(&mut arg0.approval_history, v2);
        if (arg0.current_reviewer_level == get_lowest_hierarchy_level(&arg1.chain_of_command)) {
            arg0.state = 2;
        } else {
            arg0.current_reviewer_level = get_previous_hierarchy_level(&arg1.chain_of_command, arg0.current_reviewer_level);
        };
        arg0.last_updated = 0x2::clock::timestamp_ms(arg3);
        let v3 = DocumentRejected{
            submission_id   : 0x2::object::id<DocumentSubmission>(arg0),
            reviewer        : v0,
            hierarchy_level : v1.hierarchy_level,
            reason          : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DocumentRejected>(v3);
    }

    public fun submit_document(arg0: &DocumentFlow, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut DocumentFlowRegistry, arg8: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::ProfileRegistry, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg1);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_assignee(arg1);
        let v2 = if (v1 == 0x1::string::utf8(b"self")) {
            v0
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_address_from_x(arg8, v1)
        };
        assert!(v2 == 0x2::tx_context::sender(arg9) || v0 == 0x2::tx_context::sender(arg9), 100);
        assert!(arg0.is_active, 100);
        let v3 = DocumentSubmission{
            id                     : 0x2::object::new(arg9),
            flow_id                : 0x2::object::id<DocumentFlow>(arg0),
            event_id               : arg0.event_id,
            organizer              : arg0.organizer,
            title                  : arg2,
            description            : arg3,
            document_uri           : arg4,
            document_type          : arg5,
            current_reviewer_level : get_lowest_hierarchy_level(&arg0.chain_of_command),
            state                  : 0,
            approval_history       : 0x1::vector::empty<ApprovalRecord>(),
            submitted_at           : 0x2::clock::timestamp_ms(arg6),
            last_updated           : 0x2::clock::timestamp_ms(arg6),
        };
        let v4 = 0x2::object::id<DocumentSubmission>(&v3);
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg7.submissions_by_event, arg0.event_id), v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg7.submissions_by_user, arg0.organizer)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg7.submissions_by_user, arg0.organizer, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg7.submissions_by_user, arg0.organizer), v4);
        let v5 = DocumentSubmitted{
            submission_id : v4,
            flow_id       : 0x2::object::id<DocumentFlow>(arg0),
            event_id      : arg0.event_id,
            organizer     : arg0.organizer,
            title         : v3.title,
        };
        0x2::event::emit<DocumentSubmitted>(v5);
        0x2::transfer::share_object<DocumentSubmission>(v3);
        v4
    }

    fun validate_chain_hierarchy(arg0: &vector<ChainParticipant>) {
        let v0 = 0x1::vector::length<ChainParticipant>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<ChainParticipant>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2.hierarchy_level != 0x1::vector::borrow<ChainParticipant>(arg0, v3).hierarchy_level, 101);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

