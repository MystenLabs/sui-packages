module 0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::enterprise {
    struct CorporateAccount has store, key {
        id: 0x2::object::UID,
        company_name: 0x1::string::String,
        admin: address,
        authorized_users: 0x2::table::Table<address, bool>,
        monthly_gas_budget: u64,
        current_month_usage: u64,
        total_lifetime_usage: u64,
        auto_renewal: bool,
        discount_tier: u8,
        dedicated_validator_pool: 0x1::option::Option<address>,
        created_at: u64,
        last_budget_reset: u64,
    }

    struct EnterpriseRegistry has key {
        id: 0x2::object::UID,
        corporate_accounts: 0x2::table::Table<address, 0x2::object::ID>,
        total_enterprise_volume: u64,
        total_enterprise_savings: u64,
        validator_pools: 0x2::table::Table<address, ValidatorPool>,
        admin: address,
    }

    struct ValidatorPool has store {
        pool_id: address,
        validators: vector<address>,
        reserved_capacity: u64,
        allocated_capacity: u64,
        enterprise_clients: vector<address>,
        performance_metrics: PoolMetrics,
    }

    struct PoolMetrics has store {
        average_latency: u64,
        success_rate: u64,
        total_transactions: u64,
        uptime_percentage: u64,
        last_update: u64,
    }

    struct GasAllocation has store, key {
        id: 0x2::object::UID,
        corporate_account: address,
        allocated_amount: u64,
        used_amount: u64,
        month: u64,
        year: u64,
        expires_at: u64,
    }

    struct EnterpriseGasPool has key {
        id: 0x2::object::UID,
        company_accounts: vector<address>,
        total_gas_reserved: u64,
        gas_reserve_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        bulk_discount_rate: u64,
        minimum_purchase: u64,
        pool_admin: address,
    }

    struct CorporateAccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        company_name: 0x1::string::String,
        admin: address,
        monthly_budget: u64,
        discount_tier: u8,
    }

    struct GasPurchased has copy, drop {
        account_id: 0x2::object::ID,
        company_name: 0x1::string::String,
        amount: u64,
        discount_applied: u64,
        final_price: u64,
        remaining_budget: u64,
    }

    struct BudgetReset has copy, drop {
        account_id: 0x2::object::ID,
        company_name: 0x1::string::String,
        new_budget: u64,
        previous_usage: u64,
        reset_timestamp: u64,
    }

    struct ValidatorPoolCreated has copy, drop {
        pool_id: address,
        validators: vector<address>,
        reserved_capacity: u64,
        enterprise_client: address,
    }

    struct DiscountTierUpgraded has copy, drop {
        account_id: 0x2::object::ID,
        company_name: 0x1::string::String,
        old_tier: u8,
        new_tier: u8,
        new_discount_rate: u64,
    }

    public entry fun add_authorized_user(arg0: &mut CorporateAccount, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::table::add<address, bool>(&mut arg0.authorized_users, arg1, true);
    }

    public entry fun assign_validator_pool(arg0: &EnterpriseRegistry, arg1: &mut CorporateAccount, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::table::contains<address, ValidatorPool>(&arg0.validator_pools, arg2), 3);
        arg1.dedicated_validator_pool = 0x1::option::some<address>(arg2);
    }

    public entry fun bulk_purchase_gas(arg0: &mut EnterpriseGasPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_admin == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 >= arg0.minimum_purchase, 6);
        let v0 = arg2 * 1000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0 - v0 * arg0.bulk_discount_rate / 10000, 2);
        arg0.total_gas_reserved = arg0.total_gas_reserved + arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_reserve_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun calculate_volume_discount(arg0: u64) : (u8, u64) {
        if (arg0 >= 100000000) {
            (4, 2000)
        } else if (arg0 >= 20000000) {
            (3, 1500)
        } else if (arg0 >= 5000000) {
            (2, 1000)
        } else if (arg0 >= 1000000) {
            (1, 500)
        } else {
            (0, 0)
        }
    }

    public entry fun create_corporate_account(arg0: &mut EnterpriseRegistry, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = CorporateAccount{
            id                       : 0x2::object::new(arg5),
            company_name             : 0x1::string::utf8(arg1),
            admin                    : v1,
            authorized_users         : 0x2::table::new<address, bool>(arg5),
            monthly_gas_budget       : arg2,
            current_month_usage      : 0,
            total_lifetime_usage     : 0,
            auto_renewal             : arg3,
            discount_tier            : 0,
            dedicated_validator_pool : 0x1::option::none<address>(),
            created_at               : v0,
            last_budget_reset        : v0,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.corporate_accounts, v1, v3);
        let v4 = CorporateAccountCreated{
            account_id     : v3,
            company_name   : v2.company_name,
            admin          : v1,
            monthly_budget : arg2,
            discount_tier  : 0,
        };
        0x2::event::emit<CorporateAccountCreated>(v4);
        0x2::transfer::transfer<CorporateAccount>(v2, v1);
    }

    public entry fun create_enterprise_gas_pool(arg0: vector<address>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EnterpriseGasPool{
            id                  : 0x2::object::new(arg3),
            company_accounts    : arg0,
            total_gas_reserved  : 0,
            gas_reserve_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            bulk_discount_rate  : arg2,
            minimum_purchase    : arg1,
            pool_admin          : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<EnterpriseGasPool>(v0);
    }

    public entry fun create_validator_pool(arg0: &mut EnterpriseRegistry, arg1: vector<address>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2::tx_context::fresh_object_address(arg4);
        let v1 = PoolMetrics{
            average_latency    : 0,
            success_rate       : 10000,
            total_transactions : 0,
            uptime_percentage  : 10000,
            last_update        : 0,
        };
        let v2 = ValidatorPool{
            pool_id             : v0,
            validators          : arg1,
            reserved_capacity   : arg2,
            allocated_capacity  : 0,
            enterprise_clients  : 0x1::vector::singleton<address>(arg3),
            performance_metrics : v1,
        };
        0x2::table::add<address, ValidatorPool>(&mut arg0.validator_pools, v0, v2);
        let v3 = ValidatorPoolCreated{
            pool_id           : v0,
            validators        : arg1,
            reserved_capacity : arg2,
            enterprise_client : arg3,
        };
        0x2::event::emit<ValidatorPoolCreated>(v3);
    }

    public entry fun enterprise_gas_purchase(arg0: &mut EnterpriseRegistry, arg1: &mut CorporateAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.admin == v0 || 0x2::table::contains<address, bool>(&arg1.authorized_users, v0), 1);
        assert!(arg1.current_month_usage + arg3 <= arg1.monthly_gas_budget, 5);
        let (_, v2) = calculate_volume_discount(arg1.total_lifetime_usage);
        let v3 = arg3 * 1000;
        let v4 = v3 * v2 / 10000;
        let v5 = v3 - v4;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v5, 2);
        arg1.current_month_usage = arg1.current_month_usage + arg3;
        arg1.total_lifetime_usage = arg1.total_lifetime_usage + arg3;
        arg0.total_enterprise_volume = arg0.total_enterprise_volume + arg3;
        arg0.total_enterprise_savings = arg0.total_enterprise_savings + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x0);
        let v6 = GasPurchased{
            account_id       : 0x2::object::uid_to_inner(&arg1.id),
            company_name     : arg1.company_name,
            amount           : arg3,
            discount_applied : v4,
            final_price      : v5,
            remaining_budget : arg1.monthly_gas_budget - arg1.current_month_usage,
        };
        0x2::event::emit<GasPurchased>(v6);
        update_discount_tier(arg1, arg5);
    }

    public fun get_corporate_account_info(arg0: &CorporateAccount) : (0x1::string::String, address, u64, u64, u64, u8, 0x1::option::Option<address>) {
        (arg0.company_name, arg0.admin, arg0.monthly_gas_budget, arg0.current_month_usage, arg0.total_lifetime_usage, arg0.discount_tier, arg0.dedicated_validator_pool)
    }

    public fun get_discount_info(arg0: u64) : (u8, u64) {
        calculate_volume_discount(arg0)
    }

    public fun get_enterprise_stats(arg0: &EnterpriseRegistry) : (u64, u64) {
        (arg0.total_enterprise_volume, arg0.total_enterprise_savings)
    }

    public fun get_validator_pool_info(arg0: &EnterpriseRegistry, arg1: address) : (vector<address>, u64, u64) {
        let v0 = 0x2::table::borrow<address, ValidatorPool>(&arg0.validator_pools, arg1);
        (v0.validators, v0.reserved_capacity, v0.allocated_capacity)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EnterpriseRegistry{
            id                       : 0x2::object::new(arg0),
            corporate_accounts       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_enterprise_volume  : 0,
            total_enterprise_savings : 0,
            validator_pools          : 0x2::table::new<address, ValidatorPool>(arg0),
            admin                    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<EnterpriseRegistry>(v0);
    }

    public entry fun reset_monthly_budget(arg0: &mut CorporateAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_budget_reset + 2592000000, 1);
        arg0.current_month_usage = 0;
        arg0.last_budget_reset = v0;
        let v1 = BudgetReset{
            account_id      : 0x2::object::uid_to_inner(&arg0.id),
            company_name    : arg0.company_name,
            new_budget      : arg0.monthly_gas_budget,
            previous_usage  : arg0.current_month_usage,
            reset_timestamp : v0,
        };
        0x2::event::emit<BudgetReset>(v1);
    }

    public entry fun update_discount_tier(arg0: &mut CorporateAccount, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_volume_discount(arg0.total_lifetime_usage);
        if (v0 > arg0.discount_tier) {
            arg0.discount_tier = v0;
            let v2 = DiscountTierUpgraded{
                account_id        : 0x2::object::uid_to_inner(&arg0.id),
                company_name      : arg0.company_name,
                old_tier          : arg0.discount_tier,
                new_tier          : v0,
                new_discount_rate : v1,
            };
            0x2::event::emit<DiscountTierUpgraded>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

