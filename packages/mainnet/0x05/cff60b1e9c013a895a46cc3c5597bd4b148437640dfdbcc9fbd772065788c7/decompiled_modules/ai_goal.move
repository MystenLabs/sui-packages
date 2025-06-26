module 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::ai_goal {
    struct GoalManager has key {
        id: 0x2::object::UID,
        goals: 0x2::table::Table<u64, Goal>,
        goal_2_agent: 0x2::table::Table<u64, 0x1::string::String>,
        user_goals: 0x2::table::Table<address, vector<u64>>,
        witness_goals: 0x2::table::Table<address, vector<u64>>,
        goal_count: u64,
        active_goals: vector<u64>,
        failed_goals: vector<u64>,
        completed_goals: vector<u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Goal has store {
        id: u64,
        title: 0x1::string::String,
        ai_suggestion: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        amount: u64,
        status: u8,
        created_at: u64,
        deadline: u64,
        witnesses: vector<address>,
        confirmations: vector<address>,
        comment_counter: u64,
        comments: 0x2::table::Table<u64, Comment>,
        progress_percentage: u64,
        progress_update_counter: u64,
        progress_updates: 0x2::table::Table<u64, ProgressUpdate>,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        agent_name: 0x1::string::String,
        charactor_json: 0x1::string::String,
    }

    struct Comment has store {
        id: u64,
        content: 0x1::string::String,
        creator: address,
        created_at: u64,
    }

    struct ProgressUpdate has store {
        id: u64,
        content: 0x1::string::String,
        proof_file_blob_id: 0x1::string::String,
        creator: address,
        created_at: u64,
    }

    struct EventGoalCreated has copy, drop {
        goal_id: u64,
        creator: address,
        title: 0x1::string::String,
        witnesses: vector<address>,
    }

    struct EventGoalCompleted has copy, drop {
        goal_id: u64,
        completer: address,
    }

    struct EventWitnessConfirmed has copy, drop {
        goal_id: u64,
        witness: address,
    }

    struct EventGoalFailed has copy, drop {
        goal_id: u64,
        failer: address,
    }

    struct CreateAgentEvent has copy, drop, store {
        agent_id: 0x1::string::String,
        agent_name: 0x1::string::String,
        charactor_json: 0x1::string::String,
    }

    struct UpdateAgentEvent has copy, drop, store {
        agent_id: 0x1::string::String,
        charactor_json: 0x1::string::String,
    }

    struct CommentCreatedEvent has copy, drop {
        goal_id: u64,
        comment_id: u64,
        creator: address,
        content: 0x1::string::String,
    }

    struct ProgressUpdateEvent has copy, drop {
        goal_id: u64,
        update_id: u64,
        creator: address,
        content: 0x1::string::String,
        progress_percentage: u64,
        proof_file_blob_id: 0x1::string::String,
    }

    public entry fun complete_goal(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Goal>(&mut arg0.goals, arg2);
        assert!(v0.status == 0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0.creator == v1, 9);
        assert!(0x1::vector::length<address>(&v0.witnesses) == 0x1::vector::length<address>(&v0.confirmations), 6);
        v0.status = 1;
        let (v2, v3) = 0x1::vector::index_of<u64>(&arg0.active_goals, &arg2);
        if (v2) {
            0x1::vector::remove<u64>(&mut arg0.active_goals, v3);
        };
        0x1::vector::push_back<u64>(&mut arg0.completed_goals, arg2);
        let v4 = EventGoalCompleted{
            goal_id   : arg2,
            completer : v1,
        };
        0x2::event::emit<EventGoalCompleted>(v4);
        v0.progress_percentage = 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0.amount, arg3), v1);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 100000, b"complete_goal", arg3);
    }

    public entry fun confirm_witness(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Goal>(&mut arg0.goals, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&v0.witnesses, &v1), 4);
        assert!(!0x1::vector::contains<address>(&v0.confirmations, &v1), 5);
        0x1::vector::push_back<address>(&mut v0.confirmations, v1);
        let v2 = EventWitnessConfirmed{
            goal_id : arg2,
            witness : v1,
        };
        0x2::event::emit<EventWitnessConfirmed>(v2);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 50000, b"confirm_witness", arg3);
    }

    public fun create_agent(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg3) == 36, 10);
        assert!(0x1::string::length(&arg4) >= 1, 11);
        assert!(0x1::string::length(&arg5) >= 20, 12);
        assert!(!0x2::table::contains<u64, 0x1::string::String>(&arg0.goal_2_agent, arg2), 13);
        0x2::table::add<u64, 0x1::string::String>(&mut arg0.goal_2_agent, arg2, arg3);
        let v0 = Agent{
            id             : 0x2::object::new(arg6),
            agent_id       : arg3,
            agent_name     : arg4,
            charactor_json : arg5,
        };
        let v1 = CreateAgentEvent{
            agent_id       : arg3,
            agent_name     : arg4,
            charactor_json : arg5,
        };
        0x2::event::emit<CreateAgentEvent>(v1);
        0x2::dynamic_object_field::add<0x1::string::String, Agent>(&mut arg0.id, arg3, v0);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 200000, b"create_agent", arg6);
    }

    public entry fun create_comment(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Goal>(&mut arg0.goals, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = v0.comment_counter;
        let v3 = Comment{
            id         : v2,
            content    : 0x1::string::utf8(arg3),
            creator    : v1,
            created_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<u64, Comment>(&mut v0.comments, v2, v3);
        v0.comment_counter = v0.comment_counter + 1;
        let v4 = CommentCreatedEvent{
            goal_id    : arg2,
            comment_id : v2,
            creator    : v1,
            content    : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<CommentCreatedEvent>(v4);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 10000, b"create_comment", arg5);
    }

    public entry fun create_goal(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<address>, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 > v0, 0);
        assert!(!0x1::vector::is_empty<address>(&arg6), 3);
        let v1 = arg0.goal_count;
        let v2 = 0x2::tx_context::sender(arg10);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= arg7, 16);
        let v3 = Goal{
            id                      : v1,
            title                   : 0x1::string::utf8(arg2),
            ai_suggestion           : 0x1::string::utf8(arg4),
            description             : 0x1::string::utf8(arg3),
            creator                 : v2,
            amount                  : arg7,
            status                  : 0,
            created_at              : v0,
            deadline                : arg5,
            witnesses               : arg6,
            confirmations           : 0x1::vector::empty<address>(),
            comment_counter         : 0,
            comments                : 0x2::table::new<u64, Comment>(arg10),
            progress_percentage     : 0,
            progress_update_counter : 0,
            progress_updates        : 0x2::table::new<u64, ProgressUpdate>(arg10),
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg8, arg7, arg10));
        0x2::table::add<u64, Goal>(&mut arg0.goals, v1, v3);
        0x1::vector::push_back<u64>(&mut arg0.active_goals, v1);
        arg0.goal_count = arg0.goal_count + 1;
        if (!0x2::table::contains<address, vector<u64>>(&arg0.user_goals, v2)) {
            0x2::table::add<address, vector<u64>>(&mut arg0.user_goals, v2, 0x1::vector::empty<u64>());
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_goals, v2), v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg6)) {
            let v5 = *0x1::vector::borrow<address>(&arg6, v4);
            if (!0x2::table::contains<address, vector<u64>>(&arg0.witness_goals, v5)) {
                0x2::table::add<address, vector<u64>>(&mut arg0.witness_goals, v5, 0x1::vector::empty<u64>());
            };
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.witness_goals, v5), v1);
            v4 = v4 + 1;
        };
        let v6 = EventGoalCreated{
            goal_id   : v1,
            creator   : 0x2::tx_context::sender(arg10),
            title     : 0x1::string::utf8(arg2),
            witnesses : arg6,
        };
        0x2::event::emit<EventGoalCreated>(v6);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 100000, b"create_goal", arg10);
    }

    public entry fun fail_goal(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Goal>(&mut arg0.goals, arg2);
        assert!(v0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.deadline, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = if (!0x1::vector::contains<address>(&v0.witnesses, &v1)) {
            if (!0x1::vector::contains<address>(&v0.confirmations, &v1)) {
                v0.creator != v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 7);
        let v3 = 0x1::vector::length<address>(&v0.witnesses);
        assert!(v3 != 0x1::vector::length<address>(&v0.confirmations), 8);
        v0.status = 2;
        0x1::vector::push_back<u64>(&mut arg0.failed_goals, arg2);
        let (v4, v5) = 0x1::vector::index_of<u64>(&arg0.active_goals, &arg2);
        if (v4) {
            0x1::vector::remove<u64>(&mut arg0.active_goals, v5);
        };
        let v6 = EventGoalFailed{
            goal_id : arg2,
            failer  : v1,
        };
        0x2::event::emit<EventGoalFailed>(v6);
        let v7 = 0;
        while (v7 < v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0.amount / v3, arg4), *0x1::vector::borrow<address>(&v0.witnesses, v7));
            v7 = v7 + 1;
        };
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 100000, b"fail_goal", arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GoalManager{
            id              : 0x2::object::new(arg0),
            goals           : 0x2::table::new<u64, Goal>(arg0),
            goal_2_agent    : 0x2::table::new<u64, 0x1::string::String>(arg0),
            user_goals      : 0x2::table::new<address, vector<u64>>(arg0),
            witness_goals   : 0x2::table::new<address, vector<u64>>(arg0),
            goal_count      : 0,
            active_goals    : 0x1::vector::empty<u64>(),
            failed_goals    : 0x1::vector::empty<u64>(),
            completed_goals : 0x1::vector::empty<u64>(),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GoalManager>(v0);
    }

    public fun update_agent(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg3) >= 20, 12);
        let v0 = 0x2::table::borrow<u64, 0x1::string::String>(&arg0.goal_2_agent, arg2);
        assert!(0x1::string::length(v0) == 36, 14);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Agent>(&mut arg0.id, *v0).charactor_json = arg3;
        let v1 = UpdateAgentEvent{
            agent_id       : *v0,
            charactor_json : arg3,
        };
        0x2::event::emit<UpdateAgentEvent>(v1);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 100000, b"update_agent", arg4);
    }

    public entry fun update_progress(arg0: &mut GoalManager, arg1: &mut 0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::Vault, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Goal>(&mut arg0.goals, arg2);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(v0.creator == v1, 9);
        assert!(v0.status == 0, 1);
        let v2 = if (arg4 > 0) {
            if (arg4 >= v0.progress_percentage) {
                arg4 <= 100
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 15);
        let v3 = v0.progress_update_counter;
        let v4 = ProgressUpdate{
            id                 : v3,
            content            : 0x1::string::utf8(arg3),
            proof_file_blob_id : 0x1::string::utf8(arg5),
            creator            : v1,
            created_at         : 0x2::clock::timestamp_ms(arg6),
        };
        v0.progress_percentage = arg4;
        0x2::table::add<u64, ProgressUpdate>(&mut v0.progress_updates, v3, v4);
        v0.progress_update_counter = v0.progress_update_counter + 1;
        let v5 = ProgressUpdateEvent{
            goal_id             : arg2,
            update_id           : v3,
            creator             : v1,
            content             : 0x1::string::utf8(arg3),
            progress_percentage : arg4,
            proof_file_blob_id  : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<ProgressUpdateEvent>(v5);
        0x5cff60b1e9c013a895a46cc3c5597bd4b148437640dfdbcc9fbd772065788c7::aig_token::airdrop(arg1, 10000, b"update_progress", arg7);
    }

    // decompiled from Move bytecode v6
}

