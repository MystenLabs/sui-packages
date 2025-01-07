module 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::auto_invest {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFee has store {
        fee_rate: u64,
        vault: 0x2::bag::Bag,
    }

    struct Investment has store, key {
        id: 0x2::object::UID,
        next_plan_id: u64,
        plans: 0x2::table::Table<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>,
        user_plans: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, bool>>,
        protocol_fee: ProtocolFee,
        custodians: 0x2::bag::Bag,
        executors: 0x2::vec_set::VecSet<address>,
        whitelist_source_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        version: u64,
    }

    struct ExecutionReceipt {
        plan_id: u64,
    }

    struct Deposited has copy, drop, store {
        sender: address,
        amount: u64,
        asset: 0x1::type_name::TypeName,
    }

    struct Withdrawn has copy, drop, store {
        sender: address,
        amount: u64,
        asset: 0x1::type_name::TypeName,
    }

    struct PlanCreated has copy, drop, store {
        plan_id: u64,
        source_asset: 0x1::type_name::TypeName,
        target_asset: 0x1::type_name::TypeName,
        owner: address,
        receiver: address,
        subscription_amount: u64,
        subscription_interval: u64,
        first_execution_time: u64,
        execution_limit: u64,
    }

    struct PlanExecuted has copy, drop, store {
        plan_id: u64,
        executor: address,
        purchased_amount: u64,
        fee_amount: u64,
        execution_count: u64,
        next_execution_time: u64,
    }

    struct PlanRemoved has copy, drop, store {
        plan_id: u64,
        next_execution_time: u64,
        sender: address,
    }

    struct PlanPaused has copy, drop, store {
        plan_id: u64,
        next_execution_time: u64,
        sender: address,
    }

    struct PlanUnpaused has copy, drop, store {
        plan_id: u64,
        next_execution_time: u64,
        sender: address,
    }

    struct SetProtocolFeeRate has copy, drop, store {
        sender: address,
        fee_rate: u64,
    }

    struct CollectProtocolFee has copy, drop, store {
        sender: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ExecutorAdded has copy, drop, store {
        sender: address,
        executor: address,
    }

    struct ExecutorRemoved has copy, drop, store {
        sender: address,
        executor: address,
    }

    struct SourceAssetAllowed has copy, drop, store {
        sender: address,
        asset: 0x1::type_name::TypeName,
    }

    struct SourceAssetDisallowed has copy, drop, store {
        sender: address,
        asset: 0x1::type_name::TypeName,
    }

    public entry fun add_executor(arg0: &AdminCap, arg1: &mut Investment, arg2: address, arg3: &0x2::tx_context::TxContext) {
        if (!0x2::vec_set::contains<address>(&arg1.executors, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.executors, arg2);
            let v0 = ExecutorAdded{
                sender   : 0x2::tx_context::sender(arg3),
                executor : arg2,
            };
            0x2::event::emit<ExecutorAdded>(v0);
        };
    }

    public entry fun allow_source_asset<T0>(arg0: &AdminCap, arg1: &mut Investment, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist_source_assets, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelist_source_assets, v0);
            let v1 = SourceAssetAllowed{
                sender : 0x2::tx_context::sender(arg2),
                asset  : v0,
            };
            0x2::event::emit<SourceAssetAllowed>(v1);
        };
    }

    fun borrow_mut_custodian<T0>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0x2::tx_context::TxContext) : &mut 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::Custodian<T0> {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::Custodian<T0>>(arg0, 0x1::type_name::get<T0>(), 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::new<T0>(arg1));
        };
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::Custodian<T0>>(arg0, 0x1::type_name::get<T0>())
    }

    public fun check_executor(arg0: &Investment, arg1: &address) {
        assert!(0x2::vec_set::contains<address>(&arg0.executors, arg1), 4);
    }

    public fun check_plan_exists(arg0: &Investment, arg1: u64) {
        assert!(plan_exists(arg0, arg1), 5);
    }

    public fun check_valid_source_asset<T0>(arg0: &Investment) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist_source_assets, &v0), 3);
    }

    public fun check_version(arg0: &Investment) {
        assert!(arg0.version == 1, 999);
    }

    public entry fun collect_protocol_fee<T0>(arg0: &AdminCap, arg1: &mut Investment, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x2::math::min(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.protocol_fee.vault, 0x1::type_name::get<T0>())), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.protocol_fee.vault, 0x1::type_name::get<T0>()), v0, arg4), arg3);
        let v1 = CollectProtocolFee{
            sender : 0x2::tx_context::sender(arg4),
            coin   : 0x1::type_name::get<T0>(),
            amount : v0,
        };
        0x2::event::emit<CollectProtocolFee>(v1);
    }

    public fun create_plan<T0, T1>(arg0: &mut Investment, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_valid_source_asset<T0>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(&v0 != &v1, 10);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = 0x1::option::destroy_with_default<u64>(arg3, v3);
        let v5 = 0x1::option::destroy_with_default<u64>(arg4, 0);
        let v6 = 0x1::option::destroy_with_default<address>(arg5, v2);
        assert!(v4 >= v3, 0);
        assert!(arg2 > 0 && arg2 % 60000 == 0, 1);
        assert!(arg1 >= 1000, 2);
        let v7 = arg0.next_plan_id;
        arg0.next_plan_id = arg0.next_plan_id + 1;
        inject_plan(arg0, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::new<T0, T1>(v7, arg1, arg2, v4, v5, v2, v6, v3), v2, arg7);
        let v8 = PlanCreated{
            plan_id               : v7,
            source_asset          : 0x1::type_name::get<T0>(),
            target_asset          : 0x1::type_name::get<T1>(),
            owner                 : v2,
            receiver              : v6,
            subscription_amount   : arg1,
            subscription_interval : arg2,
            first_execution_time  : v4,
            execution_limit       : v5,
        };
        0x2::event::emit<PlanCreated>(v8);
    }

    public fun deposit<T0>(arg0: &mut Investment, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = &mut arg0.custodians;
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::deposit<T0>(borrow_mut_custodian<T0>(v2, arg2), 0x2::coin::into_balance<T0>(arg1), v0);
        let v3 = Deposited{
            sender : v0,
            amount : v1,
            asset  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Deposited>(v3);
    }

    public entry fun disallow_source_asset<T0>(arg0: &AdminCap, arg1: &mut Investment, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist_source_assets, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.whitelist_source_assets, &v0);
            let v1 = SourceAssetDisallowed{
                sender : 0x2::tx_context::sender(arg2),
                asset  : v0,
            };
            0x2::event::emit<SourceAssetDisallowed>(v1);
        };
    }

    public fun execute_plan<T0>(arg0: &mut Investment, arg1: ExecutionReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        let v1 = pay_fee_if_necessary<T0>(arg0, v0, arg3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 2);
        let ExecutionReceipt { plan_id: v3 } = arg1;
        let v4 = 0x2::table::borrow_mut<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, v3);
        let v5 = 0x1::type_name::get<T0>();
        assert!(&v5 == 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::target_asset(v4), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::receiver(v4));
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::execute(v4, v2);
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::unpause(v4);
        let v6 = PlanExecuted{
            plan_id             : v3,
            executor            : 0x2::tx_context::sender(arg3),
            purchased_amount    : v2,
            fee_amount          : v1,
            execution_count     : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::execution_count(v4),
            next_execution_time : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::next_execution_time(v4),
        };
        0x2::event::emit<PlanExecuted>(v6);
        if (0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::execution_count(v4) == 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::execution_limit(v4)) {
            0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::destroy(remove_plan_(arg0, v3, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::owner(v4)));
        };
    }

    public fun get_account_balance<T0>(arg0: &Investment, arg1: address) : u64 {
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::account_balance<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::Custodian<T0>>(&arg0.custodians, 0x1::type_name::get<T0>()), arg1)
    }

    public fun get_plan(arg0: &Investment, arg1: u64) : &0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan {
        check_plan_exists(arg0, arg1);
        0x2::table::borrow<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&arg0.plans, arg1)
    }

    public fun get_user_plans(arg0: &Investment, arg1: address) : &0x2::linked_table::LinkedTable<u64, bool> {
        0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_plans, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFee{
            fee_rate : 0,
            vault    : 0x2::bag::new(arg0),
        };
        let v1 = Investment{
            id                      : 0x2::object::new(arg0),
            next_plan_id            : 1,
            plans                   : 0x2::table::new<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(arg0),
            user_plans              : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, bool>>(arg0),
            protocol_fee            : v0,
            custodians              : 0x2::bag::new(arg0),
            executors               : 0x2::vec_set::empty<address>(),
            whitelist_source_assets : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            version                 : 1,
        };
        0x2::transfer::share_object<Investment>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun inject_plan(arg0: &mut Investment, arg1: 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::plan_id(&arg1);
        0x2::table::add<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, v0, arg1);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_plans, arg2)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_plans, arg2, 0x2::linked_table::new<u64, bool>(arg3));
        };
        0x2::linked_table::push_back<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_plans, arg2), v0, true);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Investment) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    public fun pause_plan(arg0: &mut Investment, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_plan_exists(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, arg1);
        assert!(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::owner(v1) == v0, 9);
        assert!(!0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::is_paused(v1), 6);
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::pause(v1);
        let v2 = PlanPaused{
            plan_id             : arg1,
            next_execution_time : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::next_execution_time(v1),
            sender              : v0,
        };
        0x2::event::emit<PlanPaused>(v2);
    }

    fun pay_fee_if_necessary<T0>(arg0: &mut Investment, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (arg0.protocol_fee.fee_rate > 0) {
            let v1 = 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::math::calculate_protocol_fee(arg0.protocol_fee.fee_rate, 0x2::coin::value<T0>(arg1));
            v0 = v1;
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.protocol_fee.vault, 0x1::type_name::get<T0>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fee.vault, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
            };
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fee.vault, 0x1::type_name::get<T0>()), 0x2::coin::split<T0>(arg1, v1, arg2));
        };
        v0
    }

    public fun plan_exists(arg0: &Investment, arg1: u64) : bool {
        0x2::table::contains<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&arg0.plans, arg1)
    }

    public entry fun remove_executor(arg0: &AdminCap, arg1: &mut Investment, arg2: address, arg3: &0x2::tx_context::TxContext) {
        if (0x2::vec_set::contains<address>(&arg1.executors, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.executors, &arg2);
            let v0 = ExecutorRemoved{
                sender   : 0x2::tx_context::sender(arg3),
                executor : arg2,
            };
            0x2::event::emit<ExecutorRemoved>(v0);
        };
    }

    public fun remove_plan(arg0: &mut Investment, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_plan_exists(arg0, arg1);
        let v0 = remove_plan_(arg0, arg1, 0x2::tx_context::sender(arg2));
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::destroy(v0);
        let v1 = PlanRemoved{
            plan_id             : arg1,
            next_execution_time : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::next_execution_time(&v0),
            sender              : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PlanRemoved>(v1);
    }

    fun remove_plan_(arg0: &mut Investment, arg1: u64, arg2: address) : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan {
        assert!(0x2::linked_table::contains<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_plans, arg2), arg1), 9);
        0x2::linked_table::remove<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_plans, arg2), arg1);
        let v0 = 0x2::table::remove<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, arg1);
        assert!(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::owner(&v0) == arg2, 9);
        v0
    }

    public entry fun set_protocol_fee(arg0: &AdminCap, arg1: &mut Investment, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(arg2 <= 100000, 8);
        arg1.protocol_fee.fee_rate = arg2;
        let v0 = SetProtocolFeeRate{
            sender   : 0x2::tx_context::sender(arg3),
            fee_rate : arg2,
        };
        0x2::event::emit<SetProtocolFeeRate>(v0);
    }

    public fun take_plan<T0>(arg0: &mut Investment, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExecutionReceipt) {
        check_version(arg0);
        check_plan_exists(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        check_executor(arg0, &v0);
        let v1 = &mut arg0.custodians;
        let v2 = borrow_mut_custodian<T0>(v1, arg3);
        let v3 = 0x2::table::borrow_mut<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, arg1);
        let v4 = 0x1::type_name::get<T0>();
        assert!(&v4 == 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::source_asset(v3), 3);
        assert!(!0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::is_paused(v3), 6);
        assert!(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::is_executable(v3, arg2), 7);
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::pause(v3);
        let v5 = ExecutionReceipt{plan_id: arg1};
        (0x2::coin::from_balance<T0>(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::withdraw<T0>(v2, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::subscription_amount(v3), 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::owner(v3)), arg3), v5)
    }

    public fun unpause_plan(arg0: &mut Investment, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_plan_exists(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut arg0.plans, arg1);
        assert!(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::owner(v1) == v0, 9);
        assert!(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::is_paused(v1), 12);
        0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::unpause(v1);
        let v2 = PlanUnpaused{
            plan_id             : arg1,
            next_execution_time : 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::next_execution_time(v1),
            sender              : v0,
        };
        0x2::event::emit<PlanUnpaused>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Investment, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.custodians;
        let v2 = borrow_mut_custodian<T0>(v1, arg2);
        let v3 = 0x2::math::min(arg1, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::account_balance<T0>(v2, v0));
        let v4 = Withdrawn{
            sender : v0,
            amount : v3,
            asset  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Withdrawn>(v4);
        0x2::coin::from_balance<T0>(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian::withdraw<T0>(v2, v3, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

