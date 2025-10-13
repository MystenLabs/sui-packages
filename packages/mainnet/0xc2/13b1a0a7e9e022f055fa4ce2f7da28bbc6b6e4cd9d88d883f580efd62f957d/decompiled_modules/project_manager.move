module 0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::project_manager {
    struct ProjectManagerConfig has key {
        id: 0x2::object::UID,
        version: u64,
        configs: 0x2::table::Table<u8, ProjectConfig>,
        projects: 0x2::table::Table<address, address>,
    }

    struct ProjectManager<phantom T0> has key {
        id: 0x2::object::UID,
        target_funds: u64,
        start_times: u64,
        fund_coin_type: 0x1::type_name::TypeName,
        total_funds: 0x2::balance::Balance<T0>,
        remain_supply: u64,
        total_supply: u64,
        end_times: u64,
        count: u64,
        status: u8,
        pay_status: u8,
        level: u8,
        owner: address,
        whitelist: 0x2::table::Table<address, u64>,
        whitelist_buy_amount: 0x2::table::Table<address, u64>,
    }

    struct FundingProof has key {
        id: 0x2::object::UID,
        token: u64,
        claimed: u64,
        project_manager: 0x2::object::ID,
    }

    struct PayNft has key {
        id: 0x2::object::UID,
        status: u8,
        owner: address,
        count: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ProjectConfig has copy, store {
        level: u8,
        max_funding_amount: u64,
        token_price: u64,
        target_fund: u64,
        total_supply: u64,
    }

    struct ProjectInitializedEvent has copy, drop {
        project_manager: address,
        target_funds: u64,
        total_supply_amount: u64,
        start_times: u64,
        end_times: u64,
        level: u8,
        count: u64,
        fund_coin_type: 0x1::type_name::TypeName,
    }

    struct UserFundedEvent has copy, drop {
        project_manager: address,
        token_amount: u64,
        count: u64,
        user: address,
    }

    struct UserRefundedEvent has copy, drop {
        project_manager: address,
        token_amount: u64,
        count: u64,
        user: address,
    }

    struct ProjectShouldSucceedEvent has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        count: u64,
    }

    struct BatchAddWhitelistEvent has copy, drop {
        project_manager: address,
        users: vector<address>,
        amounts: vector<u64>,
        count: u64,
    }

    struct BatchRemoveWhitelistEvent has copy, drop {
        project_manager: address,
        users: vector<address>,
        count: u64,
    }

    struct ProjectConfigChangedEvent has copy, drop {
        level: u8,
        max_funding_amount: u64,
        token_price: u64,
        target_fund: u64,
    }

    struct ProjectFailedEvent has copy, drop {
        project_manager: address,
        count: u64,
        owner: address,
    }

    struct OwnerChangedEvent has copy, drop {
        project_manager: address,
        last_owner: address,
        new_owner: address,
    }

    public fun assert_version(arg0: &ProjectManagerConfig) {
        assert!(arg0.version == 0, 8);
    }

    public fun batch_add_whitelist<T0>(arg0: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut ProjectManager<T0>, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 <= 200, 13);
        let v1 = 0;
        while (v1 < v0) {
            if (0x2::table::contains<address, u64>(&arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v1)) && 0x2::table::contains<address, u64>(&arg1.whitelist_buy_amount, *0x1::vector::borrow<address>(&arg2, v1))) {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v1)) = *0x1::vector::borrow<u64>(&arg3, v1);
            } else if (0x2::table::contains<address, u64>(&arg1.whitelist_buy_amount, *0x1::vector::borrow<address>(&arg2, v1)) && !0x2::table::contains<address, u64>(&arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v1))) {
                0x2::table::add<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            } else {
                0x2::table::add<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
                0x2::table::add<address, u64>(&mut arg1.whitelist_buy_amount, *0x1::vector::borrow<address>(&arg2, v1), 0);
            };
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v3 = BatchAddWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v2),
            users           : arg2,
            amounts         : arg3,
            count           : arg1.count,
        };
        0x2::event::emit<BatchAddWhitelistEvent>(v3);
    }

    public fun batch_remove_whitelist<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchManagerAdmin, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 <= 200, 13);
        let v1 = 0;
        while (v1 < v0) {
            0x2::table::remove<address, u64>(&mut arg0.whitelist, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::id<ProjectManager<T0>>(arg0);
        let v3 = BatchRemoveWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v2),
            users           : arg2,
            count           : arg0.count,
        };
        0x2::event::emit<BatchRemoveWhitelistEvent>(v3);
    }

    public(friend) fun burn_pay_nft(arg0: PayNft) : (0x2::object::ID, u8, address, u64, u64, 0x1::type_name::TypeName) {
        let PayNft {
            id        : v0,
            status    : v1,
            owner     : v2,
            count     : v3,
            coin_type : v4,
            amount    : v5,
        } = arg0;
        let v6 = v0;
        0x2::object::delete(v6);
        (0x2::object::uid_to_inner(&v6), v1, v2, v3, v5, v4)
    }

    public(friend) fun burn_proof(arg0: FundingProof) {
        let FundingProof {
            id              : v0,
            token           : _,
            claimed         : _,
            project_manager : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun change_owner<T0>(arg0: &mut ProjectManager<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 15);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.owner != arg1, 1);
        let v0 = 0x2::object::id<ProjectManager<T0>>(arg0);
        let v1 = OwnerChangedEvent{
            project_manager : 0x2::object::id_to_address(&v0),
            last_owner      : arg0.owner,
            new_owner       : arg1,
        };
        0x2::event::emit<OwnerChangedEvent>(v1);
        arg0.owner = arg1;
    }

    public fun change_pay_nft_status(arg0: &mut PayNft, arg1: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchAdmin) {
        arg0.status = 1;
    }

    public entry fun first_fund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = fund_script<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = FundingProof{
            id              : 0x2::object::new(arg4),
            token           : v0,
            claimed         : 0,
            project_manager : 0x2::object::id<ProjectManager<T0>>(arg1),
        };
        0x2::transfer::transfer<FundingProof>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun fund<T0>(arg0: &mut FundingProof, arg1: 0x2::coin::Coin<T0>, arg2: &mut ProjectManager<T0>, arg3: &ProjectManagerConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.project_manager == 0x2::object::id<ProjectManager<T0>>(arg2), 5);
        arg0.token = arg0.token + fund_script<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun fund_script<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.status == 0, 3);
        assert_version(arg2);
        assert!(0x2::coin::value<T0>(&arg0) > 0, 12);
        let (_, v1, _, _) = get_project_fund_config_by_level(arg1.level, arg2);
        let v4 = 0x2::coin::value<T0>(&arg0) * 1000 / v1;
        assert!(v4 % 50 == 0, 12);
        assert!(0x2::table::contains<address, u64>(&arg1.whitelist, 0x2::tx_context::sender(arg4)), 9);
        let v5 = *0x2::table::borrow<address, u64>(&arg1.whitelist_buy_amount, 0x2::tx_context::sender(arg4));
        assert!(*0x2::table::borrow<address, u64>(&arg1.whitelist, 0x2::tx_context::sender(arg4)) >= v4 + v5, 10);
        assert!(arg1.remain_supply >= v4, 4);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.start_times, 7);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.end_times, 6);
        *0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist_buy_amount, 0x2::tx_context::sender(arg4)) = v5 + v4;
        arg1.remain_supply = arg1.remain_supply - v4;
        0x2::balance::join<T0>(&mut arg1.total_funds, 0x2::coin::into_balance<T0>(arg0));
        if (arg1.remain_supply == 0) {
            arg1.status = 1;
            let v6 = ProjectShouldSucceedEvent{
                project_id : 0x2::object::id<ProjectManager<T0>>(arg1),
                owner      : arg1.owner,
                count      : arg1.count,
            };
            0x2::event::emit<ProjectShouldSucceedEvent>(v6);
        };
        let v7 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v8 = UserFundedEvent{
            project_manager : 0x2::object::id_to_address(&v7),
            token_amount    : v4,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UserFundedEvent>(v8);
        v4
    }

    public fun get_pay_nft_amount(arg0: &PayNft) : u64 {
        arg0.amount
    }

    public fun get_pay_nft_count(arg0: &PayNft) : u64 {
        arg0.count
    }

    public fun get_pay_nft_owner(arg0: &PayNft) : address {
        arg0.owner
    }

    public fun get_pay_nft_status(arg0: &PayNft) : u8 {
        arg0.status
    }

    public fun get_project_count<T0>(arg0: &ProjectManager<T0>) : u64 {
        arg0.count
    }

    public fun get_project_fund_config_by_level(arg0: u8, arg1: &ProjectManagerConfig) : (u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u8, ProjectConfig>(&arg1.configs, arg0);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v1, 11);
        (v0.max_funding_amount, v0.token_price, v0.target_fund, v0.total_supply)
    }

    public fun get_project_manager_id<T0>(arg0: &ProjectManager<T0>) : 0x2::object::ID {
        0x2::object::id<ProjectManager<T0>>(arg0)
    }

    public fun get_project_manager_level<T0>(arg0: &ProjectManager<T0>) : u8 {
        arg0.level
    }

    public fun get_project_manager_owner<T0>(arg0: &ProjectManager<T0>) : address {
        arg0.owner
    }

    public fun get_project_manager_pay_status<T0>(arg0: &ProjectManager<T0>) : u8 {
        arg0.pay_status
    }

    public fun get_project_status<T0>(arg0: &ProjectManager<T0>) : u8 {
        arg0.status
    }

    public(friend) fun get_project_total_funds<T0>(arg0: &mut ProjectManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.total_funds, 0x2::balance::value<T0>(&arg0.total_funds), arg1)
    }

    public fun get_project_total_supply<T0>(arg0: &ProjectManager<T0>) : u64 {
        arg0.total_supply
    }

    public fun get_proof_claimed(arg0: &FundingProof) : u64 {
        arg0.claimed
    }

    public fun get_proof_project_id(arg0: &FundingProof) : 0x2::object::ID {
        arg0.project_manager
    }

    public fun get_proof_token(arg0: &FundingProof) : u64 {
        arg0.token
    }

    public fun get_user_whitelist_amount<T0>(arg0: &ProjectManager<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, ProjectConfig>(arg0);
        let v1 = ProjectConfig{
            level              : 0,
            max_funding_amount : 90000000000,
            token_price        : 60,
            target_fund        : 5400000000,
            total_supply       : 100000000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 0, v1);
        let v2 = ProjectConfig{
            level              : 1,
            max_funding_amount : 90000000000,
            token_price        : 60,
            target_fund        : 5400000000,
            total_supply       : 100000000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 1, v2);
        let v3 = ProjectConfig{
            level              : 2,
            max_funding_amount : 90000000000,
            token_price        : 60,
            target_fund        : 5400000000,
            total_supply       : 100000000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 2, v3);
        let v4 = ProjectManagerConfig{
            id       : 0x2::object::new(arg0),
            version  : 0,
            configs  : v0,
            projects : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<ProjectManagerConfig>(v4);
    }

    public entry fun initialize_project_manager<T0>(arg0: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchAdmin, arg1: &mut PayNft, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &mut ProjectManagerConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg6);
        let v0 = if (arg5 == 0) {
            true
        } else if (arg5 == 1) {
            true
        } else {
            arg5 == 2
        };
        assert!(v0, 11);
        assert!(arg1.status == 0, 3);
        assert!(arg1.count == arg2, 5);
        update_paynft_status(arg1, 1);
        let (v1, _, v3, v4) = get_project_fund_config_by_level(arg5, arg6);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = 0x2::object::new(arg7);
        let v7 = 0x2::object::uid_to_address(&v6);
        0x2::table::add<address, address>(&mut arg6.projects, v7, arg1.owner);
        let v8 = ProjectInitializedEvent{
            project_manager     : v7,
            target_funds        : v3,
            total_supply_amount : v1,
            start_times         : arg3,
            end_times           : arg4,
            level               : arg5,
            count               : arg2,
            fund_coin_type      : v5,
        };
        0x2::event::emit<ProjectInitializedEvent>(v8);
        let v9 = ProjectManager<T0>{
            id                   : v6,
            target_funds         : v3,
            start_times          : arg3,
            fund_coin_type       : v5,
            total_funds          : 0x2::balance::zero<T0>(),
            remain_supply        : v1,
            total_supply         : v4,
            end_times            : arg4,
            count                : arg2,
            status               : 0,
            pay_status           : 0,
            level                : arg5,
            owner                : arg1.owner,
            whitelist            : 0x2::table::new<address, u64>(arg7),
            whitelist_buy_amount : 0x2::table::new<address, u64>(arg7),
        };
        0x2::transfer::share_object<ProjectManager<T0>>(v9);
    }

    public(friend) fun migrate(arg0: &mut ProjectManagerConfig) {
        assert!(arg0.version < 0, 8);
        arg0.version = 0;
    }

    public fun project_falied<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchAdmin, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_times, 6);
        assert!(arg0.status == 0, 3);
        arg0.status = 2;
        let v0 = 0x2::object::id<ProjectManager<T0>>(arg0);
        let v1 = ProjectFailedEvent{
            project_manager : 0x2::object::id_to_address(&v0),
            count           : arg0.count,
            owner           : arg0.owner,
        };
        0x2::event::emit<ProjectFailedEvent>(v1);
    }

    public entry fun refund<T0>(arg0: FundingProof, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(get_project_status<T0>(arg1) == 2, 2);
        assert!(arg0.project_manager == 0x2::object::id<ProjectManager<T0>>(arg1), 5);
        let (_, v1, _, _) = get_project_fund_config_by_level(arg1.level, arg2);
        let v4 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v5 = UserRefundedEvent{
            project_manager : 0x2::object::id_to_address(&v4),
            token_amount    : arg0.token,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UserRefundedEvent>(v5);
        burn_proof(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_funds, (((arg0.token as u128) * (v1 as u128) / (1000 as u128)) as u64), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun set_project_config(arg0: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut ProjectManagerConfig, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::table::borrow_mut<u8, ProjectConfig>(&mut arg1.configs, arg2);
        v0.max_funding_amount = arg3;
        assert!(arg3 % 50 == 0, 14);
        v0.token_price = arg4;
        v0.target_fund = arg5;
        let v1 = ProjectConfigChangedEvent{
            level              : arg2,
            max_funding_amount : arg3,
            token_price        : arg4,
            target_fund        : arg5,
        };
        0x2::event::emit<ProjectConfigChangedEvent>(v1);
    }

    public(friend) fun share_pay_nft<T0>(arg0: u8, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = PayNft{
            id        : v0,
            status    : arg0,
            owner     : arg1,
            count     : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg3,
        };
        0x2::transfer::share_object<PayNft>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun update_paynft_status(arg0: &mut PayNft, arg1: u8) {
        arg0.status = arg1;
    }

    public(friend) fun update_proof_claimed(arg0: &mut FundingProof, arg1: u64) {
        arg0.claimed = arg0.claimed + arg1;
    }

    // decompiled from Move bytecode v6
}

