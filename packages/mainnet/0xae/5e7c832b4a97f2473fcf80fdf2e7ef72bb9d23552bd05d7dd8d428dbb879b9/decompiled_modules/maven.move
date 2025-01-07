module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::maven {
    struct Maven has key {
        id: 0x2::object::UID,
        version: u64,
        info: Info,
        role_book: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook,
        permission_book: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook,
        order_book: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::OrderBook,
        order_book_timelock: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::TimelockOrderBook,
        vault: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::Vault,
    }

    struct Info has store {
        name: 0x1::ascii::String,
        uri: 0x1::ascii::String,
    }

    struct MavenCreateEvent has copy, drop {
        maven: 0x2::object::ID,
        name: 0x1::ascii::String,
        creator: address,
    }

    struct NewProposalEvent has copy, drop {
        maven: 0x2::object::ID,
        sn: u64,
        proposer: address,
        op_type_vec: vector<u64>,
        op_data_vec: vector<vector<u8>>,
    }

    struct VoteProposalEvent has copy, drop {
        maven: 0x2::object::ID,
        sn: u64,
        voter: address,
        approve: bool,
    }

    struct ExecuteProposalEvent has copy, drop {
        maven: 0x2::object::ID,
        sn: u64,
        success: bool,
        error_codes: vector<u64>,
    }

    struct SkipProposalEvent has copy, drop {
        maven: 0x2::object::ID,
        sn: u64,
    }

    struct UpdateMetaInfoEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::ascii::String,
        uri: 0x1::ascii::String,
    }

    struct ProposeTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
        proposer: address,
        op_type_vec: vector<u64>,
        op_data_vec: vector<vector<u8>>,
    }

    struct VoteTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
        voter: address,
        approve: bool,
    }

    struct StartTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
    }

    struct SkipTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
    }

    struct ExecuteTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
    }

    struct ExpirelTimelockEvent has copy, drop {
        maven: 0x2::object::ID,
        op_id: u64,
    }

    public entry fun create(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = create_maven(arg1, arg2, v0, arg6);
        if (0x1::vector::length<u64>(&arg3) > 0 || 0x1::vector::length<vector<u8>>(&arg4) > 0) {
            let v2 = &mut v1;
            execute_init_operation(arg0, v2, arg3, arg4, arg5, arg6);
        };
        let v3 = MavenCreateEvent{
            maven   : 0x2::object::id<Maven>(&v1),
            name    : arg1,
            creator : v0,
        };
        0x2::event::emit<MavenCreateEvent>(v3);
        0x2::transfer::share_object<Maven>(v1);
    }

    fun create_maven(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Maven {
        let v0 = Info{
            name : arg0,
            uri  : arg1,
        };
        let v1 = Maven{
            id                  : 0x2::object::new(arg3),
            version             : 0,
            info                : v0,
            role_book           : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::new_role_book(arg2, arg3),
            permission_book     : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::new_permission_book(arg3),
            order_book          : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::new_order_book(arg3),
            order_book_timelock : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::new_timelock_order_book(arg3),
            vault               : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::new(arg3),
        };
        validate_info(&v1.info);
        let v2 = &mut v1;
        init_maven(v2);
        v1
    }

    public entry fun deposit_coin<T0>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: 0x2::coin::Coin<T0>) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::deposit_coin<T0>(&mut arg1.vault, arg2);
    }

    public entry fun deposit_object<T0: store + key>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: T0) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::deposit_object<T0>(&mut arg1.vault, arg2);
    }

    public entry fun execute_admin_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let v1 = &mut v0;
        let (v2, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg1.order_book);
        let v4 = v2;
        validate_admin_order(arg1, &v4, v1);
        let v5 = 0;
        while (v5 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(&v4)) {
            let v6 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation(&v4, v5);
            v5 = v5 + 1;
            execute_admin_operation_internal(arg1, v6, v1, arg2, arg3);
        };
        let v7 = ExecuteProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : v3,
            success     : true,
            error_codes : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ExecuteProposalEvent>(v7);
    }

    fun execute_admin_operation_internal(arg0: &mut Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_role_range_operation(v0)) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::execute(&mut arg0.role_book, arg1, arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_permission_range_operation(v0)) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::execute_permission_operation(&mut arg0.permission_book, &mut arg0.role_book, arg1, arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_policy_range_operation(v0)) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::execute_policy_operation(&mut arg0.permission_book, arg1, arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_allowlist_range_operation(v0)) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_allowlist(&mut arg0.vault, arg1);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_spending_limit_range_operation(v0)) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_spending_limit(&mut arg0.vault, arg1, arg3, arg4);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_meta_info_range_operation(v0)) {
            execute_meta_info(arg0, arg1);
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_timelock_config_range_opertaion(v0), 1005);
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::execute_timelock_config_operation(&mut arg0.permission_book, arg1, arg2);
        };
    }

    public entry fun execute_coin_operation<T0>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let v1 = &mut v0;
        let (v2, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg1.order_book);
        let v4 = v2;
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(&v4) == 1, 1009);
        let v5 = 0x2::vec_set::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v6 = &mut v5;
        let v7 = get_approved_operation(&v4, 0, &arg1.role_book, &arg1.permission_book, v1, v6);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(&v7), 1007);
        let (v8, v9) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_coin_precheck<T0>(&arg1.vault, &v7);
        if (v8) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_coin<T0>(&mut arg1.vault, &v7, arg2);
        };
        let v10 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v10, v9);
        let v11 = ExecuteProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : v3,
            success     : v8,
            error_codes : v10,
        };
        0x2::event::emit<ExecuteProposalEvent>(v11);
    }

    public entry fun execute_coin_to_maven_vault_operation<T0>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: &mut Maven, arg3: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let v1 = &mut v0;
        let (v2, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg1.order_book);
        let v4 = v2;
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(&v4) == 1, 1009);
        let v5 = 0x2::vec_set::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v6 = &mut v5;
        let v7 = get_approved_operation(&v4, 0, &arg1.role_book, &arg1.permission_book, v1, v6);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(&v7), 1007);
        let (v8, v9) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_coin_precheck<T0>(&arg1.vault, &v7);
        if (v8) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_coin_to_maven_vault<T0>(&mut arg1.vault, &v7, 0x2::object::id<Maven>(arg2), &mut arg2.vault, arg3);
        };
        let v10 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v10, v9);
        let v11 = ExecuteProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : v3,
            success     : v8,
            error_codes : v10,
        };
        0x2::event::emit<ExecuteProposalEvent>(v11);
    }

    fun execute_init_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        propose(arg0, arg1, arg2, arg3, arg5);
        vote_approve(arg0, arg1, 0, arg5);
        execute_admin_operation(arg0, arg1, arg4, arg5);
    }

    fun execute_meta_info(arg0: &mut Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_meta_info(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1012);
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_meta_info_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_meta_info(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        update_meta_info(arg0, v0, v1);
    }

    public entry fun execute_object_operation<T0: store + key>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let (v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg1.order_book);
        let v3 = v1;
        let (v4, v5) = precheck_and_validate_object_order(arg1, &v3, &mut v0);
        if (v5) {
            let v6 = 0;
            while (v6 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(&v3)) {
                0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_object<T0>(&mut arg1.vault, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation(&v3, v6));
                v6 = v6 + 1;
            };
        };
        let v7 = ExecuteProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : v2,
            success     : v5,
            error_codes : v4,
        };
        0x2::event::emit<ExecuteProposalEvent>(v7);
    }

    public entry fun execute_object_to_maven_vault_operation<T0: store + key>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: &mut Maven) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let (v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg1.order_book);
        let v3 = v1;
        let (v4, v5) = precheck_and_validate_object_order(arg1, &v3, &mut v0);
        if (v5) {
            let v6 = 0;
            while (v6 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(&v3)) {
                0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_object_transfer_to_maven_vault<T0>(&mut arg1.vault, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation(&v3, v6), 0x2::object::id<Maven>(arg2), &mut arg2.vault);
                v6 = v6 + 1;
            };
        };
        let v7 = ExecuteProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : v2,
            success     : v5,
            error_codes : v4,
        };
        0x2::event::emit<ExecuteProposalEvent>(v7);
    }

    public entry fun execute_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0x2::object::id<Maven>(arg1);
        let v1 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(v0);
        let v2 = &mut v1;
        let v3 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::pop_executable_order(&mut arg1.order_book_timelock, arg2, arg3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v3)) {
            let v5 = 0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v3, v4);
            v4 = v4 + 1;
            if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(v5)) {
                execute_admin_operation_internal(arg1, v5, v2, arg3, arg4);
                continue
            };
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_recovery_operation(v5), 1014);
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::execute_recovery_operation(&mut arg1.permission_book, v5, v2);
        };
        let v6 = ExecuteTimelockEvent{
            maven : v0,
            op_id : arg2,
        };
        0x2::event::emit<ExecuteTimelockEvent>(v6);
    }

    public entry fun expire_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::clock::Clock) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::pop_expired_order(&mut arg1.order_book_timelock, arg2, arg3);
        let v0 = ExpirelTimelockEvent{
            maven : 0x2::object::id<Maven>(arg1),
            op_id : arg2,
        };
        0x2::event::emit<ExpirelTimelockEvent>(v0);
    }

    fun get_approved_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg1: u64, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext, arg5: &mut 0x2::vec_set::VecSet<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation {
        let (v0, v1, v2) = get_operation_and_permission(arg0, arg1, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        if (0x2::vec_set::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg5, &v4)) {
            return v0
        };
        let (v5, _) = result_of_permission(arg0, &v3, arg2);
        assert!(v5, 1004);
        0x2::vec_set::insert<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg5, v4);
        v0
    }

    public fun get_last_order_sn(arg0: &Maven) : u64 {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_last_sn(&arg0.order_book)
    }

    public fun get_last_timelock_order_id(arg0: &Maven) : u64 {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::get_last_id(&arg0.order_book_timelock)
    }

    fun get_operation_and_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg1: u64, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation(arg0, arg1);
        let (v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::get_permission_by_operation(arg2, v0, arg3);
        (*v0, v1, *v2)
    }

    public fun get_order_book_rd(arg0: &Maven) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::OrderBook {
        &arg0.order_book
    }

    public fun get_order_book_timelock_rd(arg0: &Maven) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::TimelockOrderBook {
        &arg0.order_book_timelock
    }

    public fun get_permission_book_rd(arg0: &Maven) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook {
        &arg0.permission_book
    }

    public fun get_permissions_by_operations(arg0: &Maven, arg1: vector<u64>, arg2: vector<vector<u8>>) : (vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>, vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission>) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg0));
        let v1 = &mut v0;
        let v2 = get_permission_book_rd(arg0);
        let v3 = 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v4 = 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg1)) {
            let v6 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::new_operation(*0x1::vector::borrow<u64>(&arg1, v5), *0x1::vector::borrow<vector<u8>>(&arg2, v5));
            let (v7, v8) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::get_permission_by_operation(v2, &v6, v1);
            0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut v3, v7);
            0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission>(&mut v4, *v8);
            v5 = v5 + 1;
        };
        (v3, v4)
    }

    public fun get_role_book_rd(arg0: &Maven) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook {
        &arg0.role_book
    }

    public fun get_vault_rd(arg0: &Maven) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::Vault {
        &arg0.vault
    }

    fun has_propose_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook, arg2: address, arg3: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : bool {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer(arg0, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&arg3)) {
            let v2 = *0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&arg3, v1);
            v1 = v1 + 1;
            let (_, v4) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::get_permission_by_operation(arg1, &v2, arg4);
            if (!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_propose_permission(v4, v0)) {
                return false
            };
        };
        true
    }

    fun has_vote_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook, arg2: address, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : bool {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer(arg0, arg2);
        let v1 = 0;
        while (v1 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(arg3)) {
            let (_, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::get_permission_by_operation(arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation(arg3, v1), arg4);
            if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_approve_permission(v3, v0)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun init_maven(arg0: &mut Maven) {
        let v0 = &mut arg0.permission_book;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::create_reserved_permission(v0, &mut arg0.role_book);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::init_default_policy(v0);
    }

    fun is_rejected_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg1: u64, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::PermissionBook, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext, arg5: &mut 0x2::vec_set::VecSet<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) : bool {
        let (_, v1, v2) = get_operation_and_permission(arg0, arg1, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        if (0x2::vec_set::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg5, &v4)) {
            return false
        };
        let (_, v6) = result_of_permission(arg0, &v3, arg2);
        if (!v6) {
            0x2::vec_set::insert<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg5, v4);
        };
        v6
    }

    fun is_rejected_order(arg0: &Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : bool {
        let v0 = 0x2::vec_set::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v1 = 0;
        while (v1 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(arg1)) {
            let v2 = &mut v0;
            if (is_rejected_operation(arg1, v1, &arg0.role_book, &arg0.permission_book, arg2, v2)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun precheck_and_validate_object_order(arg0: &Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : (vector<u64>, bool) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = true;
        let v2 = 0x2::vec_set::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v3 = 0x2::vec_set::empty<0x2::object::ID>();
        let v4 = 0;
        while (v4 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(arg1) && v1) {
            let v5 = &mut v2;
            let v6 = get_approved_operation(arg1, v4, &arg0.role_book, &arg0.permission_book, arg2, v5);
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_object_operation(&v6), 1008);
            let (v7, v8) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::execute_object_precheck(&arg0.vault, &v6, &mut v3);
            v1 = v1 && v7;
            0x1::vector::push_back<u64>(&mut v0, v8);
            v4 = v4 + 1;
        };
        (v0, v1)
    }

    public entry fun propose(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        let v1 = &mut v0;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = &mut arg1.order_book;
        let v4 = &arg1.role_book;
        let v5 = &arg1.permission_book;
        let v6 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::new_valid_operations(arg2, arg3, v1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v6, 0))) {
            assert!(0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v6) == 1, 1010);
        };
        assert!(has_propose_permission(v4, v5, v2, v6, v1), 1000);
        let v7 = NewProposalEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            sn          : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::add_order(v3, v6, v2),
            proposer    : v2,
            op_type_vec : arg2,
            op_data_vec : arg3,
        };
        0x2::event::emit<NewProposalEvent>(v7);
    }

    public entry fun propose_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(0x2::object::id<Maven>(arg1));
        let v1 = &mut v0;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = &arg1.role_book;
        let v4 = &arg1.permission_book;
        let v5 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::new_valid_operations(arg2, arg3, v1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_recovery_operation(0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v5, 0))) {
            assert!(0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(&v5) == 1, 1011);
        };
        assert!(has_propose_permission(v3, v4, v2, v5, v1), 1000);
        let (v6, v7) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::get_timelock_config(v4);
        let v8 = ProposeTimelockEvent{
            maven       : 0x2::object::id<Maven>(arg1),
            op_id       : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::init_timelock_order(&mut arg1.order_book_timelock, v5, v2, v6, v7),
            proposer    : v2,
            op_type_vec : arg2,
            op_data_vec : arg3,
        };
        0x2::event::emit<ProposeTimelockEvent>(v8);
    }

    fun result_of_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook) : (bool, bool) {
        let (v0, v1) = weight_of_permission(arg2, arg0, arg1);
        let v2 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_enough_weight(arg2, arg1, v0);
        let v3 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_enough_weight(arg2, arg1, v1);
        assert!(v2 || v3, 1002);
        (v2, v3)
    }

    fun skip_rejected_operation(arg0: &mut Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::pop_min_order(&mut arg0.order_book);
        let v2 = v0;
        assert!(is_rejected_order(arg0, &v2, arg1), 1003);
        let v3 = SkipProposalEvent{
            maven : 0x2::object::id<Maven>(arg0),
            sn    : v1,
        };
        0x2::event::emit<SkipProposalEvent>(v3);
    }

    public entry fun skip_rejected_operations(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        while (arg2 > 0) {
            skip_rejected_operation(arg1, &v0);
            arg2 = arg2 - 1;
        };
    }

    public entry fun skip_rejected_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(0x2::object::id<Maven>(arg1));
        assert!(is_rejected_order(arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::get_order(&arg1.order_book_timelock, arg2), &mut v0), 1003);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::remove_timelock_order(&mut arg1.order_book_timelock, arg2);
        let v1 = SkipTimelockEvent{
            maven : 0x2::object::id<Maven>(arg1),
            op_id : arg2,
        };
        0x2::event::emit<SkipTimelockEvent>(v1);
    }

    public entry fun spend_limit<T0>(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault::spend<T0>(&mut arg1.vault, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun start_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::clock::Clock) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(0x2::object::id<Maven>(arg1));
        validate_admin_order(arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::get_order(&arg1.order_book_timelock, arg2), &mut v0);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::start_timelock_order(&mut arg1.order_book_timelock, arg2, arg3);
        let v1 = StartTimelockEvent{
            maven : 0x2::object::id<Maven>(arg1),
            op_id : arg2,
        };
        0x2::event::emit<StartTimelockEvent>(v1);
    }

    fun update_meta_info(arg0: &mut Maven, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        arg0.info.name = arg1;
        arg0.info.uri = arg2;
        validate_info(&arg0.info);
        let v0 = UpdateMetaInfoEvent{
            id   : 0x2::object::id<Maven>(arg0),
            name : arg1,
            uri  : arg2,
        };
        0x2::event::emit<UpdateMetaInfoEvent>(v0);
    }

    fun valid_proposer(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission, arg2: address) : bool {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::exists_signer(arg0, arg2)) {
            return 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_propose_permission(arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer(arg0, arg2))
        };
        false
    }

    fun valid_weight(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission, arg2: vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            v0 = v0 + 1;
            if (!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::exists_signer(arg0, v2)) {
                v1 = v1 - 1;
                continue
            };
            if (!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::has_approve_permission(arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer(arg0, v2))) {
                v1 = v1 - 1;
            };
        };
        v1
    }

    fun validate_admin_order(arg0: &Maven, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let v0 = 0x2::vec_set::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v1 = 0;
        while (v1 < 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operation_count(arg1)) {
            let v2 = &mut v0;
            get_approved_operation(arg1, v1, &arg0.role_book, &arg0.permission_book, arg2, v2);
            v1 = v1 + 1;
        };
    }

    fun validate_info(arg0: &Info) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_name(&arg0.name);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_string(&arg0.uri, 0, 1024);
    }

    fun vote(arg0: &mut Maven, arg1: u64, arg2: address, arg3: bool, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_order_mut(&mut arg0.order_book, arg1);
        assert!(has_vote_permission(&arg0.role_book, &arg0.permission_book, arg2, v0, arg4), 1001);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::vote(v0, arg2, arg3);
        let v1 = VoteProposalEvent{
            maven   : 0x2::object::id<Maven>(arg0),
            sn      : arg1,
            voter   : arg2,
            approve : arg3,
        };
        0x2::event::emit<VoteProposalEvent>(v1);
    }

    public entry fun vote_against(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        vote(arg1, arg2, 0x2::tx_context::sender(arg3), false, &mut v0);
    }

    public entry fun vote_against_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(0x2::object::id<Maven>(arg1));
        vote_timelock(arg1, arg2, 0x2::tx_context::sender(arg3), false, &mut v0);
    }

    public entry fun vote_approve(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_seq_context(0x2::object::id<Maven>(arg1));
        vote(arg1, arg2, 0x2::tx_context::sender(arg3), true, &mut v0);
    }

    public entry fun vote_for_timelock(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::Pause, arg1: &mut Maven, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause::ensure_not_paused(arg0);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::new_timelock_context(0x2::object::id<Maven>(arg1));
        vote_timelock(arg1, arg2, 0x2::tx_context::sender(arg3), true, &mut v0);
    }

    fun vote_timelock(arg0: &mut Maven, arg1: u64, arg2: address, arg3: bool, arg4: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(has_vote_permission(&arg0.role_book, &arg0.permission_book, arg2, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::get_order(&mut arg0.order_book_timelock, arg1), arg4), 1001);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock::vote_timelock_order(&mut arg0.order_book_timelock, arg1, arg2, arg3);
        let v0 = VoteTimelockEvent{
            maven   : 0x2::object::id<Maven>(arg0),
            op_id   : arg1,
            voter   : arg2,
            approve : arg3,
        };
        0x2::event::emit<VoteTimelockEvent>(v0);
    }

    fun weight_of_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission::Permission) : (u64, u64) {
        let (v0, v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::signers_of_order(arg1);
        if (!valid_proposer(arg0, arg2, v0)) {
            return (0, 18446744073709551615)
        };
        (valid_weight(arg0, arg2, v1), valid_weight(arg0, arg2, v2))
    }

    // decompiled from Move bytecode v6
}

