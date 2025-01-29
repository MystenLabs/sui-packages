module 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project {
    struct PROJECT has drop {
        dummy_field: bool,
    }

    struct ProjectInfo has store {
        name: 0x1::string::String,
        twitter: 0x1::string::String,
        discord: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct Order has drop, store {
        buyer: address,
        coin_amount: u64,
        token_amount: u64,
        token_released: u64,
    }

    struct LaunchState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        total_token_sold: u64,
        swap_ratio_coin: u64,
        swap_ratio_token: u64,
        participants: u64,
        start_time: u64,
        end_time: u64,
        token_fund: 0x2::coin::Coin<T1>,
        coin_raised: 0x2::coin::Coin<T0>,
        order_book: 0x2::table::Table<address, Order>,
    }

    struct Project<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        project_owner_cap: 0x2::object::ID,
        launch_state: LaunchState<T0, T1>,
        project_info: ProjectInfo,
    }

    struct ProjectOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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
        valid_buy_amount: u64,
    }

    struct DistributeRaisedFundEvent has copy, drop {
        project: address,
    }

    struct ProjectCreatedEvent has copy, drop {
        project: address,
    }

    struct ClaimTokenEvent has copy, drop {
        project: address,
        user: address,
        token_amount: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        project: address,
        user: address,
    }

    struct ClaimRefundEvent has copy, drop {
        project: address,
        user: address,
        coin_fund: u64,
    }

    fun build_event_create_project<T0, T1>(arg0: &Project<T0, T1>) : ProjectCreatedEvent {
        ProjectCreatedEvent{project: 0x2::object::id_address<Project<T0, T1>>(arg0)}
    }

    public fun buy<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1030);
        let v0 = 0x2::coin::value<T0>(&arg0) * 10 / 1000;
        let v1 = v0;
        let v2 = 0x2::coin::value<T0>(&arg0) - v0;
        let v3 = 0x2::tx_context::sender(arg3);
        validate_buy<T0, T1>(arg1, 0x2::clock::timestamp_ms(arg2));
        if (0x2::coin::value<T0>(&arg1.launch_state.coin_raised) + 0x2::coin::value<T0>(&arg0) > 5000000000000) {
            v1 = (5000000000000 - 0x2::coin::value<T0>(&arg1.launch_state.coin_raised)) * 10 / 1000;
            v2 = 5000000000000 - 0x2::coin::value<T0>(&arg1.launch_state.coin_raised);
        };
        let v4 = 0x2::coin::split<T0>(&mut arg0, v2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = swap_token<T0, T1>(v5, arg1);
        let v7 = &mut arg1.launch_state;
        v7.total_token_sold = v7.total_token_sold + v6;
        let v8 = &mut v7.order_book;
        if (!0x2::table::contains<address, Order>(v8, v3)) {
            let v9 = Order{
                buyer          : v3,
                coin_amount    : 0,
                token_amount   : 0,
                token_released : 0,
            };
            0x2::table::add<address, Order>(v8, v3, v9);
            v7.participants = v7.participants + 1;
        };
        let v10 = 0x2::table::borrow_mut<address, Order>(v8, v3);
        v10.coin_amount = v10.coin_amount + v5;
        v10.token_amount = v10.token_amount + v6;
        let v11 = v10.coin_amount;
        assert!(v11 <= 50000000000, 1001);
        0x2::coin::join<T0>(&mut v7.coin_raised, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg3), @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        let v12 = 0x2::coin::value<T0>(&v7.coin_raised);
        assert!(5000000000000 >= v12, 1002);
        let v13 = BuyEvent{
            project          : 0x2::object::uid_to_address(&arg1.id),
            buyer            : v3,
            order_value      : v5,
            order_bought     : v11,
            token_bought     : v10.token_amount,
            more_token       : v6,
            total_raised     : v12,
            sold_out         : v12 == 5000000000000,
            participants     : v7.participants,
            valid_buy_amount : v2,
        };
        0x2::event::emit<BuyEvent>(v13);
    }

    public fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun claim_refund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_refund<T0, T1>(arg0);
        let v0 = &mut arg0.launch_state;
        let v1 = 0x2::table::borrow_mut<address, Order>(&mut v0.order_book, 0x2::tx_context::sender(arg1));
        let v2 = v1.coin_amount;
        assert!(v2 > 0, 1004);
        v0.total_token_sold = v0.total_token_sold - v1.token_amount;
        v1.coin_amount = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_raised, v2, arg1), 0x2::tx_context::sender(arg1));
        let v3 = ClaimRefundEvent{
            project   : 0x2::object::id_address<Project<T0, T1>>(arg0),
            user      : 0x2::tx_context::sender(arg1),
            coin_fund : v2,
        };
        0x2::event::emit<ClaimRefundEvent>(v3);
    }

    public fun claim_token<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        validate_claim<T0, T1>(arg0);
        let v0 = &mut arg0.launch_state;
        let v1 = &mut v0.order_book;
        assert!(0x2::table::contains<address, Order>(v1, 0x2::tx_context::sender(arg2)), 1009);
        let v2 = 0x2::table::borrow_mut<address, Order>(v1, 0x2::tx_context::sender(arg2));
        let v3 = v2.token_amount - v2.token_released;
        assert!(v3 > 0, 1004);
        v2.token_released = v2.token_released + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.token_fund, v3, arg2), 0x2::tx_context::sender(arg2));
        let v4 = ClaimTokenEvent{
            project      : 0x2::object::id_address<Project<T0, T1>>(arg0),
            user         : 0x2::tx_context::sender(arg2),
            token_amount : v3,
        };
        0x2::event::emit<ClaimTokenEvent>(v4);
    }

    public fun create_project<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg9), 1007);
        assert!(0x2::coin::value<T0>(&arg1) == 50000000000, 1006);
        assert!(0x2::coin::value<T1>(&arg2) == 1000000000000000, 1008);
        let v0 = LaunchState<T0, T1>{
            id               : 0x2::object::new(arg10),
            total_token_sold : 0,
            swap_ratio_coin  : 5000000000000,
            swap_ratio_token : 1000000000000000 * 500 / 1000,
            participants     : 0,
            start_time       : arg3,
            end_time         : arg3 + 604800000,
            token_fund       : 0x2::coin::zero<T1>(arg10),
            coin_raised      : 0x2::coin::zero<T0>(arg10),
            order_book       : 0x2::table::new<address, Order>(arg10),
        };
        let v1 = ProjectOwnerCap{id: 0x2::object::new(arg10)};
        let v2 = ProjectInfo{
            name     : arg4,
            twitter  : arg5,
            discord  : arg6,
            telegram : arg7,
            website  : arg8,
        };
        let v3 = Project<T0, T1>{
            id                : 0x2::object::new(arg10),
            project_owner_cap : 0x2::object::id<ProjectOwnerCap>(&v1),
            launch_state      : v0,
            project_info      : v2,
        };
        0x2::coin::join<T1>(&mut v3.launch_state.token_fund, arg2);
        0x2::transfer::public_transfer<ProjectOwnerCap>(v1, 0x2::tx_context::sender(arg10));
        0x2::event::emit<ProjectCreatedEvent>(build_event_create_project<T0, T1>(&v3));
        0x2::transfer::share_object<Project<T0, T1>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T1>>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
    }

    public fun distribute_raised_fund<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_distribute_fund<T0, T1>(arg0, arg1);
        let v0 = &mut arg0.launch_state;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_raised, 5000000000000, arg1), @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.token_fund, 1000000000000000 * 450 / 1000, arg1), @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.token_fund, 1000000000000000 * 50 / 1000, arg1), @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        let v1 = DistributeRaisedFundEvent{project: 0x2::object::id_address<Project<T0, T1>>(arg0)};
        0x2::event::emit<DistributeRaisedFundEvent>(v1);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.launch_state;
        let v1 = &mut v0.order_book;
        assert!(0x2::table::contains<address, Order>(v1, 0x2::tx_context::sender(arg2)), 1009);
        let v2 = 0x2::table::borrow_mut<address, Order>(v1, 0x2::tx_context::sender(arg2));
        assert!(v2.coin_amount > 0, 1004);
        let v3 = v2.coin_amount * 100 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_raised, v3, arg2), @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_raised, v2.coin_amount - v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::table::remove<address, Order>(v1, 0x2::tx_context::sender(arg2));
        v0.participants = v0.participants - 1;
        let v4 = EmergencyWithdrawEvent{
            project : 0x2::object::id_address<Project<T0, T1>>(arg0),
            user    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v4);
    }

    fun init(arg0: PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun swap_token<T0, T1>(arg0: u64, arg1: &Project<T0, T1>) : u64 {
        (((arg0 as u128) * (arg1.launch_state.swap_ratio_token as u128) / (arg1.launch_state.swap_ratio_coin as u128)) as u64)
    }

    fun validate_buy<T0, T1>(arg0: &Project<T0, T1>, arg1: u64) {
        let v0 = &arg0.launch_state;
        assert!(v0.start_time <= arg1 && v0.end_time >= arg1, 1007);
    }

    fun validate_claim<T0, T1>(arg0: &Project<T0, T1>) {
        assert!(0x2::coin::value<T0>(&arg0.launch_state.coin_raised) >= 5000000000000, 1003);
    }

    fun validate_distribute_fund<T0, T1>(arg0: &Project<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0.launch_state.coin_raised) >= 5000000000000, 1003);
    }

    public fun validate_project_ownership<T0, T1>(arg0: &Project<T0, T1>, arg1: &ProjectOwnerCap) {
        assert!(arg0.project_owner_cap == 0x2::object::id<ProjectOwnerCap>(arg1), 1010);
    }

    fun validate_refund<T0, T1>(arg0: &Project<T0, T1>) {
        assert!(0x2::coin::value<T0>(&arg0.launch_state.coin_raised) < 5000000000000, 1005);
    }

    // decompiled from Move bytecode v6
}

