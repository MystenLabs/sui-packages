module 0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::project_manager {
    struct ProjectAdmin has key {
        id: 0x2::object::UID,
        project_manager: address,
        claimed_incentive_amount: u64,
    }

    struct ProjectManagerConfig has key {
        id: 0x2::object::UID,
        version: u64,
        max_funding_amount: u64,
        token_price: u64,
        target_fund: u64,
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
        owner: address,
    }

    struct FundingProof has key {
        id: 0x2::object::UID,
        token: u64,
        claimed: u64,
        project_manager: 0x2::object::ID,
    }

    struct ProjectInitializedEvent has copy, drop {
        project_manager: address,
        target_funds: u64,
        start_times: u64,
        end_times: u64,
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

    public fun assert_version(arg0: &ProjectManagerConfig) {
        assert!(arg0.version == 0, 8);
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
        let v0 = 0x2::coin::value<T0>(&arg0) * 10000 / arg2.token_price;
        assert!(arg1.remain_supply >= v0, 4);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.start_times, 7);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.end_times, 6);
        arg1.remain_supply = arg1.remain_supply - v0;
        0x2::balance::join<T0>(&mut arg1.total_funds, 0x2::coin::into_balance<T0>(arg0));
        if (arg1.remain_supply == 0) {
            arg1.status = 1;
            let v1 = ProjectShouldSucceedEvent{
                project_id : 0x2::object::id<ProjectManager<T0>>(arg1),
                owner      : arg1.owner,
                count      : arg1.count,
            };
            0x2::event::emit<ProjectShouldSucceedEvent>(v1);
        };
        let v2 = FundingProof{
            id              : 0x2::object::new(arg4),
            token           : v0,
            claimed         : 0,
            project_manager : 0x2::object::id<ProjectManager<T0>>(arg1),
        };
        0x2::transfer::transfer<FundingProof>(v2, 0x2::tx_context::sender(arg4));
        let v3 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v4 = UserFundedEvent{
            project_manager : 0x2::object::id_to_address(&v3),
            token_amount    : v0,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UserFundedEvent>(v4);
    }

    public entry fun fund<T0>(arg0: &mut FundingProof, arg1: 0x2::coin::Coin<T0>, arg2: &mut ProjectManager<T0>, arg3: &ProjectManagerConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        assert!(arg2.status == 0, 3);
        assert!(arg0.project_manager == 0x2::object::id<ProjectManager<T0>>(arg2), 5);
        let v0 = 0x2::coin::value<T0>(&arg1) * 10000 / arg3.token_price;
        assert!(arg2.remain_supply >= v0, 4);
        arg2.remain_supply = arg2.remain_supply - v0;
        0x2::balance::join<T0>(&mut arg2.total_funds, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.start_times, 7);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2.end_times, 6);
        if (arg2.remain_supply == 0) {
            arg2.status = 1;
            let v1 = ProjectShouldSucceedEvent{
                project_id : 0x2::object::id<ProjectManager<T0>>(arg2),
                owner      : arg2.owner,
                count      : arg2.count,
            };
            0x2::event::emit<ProjectShouldSucceedEvent>(v1);
        };
        arg0.token = arg0.token + v0;
        let v2 = 0x2::object::id<ProjectManager<T0>>(arg2);
        let v3 = UserFundedEvent{
            project_manager : 0x2::object::id_to_address(&v2),
            token_amount    : v0,
            count           : arg2.count,
            user            : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UserFundedEvent>(v3);
    }

    public fun get_admin_claimed_incentive_amount(arg0: &ProjectAdmin) : u64 {
        arg0.claimed_incentive_amount
    }

    public fun get_admin_project_manager(arg0: &ProjectAdmin) : address {
        arg0.project_manager
    }

    public fun get_project_count<T0>(arg0: &ProjectManager<T0>) : u64 {
        arg0.count
    }

    public fun get_project_manager_id<T0>(arg0: &ProjectManager<T0>) : 0x2::object::ID {
        0x2::object::id<ProjectManager<T0>>(arg0)
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
        let v0 = ProjectManagerConfig{
            id                 : 0x2::object::new(arg0),
            version            : 0,
            max_funding_amount : 800000000,
            token_price        : 25,
            target_fund        : 2000000,
        };
        0x2::transfer::share_object<ProjectManagerConfig>(v0);
    }

    public entry fun initialize_project_manager<T0>(arg0: &0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::launchpad_manager_config::LaunchAdmin, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &ProjectManagerConfig, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg5);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = ProjectAdmin{
            id                       : 0x2::object::new(arg6),
            project_manager          : v2,
            claimed_incentive_amount : 0,
        };
        0x2::transfer::transfer<ProjectAdmin>(v3, arg1);
        let v4 = ProjectInitializedEvent{
            project_manager : v2,
            target_funds    : arg5.target_fund,
            start_times     : arg3,
            end_times       : arg4,
            count           : arg2,
            fund_coin_type  : v0,
        };
        0x2::event::emit<ProjectInitializedEvent>(v4);
        let v5 = ProjectManager<T0>{
            id             : v1,
            target_funds   : arg5.target_fund,
            start_times    : arg3,
            fund_coin_type : v0,
            total_funds    : 0x2::balance::zero<T0>(),
            remain_supply  : arg5.max_funding_amount,
            end_times      : arg4,
            count          : arg2,
            status         : 0,
            pay_status     : 0,
            owner          : arg1,
        };
        0x2::transfer::share_object<ProjectManager<T0>>(v5);
    }

    public fun make_project_failed<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::launchpad_manager_config::LaunchAdmin) {
        arg0.status = 2;
    }

    public(friend) fun migrate(arg0: &mut ProjectManagerConfig) {
        assert!(arg0.version < 0, 8);
        arg0.version = 0;
    }

    public fun project_falied<T0>(arg0: &mut ProjectManager<T0>, arg1: &0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::launchpad_manager_config::LaunchAdmin, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_times, 6);
        assert!(arg0.status == 0, 3);
        arg0.status = 2;
    }

    public entry fun refund<T0>(arg0: FundingProof, arg1: &mut ProjectManager<T0>, arg2: &ProjectManagerConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(get_project_status<T0>(arg1) == 2, 2);
        let v0 = 0x2::object::id<ProjectManager<T0>>(arg1);
        let v1 = UserRefundedEvent{
            project_manager : 0x2::object::id_to_address(&v0),
            token_amount    : arg0.token,
            count           : arg1.count,
            user            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UserRefundedEvent>(v1);
        burn_proof(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_funds, (((arg0.token as u128) * (arg2.token_price as u128) / (10000 as u128)) as u64), arg3), 0x2::tx_context::sender(arg3));
    }

    public(friend) fun update_project_admin_claimed(arg0: &mut ProjectAdmin, arg1: u64) {
        arg0.claimed_incentive_amount = arg0.claimed_incentive_amount + arg1;
    }

    public(friend) fun update_proof_claimed(arg0: &mut FundingProof, arg1: u64) {
        arg0.claimed = arg0.claimed + arg1;
    }

    // decompiled from Move bytecode v6
}

