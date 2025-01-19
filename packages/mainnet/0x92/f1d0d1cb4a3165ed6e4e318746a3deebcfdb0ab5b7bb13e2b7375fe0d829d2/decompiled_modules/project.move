module 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Order has store {
        coin_amount: u64,
        refunded: bool,
        token_amount: u64,
        claimed: bool,
    }

    struct LaunchState<phantom T0, phantom T1> has store {
        start_time: u64,
        end_time: u64,
        claim_time: u64,
        total_raised: u64,
        reached_soft_cap: bool,
        liquidity_fund_bps: u64,
        owner_fund_bps: u64,
        funded_balance: 0x2::balance::Balance<T0>,
        token_balance: 0x2::balance::Balance<T1>,
        participants: 0x2::table::Table<address, Order>,
        total_participant: u64,
    }

    struct Project<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pause: bool,
        soft_cap: u64,
        hard_cap: u64,
        coin_per_token: u64,
        owner: address,
        token_decimals: u8,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T1>>,
        is_private: bool,
        whitelisted: 0x2::table::Table<address, u64>,
        default_alloc: u64,
        fund_manager: address,
        wl_manager: vector<address>,
        launch_state: LaunchState<T0, T1>,
    }

    struct ProjectCreatedEvent has copy, drop {
        project: 0x2::object::ID,
        owner: address,
        token_decimals: u8,
        soft_cap: u64,
        hard_cap: u64,
        coin_per_token: u64,
        is_private: bool,
        default_alloc: u64,
    }

    struct LaunchStateUpdatedEvent has copy, drop {
        project: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        claim_time: u64,
        liquidity_fund_bps: u64,
        owner_fund_bps: u64,
    }

    struct ProjectUpdatedEvent has copy, drop {
        project: 0x2::object::ID,
        owner: address,
        token_decimals: u8,
        soft_cap: u64,
        hard_cap: u64,
        coin_per_token: u64,
    }

    struct AddWhiteListedEvent has copy, drop {
        project: 0x2::object::ID,
        manager: address,
        users: vector<address>,
        allocs: vector<u64>,
    }

    struct RemoveWhiteListedEvent has copy, drop {
        project: 0x2::object::ID,
        manager: address,
        users: vector<address>,
    }

    struct ProjectPausedEvent has copy, drop {
        project: 0x2::object::ID,
        pause: bool,
    }

    struct DistributeFundEvent has copy, drop {
        project: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct WithdrawLiquidityEvent has copy, drop {
        project: 0x2::object::ID,
        recipient: address,
        fund_amount: u64,
        token_amount: u64,
    }

    struct BuyEvent has copy, drop {
        project: 0x2::object::ID,
        user: address,
        coin_amount: u64,
        receive_amount: u64,
    }

    struct RefundedEvent has copy, drop {
        project: 0x2::object::ID,
        user: address,
        refund_amount: u64,
    }

    struct ClaimedEvent has copy, drop {
        project: 0x2::object::ID,
        user: address,
        token_amount: u64,
    }

    public fun add_whitelist<T0, T1>(arg0: &mut Project<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1008);
        assert!(arg0.is_private, 1013);
        assert!(0x1::vector::length<address>(&arg1) > 0 && 0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1012);
        let v1 = &mut arg0.whitelisted;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg1)) {
            let v5 = 0x1::vector::pop_back<address>(&mut arg1);
            let v6 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (!0x2::table::contains<address, u64>(v1, v5)) {
                0x2::table::add<address, u64>(v1, v5, v6);
            } else {
                *0x2::table::borrow_mut<address, u64>(v1, v5) = v6;
            };
            0x1::vector::push_back<address>(&mut v2, v5);
            0x1::vector::push_back<u64>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = AddWhiteListedEvent{
            project : 0x2::object::id<Project<T0, T1>>(arg0),
            manager : 0x2::tx_context::sender(arg4),
            users   : v2,
            allocs  : v3,
        };
        0x2::event::emit<AddWhiteListedEvent>(v7);
    }

    public fun buy<T0, T1>(arg0: &mut Project<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg3, 1);
        validate_status<T0, T1>(arg0);
        let v0 = &mut arg0.launch_state;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 1001);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 > 0, 1005);
        0x2::balance::join<T0>(&mut v0.funded_balance, 0x2::coin::into_balance<T0>(arg1));
        let v4 = if (0x2::table::contains<address, Order>(&v0.participants, v2)) {
            0x2::table::borrow_mut<address, Order>(&mut v0.participants, v2)
        } else {
            v0.total_participant = v0.total_participant + 1;
            let v5 = Order{
                coin_amount  : 0,
                refunded     : false,
                token_amount : 0,
                claimed      : false,
            };
            0x2::table::add<address, Order>(&mut v0.participants, v2, v5);
            0x2::table::borrow_mut<address, Order>(&mut v0.participants, v2)
        };
        v4.coin_amount = v4.coin_amount + v3;
        if (arg0.is_private) {
            assert!(0x2::table::contains<address, u64>(&arg0.whitelisted, v2), 1003);
            assert!(v4.coin_amount == *0x2::table::borrow<address, u64>(&arg0.whitelisted, v2), 1004);
        } else {
            assert!(v4.coin_amount <= arg0.default_alloc, 1004);
        };
        v0.total_raised = v0.total_raised + v3;
        assert!(v0.total_raised <= arg0.hard_cap, 1002);
        if (v0.reached_soft_cap == false && v0.total_raised >= arg0.soft_cap) {
            v0.reached_soft_cap = true;
        };
        let v6 = coin_to_token(v3, arg0.coin_per_token, arg0.token_decimals);
        0x2::balance::join<T1>(&mut v0.token_balance, 0x2::coin::mint_balance<T1>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T1>>(&mut arg0.treasury_cap), v6));
        let v7 = v6 - v6 * v0.liquidity_fund_bps / 10000;
        v4.token_amount = v4.token_amount + v7;
        let v8 = BuyEvent{
            project        : 0x2::object::id<Project<T0, T1>>(arg0),
            user           : v2,
            coin_amount    : v3,
            receive_amount : v7,
        };
        0x2::event::emit<BuyEvent>(v8);
        (v3, v4.token_amount)
    }

    public fun claim<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        validate_status<T0, T1>(arg0);
        let v0 = &mut arg0.launch_state;
        assert!(v0.reached_soft_cap, 1007);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.claim_time, 1001);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Order>(&v0.participants, v1), 1008);
        let v2 = 0x2::table::borrow_mut<address, Order>(&mut v0.participants, v1);
        assert!(!v2.claimed, 1009);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v0.token_balance, v2.token_amount, arg3), v1);
        v2.claimed = true;
        let v3 = ClaimedEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg0),
            user         : v1,
            token_amount : v2.token_amount,
        };
        0x2::event::emit<ClaimedEvent>(v3);
        v2.token_amount
    }

    fun coin_to_token(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 != 0, 1000);
        (((arg0 as u128) * (0x1::u64::pow(10, arg2) as u128) / (arg1 as u128)) as u64)
    }

    public fun config_fund_manager<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: address, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg3, 1);
        arg1.fund_manager = arg2;
    }

    public fun config_wl_manager<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: vector<address>, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg3, 1);
        assert!(arg1.is_private, 1013);
        arg1.wl_manager = arg2;
    }

    public fun distribute_fund_to_owner<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fund_manager, 1008);
        let v0 = &mut arg0.launch_state;
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.end_time, 1001);
        assert!(v0.reached_soft_cap, 1007);
        assert!(0x2::balance::value<T0>(&v0.funded_balance) > 0, 1011);
        let v1 = v0.total_raised * v0.owner_fund_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0.funded_balance, v1, arg3), arg0.owner);
        let v2 = DistributeFundEvent{
            project   : 0x2::object::id<Project<T0, T1>>(arg0),
            recipient : arg0.owner,
            amount    : v1,
        };
        0x2::event::emit<DistributeFundEvent>(v2);
        v1
    }

    public fun emergency_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        validate_status<T0, T1>(arg1);
        let v0 = &mut arg1.launch_state;
        let v1 = 0x2::balance::value<T0>(&v0.funded_balance);
        assert!(v1 > 0, 1011);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0.funded_balance, v1, arg3), arg1.fund_manager);
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg1.treasury_cap)) {
            let v2 = 0x1::option::extract<0x2::coin::TreasuryCap<T1>>(&mut arg1.treasury_cap);
            0x2::coin::burn<T1>(&mut v2, 0x2::coin::take<T1>(&mut v0.token_balance, 0x2::balance::value<T1>(&v0.token_balance), arg3));
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v2, arg1.owner);
        };
        let v3 = WithdrawLiquidityEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg1),
            recipient    : arg1.fund_manager,
            fund_amount  : v1,
            token_amount : 0,
        };
        0x2::event::emit<WithdrawLiquidityEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_project<T0, T1>(arg0: &AdminCap, arg1: address, arg2: address, arg3: u8, arg4: 0x2::coin::TreasuryCap<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg10, 1);
        assert!(arg3 > 0, 1006);
        let v0 = if (arg5 > 0) {
            if (arg5 < arg6) {
                arg7 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1005);
        assert!(0x2::coin::total_supply<T1>(&arg4) == 0, 1014);
        let v1 = LaunchState<T0, T1>{
            start_time         : 0,
            end_time           : 0,
            claim_time         : 0,
            total_raised       : 0,
            reached_soft_cap   : false,
            liquidity_fund_bps : 0,
            owner_fund_bps     : 0,
            funded_balance     : 0x2::balance::zero<T0>(),
            token_balance      : 0x2::balance::zero<T1>(),
            participants       : 0x2::table::new<address, Order>(arg11),
            total_participant  : 0,
        };
        let v2 = Project<T0, T1>{
            id             : 0x2::object::new(arg11),
            pause          : true,
            soft_cap       : arg5,
            hard_cap       : arg6,
            coin_per_token : arg7,
            owner          : arg1,
            token_decimals : arg3,
            treasury_cap   : 0x1::option::none<0x2::coin::TreasuryCap<T1>>(),
            is_private     : arg8,
            whitelisted    : 0x2::table::new<address, u64>(arg11),
            default_alloc  : arg9,
            fund_manager   : arg2,
            wl_manager     : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg11)),
            launch_state   : v1,
        };
        0x1::option::fill<0x2::coin::TreasuryCap<T1>>(&mut v2.treasury_cap, arg4);
        let v3 = ProjectCreatedEvent{
            project        : 0x2::object::id<Project<T0, T1>>(&v2),
            owner          : arg1,
            token_decimals : arg3,
            soft_cap       : arg5,
            hard_cap       : arg6,
            coin_per_token : arg7,
            is_private     : arg8,
            default_alloc  : arg9,
        };
        0x2::event::emit<ProjectCreatedEvent>(v3);
        0x2::transfer::share_object<Project<T0, T1>>(v2);
    }

    public fun refund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        validate_status<T0, T1>(arg0);
        let v0 = &mut arg0.launch_state;
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.claim_time, 1001);
        assert!(!v0.reached_soft_cap, 1007);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Order>(&v0.participants, v1), 1008);
        let v2 = 0x2::table::borrow_mut<address, Order>(&mut v0.participants, v1);
        assert!(!v2.refunded, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0.funded_balance, v2.coin_amount, arg3), v1);
        v2.refunded = true;
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg0.treasury_cap)) {
            let v3 = 0x1::option::extract<0x2::coin::TreasuryCap<T1>>(&mut arg0.treasury_cap);
            0x2::coin::burn<T1>(&mut v3, 0x2::coin::take<T1>(&mut v0.token_balance, 0x2::balance::value<T1>(&v0.token_balance), arg3));
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v3, arg0.owner);
        };
        let v4 = RefundedEvent{
            project       : 0x2::object::id<Project<T0, T1>>(arg0),
            user          : v1,
            refund_amount : v2.coin_amount,
        };
        0x2::event::emit<RefundedEvent>(v4);
        v2.coin_amount
    }

    public fun remove_whitelist<T0, T1>(arg0: &mut Project<T0, T1>, arg1: vector<address>, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1008);
        assert!(arg0.is_private, 1013);
        assert!(0x1::vector::length<address>(&arg1) > 0, 1012);
        let v1 = &mut arg0.whitelisted;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, u64>(v1, v4)) {
                0x2::table::remove<address, u64>(v1, v4);
                0x1::vector::push_back<address>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = RemoveWhiteListedEvent{
            project : 0x2::object::id<Project<T0, T1>>(arg0),
            manager : 0x2::tx_context::sender(arg3),
            users   : v2,
        };
        0x2::event::emit<RemoveWhiteListedEvent>(v5);
    }

    public fun setup_project_launch_state<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg8, 1);
        assert!(arg6 > 0 && arg5 > 0, 1005);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg2, 1001);
        assert!(arg2 < arg3 && arg3 <= arg4, 1001);
        arg1.pause = false;
        let v0 = &mut arg1.launch_state;
        v0.start_time = arg2;
        v0.end_time = arg3;
        v0.claim_time = arg4;
        v0.liquidity_fund_bps = arg6;
        v0.owner_fund_bps = arg5;
        let v1 = LaunchStateUpdatedEvent{
            project            : 0x2::object::id<Project<T0, T1>>(arg1),
            start_time         : arg2,
            end_time           : arg3,
            claim_time         : arg4,
            liquidity_fund_bps : arg6,
            owner_fund_bps     : arg5,
        };
        0x2::event::emit<LaunchStateUpdatedEvent>(v1);
    }

    public fun trigger_project_status<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: bool, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg3, 1);
        arg1.pause = arg2;
        let v0 = ProjectPausedEvent{
            project : 0x2::object::id<Project<T0, T1>>(arg1),
            pause   : arg2,
        };
        0x2::event::emit<ProjectPausedEvent>(v0);
    }

    public fun update_project<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u8, arg7: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg7, 1);
        arg1.soft_cap = arg2;
        arg1.hard_cap = arg3;
        arg1.coin_per_token = arg4;
        arg1.owner = arg5;
        arg1.token_decimals = arg6;
        let v0 = ProjectUpdatedEvent{
            project        : 0x2::object::id<Project<T0, T1>>(arg1),
            owner          : arg5,
            token_decimals : arg6,
            soft_cap       : arg2,
            hard_cap       : arg3,
            coin_per_token : arg4,
        };
        0x2::event::emit<ProjectUpdatedEvent>(v0);
    }

    fun validate_status<T0, T1>(arg0: &Project<T0, T1>) {
        assert!(!arg0.pause, 1000);
    }

    public fun withdraw_liquidity_fund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::check_version(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.fund_manager, 1008);
        let v1 = &mut arg0.launch_state;
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.end_time, 1001);
        assert!(v1.reached_soft_cap, 1007);
        assert!(0x2::balance::value<T0>(&v1.funded_balance) > 0, 1011);
        let v2 = v1.total_raised * v1.liquidity_fund_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.funded_balance, v2, arg3), v0);
        let v3 = coin_to_token(v2, arg0.coin_per_token, arg0.token_decimals);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.token_balance, v3, arg3), v0);
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg0.treasury_cap)) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T1>>(0x1::option::extract<0x2::coin::TreasuryCap<T1>>(&mut arg0.treasury_cap));
        };
        let v4 = WithdrawLiquidityEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg0),
            recipient    : v0,
            fund_amount  : v2,
            token_amount : v3,
        };
        0x2::event::emit<WithdrawLiquidityEvent>(v4);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

