module 0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::project_manager {
    struct ProjectAdmin has key {
        id: 0x2::object::UID,
        project_manager: address,
        claimed_incentive_amount: u64,
    }

    struct ProjectManagerConfig has key {
        id: 0x2::object::UID,
        version: u64,
        configs: 0x2::table::Table<u8, ProjectConfig>,
    }

    struct ProjectManager<phantom T0> has key {
        id: 0x2::object::UID,
        target_funds: u64,
        start_times: u64,
        fund_coin_type: 0x1::type_name::TypeName,
        total_funds: 0x2::balance::Balance<T0>,
        remain_supply: u64,
        end_times: u64,
        count: u64,
        status: u8,
        pay_status: u8,
        level: u8,
        owner: address,
        whitelist: 0x2::table::Table<address, u64>,
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
        amount: u64,
    }

    struct ProjectConfig has copy, store {
        level: u8,
        max_funding_amount: u64,
        token_price: u64,
        target_fund: u64,
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

    struct AddWhitelistEvent has copy, drop {
        project_manager: address,
        user: address,
        amount: u64,
        count: u64,
    }

    struct BatchAddWhitelistEvent has copy, drop {
        project_manager: address,
        users: vector<address>,
        amounts: vector<u64>,
        count: u64,
    }

    struct RemoveWhitelistEvent has copy, drop {
        project_manager: address,
        user: address,
        count: u64,
    }

    struct BatchRemoveWhitelistEvent has copy, drop {
        project_manager: address,
        users: vector<address>,
        count: u64,
    }

    public fun add_whitelist<T0>(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg1: &mut ProjectManager<T0>, arg2: address, arg3: u64) {
        0x2::table::add<address, u64>(&mut arg1.whitelist, arg2, arg3);
        let v0 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v1 = AddWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v0),
            user            : arg2,
            amount          : arg3,
            count           : arg1.count,
        };
        0x2::event::emit<AddWhitelistEvent>(v1);
    }

    public fun assert_version(arg0: &ProjectManagerConfig) {
        assert!(arg0.version == 0, 8);
    }

    public fun batch_add_whitelist<T0>(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg1: &mut ProjectManager<T0>, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::add<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
        let v1 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v2 = BatchAddWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v1),
            users           : arg2,
            amounts         : arg3,
            count           : arg1.count,
        };
        0x2::event::emit<BatchAddWhitelistEvent>(v2);
    }

    public fun batch_remove_whitelist<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.whitelist, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
        let v1 = 0x2::object::id<ProjectManager<T0>>(arg0);
        let v2 = BatchRemoveWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v1),
            users           : arg2,
            count           : arg0.count,
        };
        0x2::event::emit<BatchRemoveWhitelistEvent>(v2);
    }

    public fun burn_pay_nft(arg0: PayNft) : (0x2::object::ID, u8, address, u64, u64) {
        let PayNft {
            id     : v0,
            status : v1,
            owner  : v2,
            count  : v3,
            amount : v4,
        } = arg0;
        let v5 = v0;
        0x2::object::delete(v5);
        (0x2::object::uid_to_inner(&v5), v1, v2, v3, v4)
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

    public fun change_owner<T0>(arg0: &mut ProjectManager<T0>, arg1: address, arg2: &ProjectAdmin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.owner != arg1, 1);
        arg0.owner = arg1;
    }

    public entry fun first_fund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 3);
        assert_version(arg2);
        let (_, v1, _) = get_project_fund_config_by_level(arg1.level, arg2);
        let v3 = 0x2::coin::value<T0>(&arg0) * 1000 / v1;
        assert!(0x2::table::contains<address, u64>(&arg1.whitelist, 0x2::tx_context::sender(arg4)), 9);
        let v4 = *0x2::table::borrow<address, u64>(&arg1.whitelist, 0x2::tx_context::sender(arg4));
        assert!(v4 >= v3, 10);
        assert!(arg1.remain_supply >= v3, 4);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.start_times, 7);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.end_times, 6);
        *0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist, 0x2::tx_context::sender(arg4)) = v4 - v3;
        arg1.remain_supply = arg1.remain_supply - v3;
        0x2::balance::join<T0>(&mut arg1.total_funds, 0x2::coin::into_balance<T0>(arg0));
        if (arg1.remain_supply == 0) {
            arg1.status = 1;
            let v5 = ProjectShouldSucceedEvent{
                project_id : 0x2::object::id<ProjectManager<T0>>(arg1),
                owner      : arg1.owner,
                count      : arg1.count,
            };
            0x2::event::emit<ProjectShouldSucceedEvent>(v5);
        };
        let v6 = FundingProof{
            id              : 0x2::object::new(arg4),
            token           : v3,
            claimed         : 0,
            project_manager : 0x2::object::id<ProjectManager<T0>>(arg1),
        };
        0x2::transfer::transfer<FundingProof>(v6, 0x2::tx_context::sender(arg4));
        let v7 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v8 = UserFundedEvent{
            project_manager : 0x2::object::id_to_address(&v7),
            token_amount    : v3,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UserFundedEvent>(v8);
    }

    public entry fun fund<T0>(arg0: &mut FundingProof, arg1: 0x2::coin::Coin<T0>, arg2: &mut ProjectManager<T0>, arg3: &ProjectManagerConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        assert!(arg2.status == 0, 3);
        assert!(arg0.project_manager == 0x2::object::id<ProjectManager<T0>>(arg2), 5);
        let (_, v1, _) = get_project_fund_config_by_level(arg2.level, arg3);
        let v3 = 0x2::coin::value<T0>(&arg1) * 1000 / v1;
        assert!(0x2::table::contains<address, u64>(&arg2.whitelist, 0x2::tx_context::sender(arg5)), 9);
        let v4 = *0x2::table::borrow<address, u64>(&arg2.whitelist, 0x2::tx_context::sender(arg5));
        assert!(v4 >= v3, 10);
        *0x2::table::borrow_mut<address, u64>(&mut arg2.whitelist, 0x2::tx_context::sender(arg5)) = v4 - v3;
        assert!(arg2.remain_supply >= v3, 4);
        arg2.remain_supply = arg2.remain_supply - v3;
        0x2::balance::join<T0>(&mut arg2.total_funds, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.start_times, 7);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2.end_times, 6);
        if (arg2.remain_supply == 0) {
            arg2.status = 1;
            let v5 = ProjectShouldSucceedEvent{
                project_id : 0x2::object::id<ProjectManager<T0>>(arg2),
                owner      : arg2.owner,
                count      : arg2.count,
            };
            0x2::event::emit<ProjectShouldSucceedEvent>(v5);
        };
        arg0.token = arg0.token + v3;
        let v6 = 0x2::object::id<ProjectManager<T0>>(arg2);
        let v7 = UserFundedEvent{
            project_manager : 0x2::object::id_to_address(&v6),
            token_amount    : v3,
            count           : arg2.count,
            user            : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UserFundedEvent>(v7);
    }

    public fun get_admin_claimed_incentive_amount(arg0: &ProjectAdmin) : u64 {
        arg0.claimed_incentive_amount
    }

    public fun get_admin_project_manager(arg0: &ProjectAdmin) : address {
        arg0.project_manager
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

    public fun get_project_fund_config_by_level(arg0: u8, arg1: &ProjectManagerConfig) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<u8, ProjectConfig>(&arg1.configs, arg0);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v1, 11);
        if (arg0 == 0) {
            (v0.max_funding_amount, v0.token_price, v0.target_fund)
        } else if (arg0 == 1) {
            (v0.max_funding_amount, v0.token_price, v0.target_fund)
        } else {
            (v0.max_funding_amount, v0.token_price, v0.target_fund)
        }
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

    public fun get_proof_claimed(arg0: &FundingProof) : u64 {
        arg0.claimed
    }

    public fun get_proof_project_id(arg0: &FundingProof) : 0x2::object::ID {
        arg0.project_manager
    }

    public fun get_proof_token(arg0: &FundingProof) : u64 {
        arg0.token
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, ProjectConfig>(arg0);
        let v1 = ProjectConfig{
            level              : 0,
            max_funding_amount : 9000000000,
            token_price        : 60,
            target_fund        : 540000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 0, v1);
        let v2 = ProjectConfig{
            level              : 1,
            max_funding_amount : 9000000000,
            token_price        : 60,
            target_fund        : 540000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 1, v2);
        let v3 = ProjectConfig{
            level              : 2,
            max_funding_amount : 9000000000,
            token_price        : 60,
            target_fund        : 540000000,
        };
        0x2::table::add<u8, ProjectConfig>(&mut v0, 2, v3);
        let v4 = ProjectManagerConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            configs : v0,
        };
        0x2::transfer::share_object<ProjectManagerConfig>(v4);
    }

    public entry fun initialize_project_manager<T0>(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg1: &mut PayNft, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &ProjectManagerConfig, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg7);
        let v0 = if (arg6 == 0) {
            true
        } else if (arg6 == 1) {
            true
        } else {
            arg6 == 2
        };
        assert!(v0, 11);
        assert!(arg1.status == 0, 3);
        assert!(arg1.owner == arg2, 0);
        assert!(arg1.count == arg3, 5);
        update_paynft_status(arg1, 1);
        let (v1, _, v3) = get_project_fund_config_by_level(arg6, arg7);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x2::object::new(arg8);
        let v6 = 0x2::object::uid_to_address(&v5);
        let v7 = ProjectAdmin{
            id                       : 0x2::object::new(arg8),
            project_manager          : v6,
            claimed_incentive_amount : 0,
        };
        0x2::transfer::transfer<ProjectAdmin>(v7, arg2);
        let v8 = ProjectInitializedEvent{
            project_manager     : v6,
            target_funds        : v3,
            total_supply_amount : v1,
            start_times         : arg4,
            end_times           : arg5,
            level               : arg6,
            count               : arg3,
            fund_coin_type      : v4,
        };
        0x2::event::emit<ProjectInitializedEvent>(v8);
        let v9 = ProjectManager<T0>{
            id             : v5,
            target_funds   : v3,
            start_times    : arg4,
            fund_coin_type : v4,
            total_funds    : 0x2::balance::zero<T0>(),
            remain_supply  : v1,
            end_times      : arg5,
            count          : arg3,
            status         : 0,
            pay_status     : 0,
            level          : arg6,
            owner          : arg2,
            whitelist      : 0x2::table::new<address, u64>(arg8),
        };
        0x2::transfer::share_object<ProjectManager<T0>>(v9);
    }

    public(friend) fun migrate(arg0: &mut ProjectManagerConfig) {
        assert!(arg0.version < 0, 8);
        arg0.version = 0;
    }

    public fun project_falied<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_times, 6);
        assert!(arg0.status == 0, 3);
        arg0.status = 2;
    }

    public entry fun refund<T0>(arg0: FundingProof, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(get_project_status<T0>(arg1) == 2, 2);
        let (_, v1, _) = get_project_fund_config_by_level(arg1.level, arg2);
        let v3 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v4 = UserRefundedEvent{
            project_manager : 0x2::object::id_to_address(&v3),
            token_amount    : arg0.token,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UserRefundedEvent>(v4);
        burn_proof(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_funds, (((arg0.token as u128) * (v1 as u128) / (1000 as u128)) as u64), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun remove_whitelist<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchAdmin, arg2: address) {
        0x2::table::remove<address, u64>(&mut arg0.whitelist, arg2);
        let v0 = 0x2::object::id<ProjectManager<T0>>(arg0);
        let v1 = RemoveWhitelistEvent{
            project_manager : 0x2::object::id_to_address(&v0),
            user            : arg2,
            count           : arg0.count,
        };
        0x2::event::emit<RemoveWhitelistEvent>(v1);
    }

    public fun set_project_config_hard(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut ProjectManagerConfig, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProjectConfig{
            level              : 2,
            max_funding_amount : arg2,
            token_price        : arg3,
            target_fund        : arg4,
        };
        0x2::table::add<u8, ProjectConfig>(&mut arg1.configs, 2, v0);
    }

    public fun set_project_config_simple(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut ProjectManagerConfig, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProjectConfig{
            level              : 0,
            max_funding_amount : arg2,
            token_price        : arg3,
            target_fund        : arg4,
        };
        0x2::table::add<u8, ProjectConfig>(&mut arg1.configs, 0, v0);
    }

    public fun set_project_config_standard(arg0: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut ProjectManagerConfig, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProjectConfig{
            level              : 1,
            max_funding_amount : arg2,
            token_price        : arg3,
            target_fund        : arg4,
        };
        0x2::table::add<u8, ProjectConfig>(&mut arg1.configs, 1, v0);
    }

    public(friend) fun share_pay_nft(arg0: u8, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = PayNft{
            id     : v0,
            status : arg0,
            owner  : arg1,
            count  : arg2,
            amount : arg3,
        };
        0x2::transfer::share_object<PayNft>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun update_paynft_status(arg0: &mut PayNft, arg1: u8) {
        arg0.status = arg1;
    }

    public(friend) fun update_project_admin_claimed(arg0: &mut ProjectAdmin, arg1: u64) {
        arg0.claimed_incentive_amount = arg0.claimed_incentive_amount + arg1;
    }

    public(friend) fun update_proof_claimed(arg0: &mut FundingProof, arg1: u64) {
        arg0.claimed = arg0.claimed + arg1;
    }

    // decompiled from Move bytecode v6
}

