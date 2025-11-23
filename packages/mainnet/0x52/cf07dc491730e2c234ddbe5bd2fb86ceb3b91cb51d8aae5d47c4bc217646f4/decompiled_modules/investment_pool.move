module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::investment_pool {
    struct InvestmentPool has store, key {
        id: 0x2::object::UID,
        pool_id: 0x1::string::String,
        pool_name: 0x1::string::String,
        pool_type: 0x1::string::String,
        target_size: u64,
        current_size: u64,
        deployed_capital: u64,
        metadata_hash: vector<u8>,
        total_contributions: u64,
        total_loans_funded: u64,
        total_distributions: u64,
        is_active: bool,
        created_at: u64,
        manager: address,
    }

    struct Contribution has store, key {
        id: 0x2::object::UID,
        pool_id: 0x1::string::String,
        contribution_id: 0x1::string::String,
        investor: address,
        amount: u64,
        contributed_at: u64,
        is_active: bool,
    }

    struct CapitalDeployment has store, key {
        id: 0x2::object::UID,
        pool_id: 0x1::string::String,
        loan_id: 0x1::string::String,
        amount: u64,
        deployed_at: u64,
        deployed_by: address,
    }

    struct Distribution has store, key {
        id: 0x2::object::UID,
        pool_id: 0x1::string::String,
        loan_id: 0x1::string::String,
        total_amount: u64,
        num_investors: u64,
        distributed_at: u64,
        distributed_by: address,
    }

    struct Withdrawal has store, key {
        id: 0x2::object::UID,
        pool_id: 0x1::string::String,
        contribution_id: 0x1::string::String,
        investor: address,
        amount: u64,
        withdrawn_at: u64,
    }

    public entry fun add_contribution(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = Contribution{
            id              : 0x2::object::new(arg3),
            pool_id         : 0x1::string::utf8(arg0),
            contribution_id : 0x1::string::utf8(arg1),
            investor        : 0x2::tx_context::sender(arg3),
            amount          : arg2,
            contributed_at  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            is_active       : true,
        };
        0x2::transfer::public_share_object<Contribution>(v0);
    }

    public entry fun attest_distribution(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Distribution{
            id             : 0x2::object::new(arg5),
            pool_id        : 0x1::string::utf8(arg0),
            loan_id        : 0x1::string::utf8(arg1),
            total_amount   : arg2,
            num_investors  : arg3,
            distributed_at : arg4,
            distributed_by : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_share_object<Distribution>(v0);
    }

    public entry fun attest_withdrawal(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Withdrawal{
            id              : 0x2::object::new(arg4),
            pool_id         : 0x1::string::utf8(arg0),
            contribution_id : 0x1::string::utf8(arg1),
            investor        : 0x2::tx_context::sender(arg4),
            amount          : arg2,
            withdrawn_at    : arg3,
        };
        0x2::transfer::public_share_object<Withdrawal>(v0);
    }

    public fun calculate_utilization(arg0: &InvestmentPool) : u64 {
        if (arg0.current_size == 0) {
            return 0
        };
        arg0.deployed_capital * 10000 / arg0.current_size
    }

    public entry fun create_pool(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(validate_pool_type(&arg2), 6);
        let v0 = InvestmentPool{
            id                  : 0x2::object::new(arg5),
            pool_id             : 0x1::string::utf8(arg0),
            pool_name           : 0x1::string::utf8(arg1),
            pool_type           : 0x1::string::utf8(arg2),
            target_size         : arg3,
            current_size        : 0,
            deployed_capital    : 0,
            metadata_hash       : arg4,
            total_contributions : 0,
            total_loans_funded  : 0,
            total_distributions : 0,
            is_active           : true,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg5),
            manager             : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_share_object<InvestmentPool>(v0);
    }

    public entry fun deactivate_contribution(arg0: &mut Contribution, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.investor, 4);
        arg0.is_active = false;
    }

    public entry fun deactivate_pool(arg0: &mut InvestmentPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 4);
        arg0.is_active = false;
    }

    public entry fun deploy_capital(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = CapitalDeployment{
            id          : 0x2::object::new(arg3),
            pool_id     : 0x1::string::utf8(arg0),
            loan_id     : 0x1::string::utf8(arg1),
            amount      : arg2,
            deployed_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
            deployed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::public_share_object<CapitalDeployment>(v0);
    }

    public fun get_available_capital(arg0: &InvestmentPool) : u64 {
        if (arg0.deployed_capital >= arg0.current_size) {
            return 0
        };
        arg0.current_size - arg0.deployed_capital
    }

    public fun get_contribution_info(arg0: &Contribution) : (0x1::string::String, 0x1::string::String, address, u64, u64, bool) {
        (arg0.pool_id, arg0.contribution_id, arg0.investor, arg0.amount, arg0.contributed_at, arg0.is_active)
    }

    public fun get_pool_info(arg0: &InvestmentPool) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, bool) {
        (arg0.pool_id, arg0.pool_name, arg0.pool_type, arg0.target_size, arg0.current_size, arg0.deployed_capital, arg0.is_active)
    }

    public entry fun return_capital(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun update_pool_deployment(arg0: &mut InvestmentPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 4);
        assert!(arg0.is_active == true, 1);
        assert!(arg1 <= arg0.current_size - arg0.deployed_capital, 2);
        arg0.deployed_capital = arg0.deployed_capital + arg1;
        arg0.total_loans_funded = arg0.total_loans_funded + 1;
    }

    public entry fun update_pool_distribution(arg0: &mut InvestmentPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 4);
        arg0.total_distributions = arg0.total_distributions + 1;
    }

    public entry fun update_pool_return(arg0: &mut InvestmentPool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 4);
        assert!(arg1 <= arg0.deployed_capital, 3);
        arg0.deployed_capital = arg0.deployed_capital - arg1;
    }

    public entry fun update_pool_size(arg0: &mut InvestmentPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 4);
        arg0.current_size = arg0.current_size + arg1;
        arg0.total_contributions = arg0.total_contributions + 1;
    }

    fun validate_pool_type(arg0: &vector<u8>) : bool {
        if (*arg0 == b"prime_tier") {
            true
        } else if (*arg0 == b"balanced_growth") {
            true
        } else if (*arg0 == b"high_yield") {
            true
        } else {
            *arg0 == b"staking_rewards"
        }
    }

    // decompiled from Move bytecode v6
}

