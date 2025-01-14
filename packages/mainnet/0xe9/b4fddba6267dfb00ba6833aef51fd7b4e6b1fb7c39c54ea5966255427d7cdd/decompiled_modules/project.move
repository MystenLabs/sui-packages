module 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::project {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Order has store {
        coin_amount: u64,
        refunded: bool,
        token_amount: u64,
        claimed: bool,
    }

    struct RoundInfo has store, key {
        id: 0x2::object::UID,
        total_raise: u64,
        raised_amount: u64,
        start_time: u64,
        end_time: u64,
        using_whitelist: bool,
        whitelisted: 0x2::table::Table<address, u64>,
        default_alloc: u64,
        participants: 0x2::table::Table<address, Order>,
        total_participant: u64,
    }

    struct Project<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pause: bool,
        owner: address,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T1>>,
        token_decimals: u8,
        total_raise: u64,
        coin_per_token: u64,
        raising_threshold: bool,
        liquidity_fund_bps: u64,
        owner_fund_bps: u64,
        release_time: u64,
        funded_balance: 0x2::balance::Balance<T0>,
        token_balance: 0x2::balance::Balance<T1>,
        private_round: RoundInfo,
        public_round: RoundInfo,
    }

    struct ProjectCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        token_decimals: u8,
        total_raise: u64,
        release_time: u64,
        coin_per_token: u64,
        liquidity_fund_bps: u64,
        owner_fund_bps: u64,
    }

    struct RoundInfoUpdatedEvent has copy, drop {
        project: 0x2::object::ID,
        private_round: bool,
        total_raise: u64,
        start_time: u64,
        end_time: u64,
        using_whitelist: bool,
        default_alloc: u64,
    }

    struct AddWhiteListedEvent has copy, drop {
        project: 0x2::object::ID,
        private_round: bool,
        users: vector<address>,
        allocs: vector<u64>,
    }

    struct RemoveWhiteListedEvent has copy, drop {
        project: 0x2::object::ID,
        private_round: bool,
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
        private_round: bool,
        user: address,
        coin_amount: u64,
        token_receive: u64,
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

    public fun add_whitelist<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: bool, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg5, 1);
        validate_status<T0, T1>(arg1);
        let v0 = if (arg2) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        assert!(v0.using_whitelist, 1013);
        assert!(0x1::vector::length<address>(&arg3) > 0 && 0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 1012);
        let v1 = &mut v0.whitelisted;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg3)) {
            let v5 = 0x1::vector::pop_back<address>(&mut arg3);
            let v6 = 0x1::vector::pop_back<u64>(&mut arg4);
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
            project       : 0x2::object::id<Project<T0, T1>>(arg1),
            private_round : arg2,
            users         : v2,
            allocs        : v3,
        };
        0x2::event::emit<AddWhiteListedEvent>(v7);
    }

    public fun buy<T0, T1>(arg0: &mut Project<T0, T1>, arg1: bool, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg4, 1);
        validate_status<T0, T1>(arg0);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg0.treasury_cap), 1015);
        let v0 = if (arg1) {
            &mut arg0.private_round
        } else {
            &mut arg0.public_round
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 1001);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 1005);
        if (arg1) {
            assert!(v0.raised_amount + v3 <= v0.total_raise, 1006);
        };
        assert!(0x2::balance::value<T0>(&arg0.funded_balance) + v3 <= arg0.total_raise, 1002);
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
        0x2::balance::join<T0>(&mut arg0.funded_balance, 0x2::coin::into_balance<T0>(arg2));
        v0.raised_amount = v0.raised_amount + v3;
        if (v0.using_whitelist) {
            assert!(0x2::table::contains<address, u64>(&v0.whitelisted, v2), 1003);
            assert!(v4.coin_amount <= *0x2::table::borrow<address, u64>(&v0.whitelisted, v2), 1004);
        } else {
            assert!(v4.coin_amount <= v0.default_alloc, 1004);
        };
        let v6 = coin_to_token(v3, arg0.coin_per_token, arg0.token_decimals);
        0x2::balance::join<T1>(&mut arg0.token_balance, 0x2::coin::mint_balance<T1>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T1>>(&mut arg0.treasury_cap), v6));
        let v7 = v6 - v6 * arg0.liquidity_fund_bps / 10000;
        v4.token_amount = v4.token_amount + v7;
        if (0x2::balance::value<T0>(&arg0.funded_balance) == arg0.total_raise) {
            arg0.raising_threshold = true;
        };
        let v8 = BuyEvent{
            project       : 0x2::object::id<Project<T0, T1>>(arg0),
            private_round : arg1,
            user          : v2,
            coin_amount   : v3,
            token_receive : v7,
        };
        0x2::event::emit<BuyEvent>(v8);
    }

    public fun claim<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg2, 1);
        validate_status<T0, T1>(arg0);
        assert!(arg0.raising_threshold, 1007);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.release_time, 1001);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = v1;
        if (0x2::table::contains<address, Order>(&arg0.private_round.participants, v0)) {
            let v3 = 0x2::table::borrow_mut<address, Order>(&mut arg0.private_round.participants, v0);
            if (!v3.claimed) {
                v2 = v1 + v3.token_amount;
                v3.claimed = true;
            };
        };
        if (0x2::table::contains<address, Order>(&arg0.public_round.participants, v0)) {
            let v4 = 0x2::table::borrow_mut<address, Order>(&mut arg0.public_round.participants, v0);
            if (!v4.claimed) {
                v2 = v2 + v4.token_amount;
                v4.claimed = true;
            };
        };
        assert!(v2 > 0, 1009);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_balance, v2, arg3), v0);
        let v5 = ClaimedEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg0),
            user         : v0,
            token_amount : v2,
        };
        0x2::event::emit<ClaimedEvent>(v5);
        v2
    }

    fun coin_to_token(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 != 0, 1000);
        (((arg0 as u128) * (0x1::u64::pow(10, arg2) as u128) / (arg1 as u128)) as u64)
    }

    public fun distribute_fund_to_owner<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg3, 1);
        assert!(arg1.raising_threshold, 1007);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.release_time, 1001);
        assert!(0x2::balance::value<T0>(&arg1.funded_balance) > 0, 1011);
        let v0 = 0x2::balance::value<T0>(&arg1.funded_balance) * arg1.owner_fund_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.funded_balance, v0, arg4), arg1.owner);
        let v1 = DistributeFundEvent{
            project   : 0x2::object::id<Project<T0, T1>>(arg1),
            recipient : arg1.owner,
            amount    : v0,
        };
        0x2::event::emit<DistributeFundEvent>(v1);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg2, 1);
        validate_status<T0, T1>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg1.funded_balance);
        assert!(v0 > 0, 1011);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.funded_balance, v0, arg3), v1);
        let v2 = WithdrawLiquidityEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg1),
            recipient    : v1,
            fund_amount  : v0,
            token_amount : 0,
        };
        0x2::event::emit<WithdrawLiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_project<T0, T1>(arg0: &AdminCap, arg1: address, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg9, 1);
        assert!(0x2::coin::total_supply<T1>(&arg2) == 0, 1014);
        assert!(arg5 > 0, 1014);
        let v0 = if (arg4 > 0) {
            if (arg5 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1005);
        let v1 = RoundInfo{
            id                : 0x2::object::new(arg10),
            total_raise       : 0,
            raised_amount     : 0,
            start_time        : 0,
            end_time          : 0,
            using_whitelist   : true,
            whitelisted       : 0x2::table::new<address, u64>(arg10),
            default_alloc     : 0,
            participants      : 0x2::table::new<address, Order>(arg10),
            total_participant : 0,
        };
        let v2 = RoundInfo{
            id                : 0x2::object::new(arg10),
            total_raise       : 0,
            raised_amount     : 0,
            start_time        : 0,
            end_time          : 0,
            using_whitelist   : true,
            whitelisted       : 0x2::table::new<address, u64>(arg10),
            default_alloc     : 0,
            participants      : 0x2::table::new<address, Order>(arg10),
            total_participant : 0,
        };
        let v3 = Project<T0, T1>{
            id                 : 0x2::object::new(arg10),
            pause              : false,
            owner              : arg1,
            treasury_cap       : 0x1::option::none<0x2::coin::TreasuryCap<T1>>(),
            token_decimals     : arg3,
            total_raise        : arg4,
            coin_per_token     : arg5,
            raising_threshold  : false,
            liquidity_fund_bps : arg7,
            owner_fund_bps     : arg8,
            release_time       : arg6,
            funded_balance     : 0x2::balance::zero<T0>(),
            token_balance      : 0x2::balance::zero<T1>(),
            private_round      : v1,
            public_round       : v2,
        };
        0x1::option::fill<0x2::coin::TreasuryCap<T1>>(&mut v3.treasury_cap, arg2);
        let v4 = ProjectCreatedEvent{
            id                 : 0x2::object::id<Project<T0, T1>>(&v3),
            owner              : arg1,
            token_decimals     : arg3,
            total_raise        : arg4,
            release_time       : arg6,
            coin_per_token     : arg5,
            liquidity_fund_bps : arg7,
            owner_fund_bps     : arg8,
        };
        0x2::event::emit<ProjectCreatedEvent>(v4);
        0x2::transfer::share_object<Project<T0, T1>>(v3);
    }

    public fun refund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg2, 1);
        validate_status<T0, T1>(arg0);
        assert!(!arg0.raising_threshold, 1007);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.release_time, 1001);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = v1;
        if (0x2::table::contains<address, Order>(&arg0.private_round.participants, v0)) {
            let v3 = 0x2::table::borrow_mut<address, Order>(&mut arg0.private_round.participants, v0);
            if (!v3.refunded) {
                v2 = v1 + v3.coin_amount;
                v3.refunded = true;
            };
        };
        if (0x2::table::contains<address, Order>(&arg0.public_round.participants, v0)) {
            let v4 = 0x2::table::borrow_mut<address, Order>(&mut arg0.public_round.participants, v0);
            if (!v4.refunded) {
                v2 = v2 + v4.coin_amount;
                v4.refunded = true;
            };
        };
        assert!(v2 > 0, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funded_balance, v2, arg3), v0);
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg0.treasury_cap)) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(0x1::option::extract<0x2::coin::TreasuryCap<T1>>(&mut arg0.treasury_cap), arg0.owner);
        };
        let v5 = RefundedEvent{
            project       : 0x2::object::id<Project<T0, T1>>(arg0),
            user          : v0,
            refund_amount : v2,
        };
        0x2::event::emit<RefundedEvent>(v5);
        v2
    }

    public fun remove_whitelist<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: bool, arg3: vector<address>, arg4: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg4, 1);
        validate_status<T0, T1>(arg1);
        assert!(0x1::vector::length<address>(&arg3) > 0, 1012);
        let v0 = if (arg2) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        assert!(v0.using_whitelist, 1013);
        let v1 = &mut v0.whitelisted;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg3)) {
            let v4 = 0x1::vector::pop_back<address>(&mut arg3);
            if (0x2::table::contains<address, u64>(v1, v4)) {
                0x2::table::remove<address, u64>(v1, v4);
                0x1::vector::push_back<address>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = RemoveWhiteListedEvent{
            project       : 0x2::object::id<Project<T0, T1>>(arg1),
            private_round : arg2,
            users         : v2,
        };
        0x2::event::emit<RemoveWhiteListedEvent>(v5);
    }

    public fun trigger_project_status<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: bool, arg3: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg3, 1);
        arg1.pause = arg2;
        let v0 = ProjectPausedEvent{
            project : 0x2::object::id<Project<T0, T1>>(arg1),
            pause   : arg2,
        };
        0x2::event::emit<ProjectPausedEvent>(v0);
    }

    public fun update_round_info<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg9, 1);
        validate_status<T0, T1>(arg1);
        assert!(arg3 > 0, 1005);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg4, 1001);
        assert!(arg4 < arg5 && arg5 < arg1.release_time, 1001);
        let v0 = if (arg2) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        v0.total_raise = arg3;
        v0.start_time = arg4;
        v0.end_time = arg5;
        v0.using_whitelist = arg6;
        v0.default_alloc = arg7;
        let v1 = RoundInfoUpdatedEvent{
            project         : 0x2::object::id<Project<T0, T1>>(arg1),
            private_round   : arg2,
            total_raise     : arg3,
            start_time      : arg4,
            end_time        : arg5,
            using_whitelist : arg6,
            default_alloc   : arg7,
        };
        0x2::event::emit<RoundInfoUpdatedEvent>(v1);
    }

    fun validate_status<T0, T1>(arg0: &Project<T0, T1>) {
        assert!(!arg0.pause, 1000);
    }

    public fun withdraw_liquidity_fund<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version::checkVersion(arg3, 1);
        assert!(arg1.raising_threshold, 1007);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.release_time, 1001);
        assert!(0x2::balance::value<T0>(&arg1.funded_balance) > 0, 1011);
        assert!(0x2::balance::value<T1>(&arg1.token_balance) > 0, 1011);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::balance::value<T0>(&arg1.funded_balance) * arg1.liquidity_fund_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.funded_balance, v1, arg4), v0);
        let v2 = coin_to_token(v1, arg1.coin_per_token, arg1.token_decimals);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.token_balance, v2, arg4), v0);
        if (0x1::option::is_some<0x2::coin::TreasuryCap<T1>>(&arg1.treasury_cap)) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(0x1::option::extract<0x2::coin::TreasuryCap<T1>>(&mut arg1.treasury_cap), @0x0);
        };
        let v3 = WithdrawLiquidityEvent{
            project      : 0x2::object::id<Project<T0, T1>>(arg1),
            recipient    : v0,
            fund_amount  : v1,
            token_amount : v2,
        };
        0x2::event::emit<WithdrawLiquidityEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

