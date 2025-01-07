module 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::project {
    struct PROJECT has drop {
        dummy_field: bool,
    }

    struct ProjectProfile has store {
        name: vector<u8>,
        twitter: vector<u8>,
        discord: vector<u8>,
        telegram: vector<u8>,
        website: vector<u8>,
    }

    struct Order has store {
        buyer: address,
        coin_amount: u64,
        token_amount: u64,
        token_released: u64,
    }

    struct LaunchState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        soft_cap: u64,
        hard_cap: u64,
        round: u8,
        state: u8,
        total_token_sold: u64,
        swap_ratio_coin: u64,
        swap_ratio_token: u64,
        participants: u64,
        start_time: u64,
        end_time: u64,
        token_fund: 0x2::coin::Coin<T1>,
        total_token_deposited: u64,
        coin_raised: 0x2::coin::Coin<T0>,
        order_book: 0x2::table::Table<address, Order>,
        default_max_allocate: u64,
        max_allocations: 0x2::table::Table<address, u64>,
    }

    struct Community has store, key {
        id: 0x2::object::UID,
        total_vote: u64,
        voters: 0x2::vec_set::VecSet<address>,
    }

    struct VestingMileStone has copy, drop, store {
        time: u64,
        percent: u64,
    }

    struct Vesting has store, key {
        id: 0x2::object::UID,
        type: u8,
        tge: u64,
        cliff_time: u64,
        unlock_percent: u64,
        linear_time: u64,
        milestones: vector<VestingMileStone>,
    }

    struct Project<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        launch_state: LaunchState<T0, T1>,
        community: Community,
        use_whitelist: bool,
        owner: address,
        coin_decimals: u8,
        token_decimals: u8,
        vesting: Vesting,
        whitelist: 0x2::table::Table<address, address>,
        require_kyc: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SetupProjectEvent has copy, drop {
        project: address,
        usewhitelist: bool,
        round: u8,
        swap_ratio_coin: u64,
        swap_ratio_token: u64,
        max_allocate: u64,
        start_time: u64,
        end_time: u64,
        soft_cap: u64,
        hard_cap: u64,
    }

    struct StartFundRaisingEvent has copy, drop {
        project: address,
        epoch: u64,
    }

    struct BuyEvent has copy, drop {
        project: address,
        buyer: address,
        order_value: u64,
        order_bought: u64,
        token_bought: u64,
        more_token: u64,
        total_raised: u64,
        sold_out: bool,
        participants: u64,
        epoch: u64,
    }

    struct LaunchStateEvent has copy, drop {
        project: address,
        total_sold: u64,
        epoch: u64,
        state: u8,
        end_time: u64,
    }

    struct AddWhiteListEvent has copy, drop {
        project: address,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        project: address,
        users: vector<address>,
    }

    struct DistributeRaisedFundEvent has copy, drop {
        project: address,
        epoch: u64,
    }

    struct DistributeRaisedFundEvent2 has copy, drop {
        project: address,
        to: address,
        amount: u64,
    }

    struct RefundClosedEvent has copy, drop {
        project: address,
        coin_refunded: u64,
        epoch: u64,
    }

    struct ProjectDepositFundEvent has copy, drop {
        project: address,
        depositor: address,
        token_amount: u64,
    }

    struct ProjectCreatedEvent has copy, drop {
        project: address,
        state: u8,
        usewhitelist: bool,
        vesting_type: u8,
        vesting_milestones: vector<VestingMileStone>,
    }

    struct AddMaxAllocateEvent has copy, drop {
        project: address,
        users: vector<address>,
        max_allocates: vector<u64>,
    }

    struct RemoveMaxAllocateEvent has copy, drop {
        project: address,
        users: vector<address>,
    }

    struct ChangeProjectOwnerEvent has copy, drop {
        project: address,
        old_owner: address,
        new_owner: address,
    }

    struct ClaimTokenEvent has copy, drop {
        project: address,
        user: address,
        token_amount: u64,
    }

    struct ClaimRefundEvent has copy, drop {
        project: address,
        user: address,
        coin_fund: u64,
    }

    public fun add_max_allocations<T0, T1>(arg0: &AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut Project<T0, T1>, arg4: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg4, 1);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = &mut arg3.launch_state;
        let v1 = &mut v0.max_allocations;
        let v2 = AddMaxAllocateEvent{
            project       : 0x2::object::id_address<Project<T0, T1>>(arg3),
            users         : arg1,
            max_allocates : arg2,
        };
        0x2::event::emit<AddMaxAllocateEvent>(v2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg1);
            let v4 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(v0.hard_cap > 0 && v4 > 0 && v4 < v0.hard_cap, 1028);
            if (0x2::table::contains<address, u64>(v1, v3)) {
                0x2::table::remove<address, u64>(v1, v3);
            };
            0x2::table::add<address, u64>(v1, v3, v4);
        };
    }

    public fun add_milestone<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg5, 1);
        let v0 = &mut arg1.vesting;
        assert!(v0.type == 1 || v0.type == 2, 1000);
        assert!(arg3 <= 10000, 1010);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = v0.tge;
        let v3 = v0.cliff_time;
        assert!(v2 > v1 && v3 >= 0 && arg2 >= v2 + v3, 1027);
        let v4 = VestingMileStone{
            time    : arg2,
            percent : arg3,
        };
        0x1::vector::push_back<VestingMileStone>(&mut v0.milestones, v4);
        validate_mile_stones(v0, arg1.launch_state.end_time, v1);
    }

    public fun add_whitelist<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: vector<address>, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        assert!(arg1.use_whitelist, 1007);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1029);
        let v0 = AddWhiteListEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg1),
            users   : arg2,
        };
        0x2::event::emit<AddWhiteListEvent>(v0);
        let v1 = &mut arg1.whitelist;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::table::contains<address, address>(v1, v2), 1008);
            0x2::table::add<address, address>(v1, v2, v2);
        };
    }

    fun build_event_create_project<T0, T1>(arg0: &Project<T0, T1>) : ProjectCreatedEvent {
        ProjectCreatedEvent{
            project            : 0x2::object::id_address<Project<T0, T1>>(arg0),
            state              : arg0.launch_state.state,
            usewhitelist       : arg0.use_whitelist,
            vesting_type       : arg0.vesting.type,
            vesting_milestones : arg0.vesting.milestones,
        }
    }

    public fun buy<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut Project<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x9acccedc9409023c1eaa33f66616be6d45d90553ef6f1592f4822a913d8f2d86::kyc::Kyc, arg5: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg5, 1);
        assert!(arg1 > 0, 1030);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(!arg2.require_kyc || 0x9acccedc9409023c1eaa33f66616be6d45d90553ef6f1592f4822a913d8f2d86::kyc::hasKYC(v0, arg4), 1022);
        validate_buy<T0, T1>(arg2, v0, v1);
        let v2 = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<T0>(arg0, arg1, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = swap_token<T0, T1>(v3, arg2);
        let v5 = &mut arg2.launch_state;
        v5.total_token_sold = v5.total_token_sold + v4;
        let v6 = &mut v5.order_book;
        if (!0x2::table::contains<address, Order>(v6, v0)) {
            let v7 = Order{
                buyer          : v0,
                coin_amount    : 0,
                token_amount   : 0,
                token_released : 0,
            };
            0x2::table::add<address, Order>(v6, v0, v7);
            v5.participants = v5.participants + 1;
        };
        let v8 = 0x2::table::borrow_mut<address, Order>(v6, v0);
        v8.coin_amount = v8.coin_amount + v3;
        v8.token_amount = v8.token_amount + v4;
        let v9 = v8.coin_amount;
        assert!(v9 <= get_max_allocate<T0, T1>(v0, &v5.max_allocations, v5.default_max_allocate), 1003);
        0x2::coin::join<T0>(&mut v5.coin_raised, v2);
        let v10 = 0x2::coin::value<T0>(&v5.coin_raised);
        assert!(v5.hard_cap >= v10, 1004);
        if (v10 == v5.hard_cap) {
            v5.state = 6;
        };
        let v11 = BuyEvent{
            project      : 0x2::object::uid_to_address(&arg2.id),
            buyer        : v0,
            order_value  : v3,
            order_bought : v9,
            token_bought : v8.token_amount,
            more_token   : v4,
            total_raised : v10,
            sold_out     : v10 == v5.hard_cap,
            participants : v5.participants,
            epoch        : v1,
        };
        0x2::event::emit<BuyEvent>(v11);
    }

    fun cal_claim_percent(arg0: &Vesting, arg1: u64) : u64 {
        let v0 = &arg0.milestones;
        let v1 = arg0.tge;
        let v2 = 0;
        let v3 = v2;
        if (arg0.type == 2) {
            if (arg1 >= v1 + arg0.cliff_time) {
                v3 = v2 + arg0.unlock_percent;
                let v4 = 0;
                while (v4 < 0x1::vector::length<VestingMileStone>(v0)) {
                    let v5 = 0x1::vector::borrow<VestingMileStone>(v0, v4);
                    if (arg1 >= v5.time) {
                        v3 = v3 + v5.percent;
                        v4 = v4 + 1;
                    } else {
                        break
                    };
                };
            };
        } else if (arg0.type == 1) {
            if (arg1 >= v1) {
                v3 = v2 + arg0.unlock_percent;
                if (arg1 >= v1 + arg0.cliff_time) {
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<VestingMileStone>(v0)) {
                        let v7 = 0x1::vector::borrow<VestingMileStone>(v0, v6);
                        if (arg1 >= v7.time) {
                            v3 = v3 + v7.percent;
                            v6 = v6 + 1;
                        } else {
                            break
                        };
                    };
                };
            };
        } else if (arg0.type == 3) {
            if (arg1 >= v1) {
                let v8 = v2 + arg0.unlock_percent;
                v3 = v8;
                if (arg1 >= v1 + arg0.cliff_time) {
                    v3 = v8 + (arg1 - v1 - arg0.cliff_time) * (10000 - arg0.unlock_percent) / arg0.linear_time;
                };
            };
        } else if (arg0.type == 4) {
            if (arg1 >= v1 + arg0.cliff_time) {
                v3 = v2 + arg0.unlock_percent + (arg1 - v1 - arg0.cliff_time) * (10000 - arg0.unlock_percent) / arg0.linear_time;
            };
        };
        v3
    }

    public fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg2, 1);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun change_owner<T0, T1>(arg0: address, arg1: &mut Project<T0, T1>, arg2: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg2, 1);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1021);
        arg1.owner = arg0;
        let v0 = ChangeProjectOwnerEvent{
            project   : 0x2::object::id_address<Project<T0, T1>>(arg1),
            old_owner : arg1.owner,
            new_owner : arg0,
        };
        0x2::event::emit<ChangeProjectOwnerEvent>(v0);
    }

    public fun claim_refund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg1, 1);
        validate_refund<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.launch_state;
        let v2 = 0x2::table::borrow_mut<address, Order>(&mut v1.order_book, v0);
        let v3 = v2.coin_amount;
        assert!(v3 > 0, 1006);
        v1.total_token_sold = v1.total_token_sold - v2.token_amount;
        v2.coin_amount = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.coin_raised, v3, arg2), v0);
        let v4 = ClaimRefundEvent{
            project   : 0x2::object::id_address<Project<T0, T1>>(arg0),
            user      : v0,
            coin_fund : v3,
        };
        0x2::event::emit<ClaimRefundEvent>(v4);
    }

    public fun claim_token<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg2, 1);
        validate_claim<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg0.launch_state;
        let v2 = &mut v1.order_book;
        assert!(0x2::table::contains<address, Order>(v2, v0), 1017);
        let v3 = 0x2::table::borrow_mut<address, Order>(v2, v0);
        let v4 = 0x2::math::min(cal_claim_percent(&arg0.vesting, 0x2::clock::timestamp_ms(arg1)), 10000);
        assert!(v4 > 0, 1014);
        let v5 = v3.token_amount * v4 / 10000 - v3.token_released;
        assert!(v5 > 0, 1006);
        v3.token_released = v3.token_released + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1.token_fund, v5, arg3), v0);
        let v6 = ClaimTokenEvent{
            project      : 0x2::object::id_address<Project<T0, T1>>(arg0),
            user         : v0,
            token_amount : v5,
        };
        0x2::event::emit<ClaimTokenEvent>(v6);
    }

    public fun clear_max_allocate<T0, T1>(arg0: &AdminCap, arg1: vector<address>, arg2: &mut Project<T0, T1>, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        let v0 = &mut arg2.launch_state.max_allocations;
        let v1 = RemoveMaxAllocateEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg2),
            users   : arg1,
        };
        0x2::event::emit<RemoveMaxAllocateEvent>(v1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, u64>(v0, v2)) {
                0x2::table::remove<address, u64>(v0, v2);
            };
        };
    }

    public fun create_project<T0, T1>(arg0: &AdminCap, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: bool, arg10: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg10, 1);
        assert!(arg2 >= 1 && arg2 <= 4, 1000);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg11) && arg3 >= 0 && arg5 <= 10000, 1023);
        assert!(arg7 > 0 && arg8 > 0, 1024);
        let v0 = LaunchState<T0, T1>{
            id                    : 0x2::object::new(arg12),
            soft_cap              : 0,
            hard_cap              : 0,
            round                 : 0,
            state                 : 1,
            total_token_sold      : 0,
            swap_ratio_coin       : 0,
            swap_ratio_token      : 0,
            participants          : 0,
            start_time            : 0,
            end_time              : 0,
            token_fund            : 0x2::coin::zero<T1>(arg12),
            total_token_deposited : 0,
            coin_raised           : 0x2::coin::zero<T0>(arg12),
            order_book            : 0x2::table::new<address, Order>(arg12),
            default_max_allocate  : 0,
            max_allocations       : 0x2::table::new<address, u64>(arg12),
        };
        let v1 = Community{
            id         : 0x2::object::new(arg12),
            total_vote : 0,
            voters     : 0x2::vec_set::empty<address>(),
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut v1.id, b"votes", 0x2::vec_set::empty<address>());
        let v2 = Vesting{
            id             : 0x2::object::new(arg12),
            type           : arg2,
            tge            : arg4,
            cliff_time     : arg3,
            unlock_percent : arg5,
            linear_time    : arg6,
            milestones     : 0x1::vector::empty<VestingMileStone>(),
        };
        let v3 = Project<T0, T1>{
            id             : 0x2::object::new(arg12),
            launch_state   : v0,
            community      : v1,
            use_whitelist  : false,
            owner          : arg1,
            coin_decimals  : arg7,
            token_decimals : arg8,
            vesting        : v2,
            whitelist      : 0x2::table::new<address, address>(arg12),
            require_kyc    : arg9,
        };
        0x2::event::emit<ProjectCreatedEvent>(build_event_create_project<T0, T1>(&v3));
        0x2::transfer::share_object<Project<T0, T1>>(v3);
    }

    public fun deposit_token<T0, T1>(arg0: vector<0x2::coin::Coin<T1>>, arg1: u64, arg2: &mut Project<T0, T1>, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        0x2::coin::join<T1>(&mut arg2.launch_state.token_fund, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<T1>(arg0, arg1, arg4));
        arg2.launch_state.total_token_deposited = arg2.launch_state.total_token_deposited + arg1;
        let v0 = ProjectDepositFundEvent{
            project      : 0x2::object::id_address<Project<T0, T1>>(arg2),
            depositor    : 0x2::tx_context::sender(arg4),
            token_amount : arg1,
        };
        0x2::event::emit<ProjectDepositFundEvent>(v0);
    }

    public fun distribute_raised_fund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg1, 1);
        validate_distribute_fund<T0, T1>(arg0, arg2);
        let v0 = &mut arg0.launch_state;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_raised, 0x2::coin::value<T0>(&v0.coin_raised), arg2), arg0.owner);
        let v1 = DistributeRaisedFundEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg0),
            epoch   : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DistributeRaisedFundEvent>(v1);
    }

    public fun end_fund_raising<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        validate_end_fundraising<T0, T1>(arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = &mut arg1.launch_state;
        let v1 = if (0x2::coin::value<T0>(&v0.coin_raised) < v0.soft_cap) {
            4
        } else {
            6
        };
        v0.state = v1;
        let v2 = LaunchStateEvent{
            project    : 0x2::object::id_address<Project<T0, T1>>(arg1),
            total_sold : v0.total_token_sold,
            epoch      : 0x2::clock::timestamp_ms(arg2),
            state      : v0.state,
            end_time   : v0.end_time,
        };
        0x2::event::emit<LaunchStateEvent>(v2);
    }

    fun get_max_allocate<T0, T1>(arg0: address, arg1: &0x2::table::Table<address, u64>, arg2: u64) : u64 {
        if (0x2::table::contains<address, u64>(arg1, arg0)) {
            *0x2::table::borrow<address, u64>(arg1, arg0)
        } else {
            arg2
        }
    }

    fun init(arg0: PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun refund_token_to_owner<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg1, 1);
        validate_refund_to_owner<T0, T1>(arg0, arg2);
        let v0 = &mut arg0.launch_state;
        let v1 = &mut v0.token_fund;
        let v2 = 0;
        if (v0.state == 4) {
            v2 = 0x2::coin::value<T1>(v1);
        };
        if (v0.state == 6) {
            v2 = v0.total_token_deposited - v0.total_token_sold;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(v1, v2, arg2), arg0.owner);
    }

    public fun remove_whitelist<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: vector<address>, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        assert!(arg1.use_whitelist, 1007);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1029);
        let v0 = RemoveWhiteListEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg1),
            users   : arg2,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v0);
        let v1 = &mut arg1.whitelist;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(0x2::table::contains<address, address>(v1, v2), 1020);
            0x2::table::remove<address, address>(v1, v2);
        };
    }

    public fun reset_milestone<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg2, 1);
        arg1.vesting.milestones = 0x1::vector::empty<VestingMileStone>();
    }

    public fun setCliffTime<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: &mut Project<T0, T1>, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version) {
        assert!(arg1 > 0, 1023);
        arg2.vesting.cliff_time = arg1;
    }

    public fun setup_project<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: u8, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg12, 1);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg11) && arg8 > arg7, 1013);
        assert!(arg10 > arg9 && arg9 > 0, 1025);
        assert!(arg4 > 0 && arg5 > 0, 1026);
        assert!(arg2 >= 1 && arg2 <= 3, 1001);
        let v0 = &mut arg1.launch_state;
        assert!(v0.state == 1, 1002);
        v0.default_max_allocate = arg6;
        v0.round = arg2;
        v0.swap_ratio_coin = arg4;
        v0.swap_ratio_token = arg5;
        v0.start_time = arg7;
        v0.end_time = arg8;
        v0.soft_cap = arg9;
        v0.hard_cap = arg10;
        arg1.use_whitelist = arg3;
        let v1 = SetupProjectEvent{
            project          : 0x2::object::id_address<Project<T0, T1>>(arg1),
            usewhitelist     : arg3,
            round            : arg2,
            swap_ratio_coin  : arg4,
            swap_ratio_token : arg5,
            max_allocate     : arg6,
            start_time       : arg7,
            end_time         : arg8,
            soft_cap         : arg9,
            hard_cap         : arg10,
        };
        0x2::event::emit<SetupProjectEvent>(v1);
    }

    public fun start_fund_raising<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg3, 1);
        validate_start_fund_raising<T0, T1>(arg1);
        arg1.launch_state.total_token_sold = 0;
        arg1.launch_state.participants = 0;
        arg1.launch_state.state = 3;
        let v0 = StartFundRaisingEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg1),
            epoch   : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StartFundRaisingEvent>(v0);
    }

    fun sum_milestones_percent(arg0: &vector<VestingMileStone>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<VestingMileStone>(arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            v0 = v0 + 0x1::vector::borrow<VestingMileStone>(arg0, v1).percent;
        };
        v0
    }

    fun swap_token<T0, T1>(arg0: u64, arg1: &Project<T0, T1>) : u64 {
        (((arg0 as u128) * (arg1.launch_state.swap_ratio_token as u128) * (0x2::math::pow(10, arg1.token_decimals) as u128) / (arg1.launch_state.swap_ratio_coin as u128) * (0x2::math::pow(10, arg1.coin_decimals) as u128)) as u64)
    }

    fun validate_buy<T0, T1>(arg0: &mut Project<T0, T1>, arg1: address, arg2: u64) {
        let v0 = &arg0.launch_state;
        assert!(v0.state == 3, 1002);
        assert!(v0.start_time <= arg2 && v0.end_time >= arg2, 1013);
        assert!(!arg0.use_whitelist || 0x2::table::contains<address, address>(&arg0.whitelist, arg1), 1009);
    }

    fun validate_claim<T0, T1>(arg0: &mut Project<T0, T1>) {
        assert!(arg0.launch_state.state == 6, 1002);
    }

    fun validate_distribute_fund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1021);
        assert!(arg0.launch_state.state == 6, 1002);
        assert!(0x2::coin::value<T0>(&arg0.launch_state.coin_raised) > 0, 1031);
    }

    fun validate_end_fundraising<T0, T1>(arg0: &mut Project<T0, T1>, arg1: u64) {
        let v0 = &arg0.launch_state;
        assert!(v0.end_time <= arg1 || v0.start_time > arg1, 1013);
        assert!(v0.state == 3, 1002);
    }

    fun validate_mile_stones(arg0: &Vesting, arg1: u64, arg2: u64) {
        assert!(sum_milestones_percent(&arg0.milestones) + arg0.unlock_percent <= 10000, 1011);
        let v0 = 0x1::vector::length<VestingMileStone>(&arg0.milestones);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<VestingMileStone>(&arg0.milestones, v1);
            assert!(v2.time > arg2 && v2.time > arg1, 1013);
            assert!(v1 >= v0 - 1 || v2.time < 0x1::vector::borrow<VestingMileStone>(&arg0.milestones, v1 + 1).time, 1012);
            v1 = v1 + 1;
        };
    }

    fun validate_refund<T0, T1>(arg0: &mut Project<T0, T1>) {
        assert!(arg0.launch_state.state == 4, 1002);
    }

    fun validate_refund_to_owner<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1021);
        let v0 = arg0.launch_state.state;
        assert!(v0 == 4 || v0 == 6, 1002);
    }

    fun validate_start_fund_raising<T0, T1>(arg0: &mut Project<T0, T1>) {
        assert!(arg0.launch_state.state == 1, 1002);
        let v0 = &arg0.vesting;
        if (v0.type == 1 || v0.type == 2) {
            assert!(v0.unlock_percent + sum_milestones_percent(&v0.milestones) == 10000, 1023);
        };
        assert!(0x2::coin::value<T1>(&arg0.launch_state.token_fund) >= swap_token<T0, T1>(arg0.launch_state.hard_cap, arg0), 1015);
    }

    public fun vote<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg1, 1);
        let v0 = &mut arg0.community;
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&mut v0.voters, &v1), 1005);
        v0.total_vote = v0.total_vote + 1;
        0x2::vec_set::insert<address>(&mut v0.voters, v1);
    }

    public fun withdraw_token<T0, T1>(arg0: &AdminCap, arg1: &mut Project<T0, T1>, arg2: &mut 0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::Version, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x196ef3a5167c3e5660404078334b955ea7de6b035725ef74fa951308f4c2ad03::version::checkVersion(arg2, 1);
        let v0 = &mut arg1.launch_state.token_fund;
        assert!(arg4 > 0 && 0x2::coin::value<T1>(v0) > arg4, 1016);
        assert!(arg3 == arg1.owner, 1018);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(v0, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

