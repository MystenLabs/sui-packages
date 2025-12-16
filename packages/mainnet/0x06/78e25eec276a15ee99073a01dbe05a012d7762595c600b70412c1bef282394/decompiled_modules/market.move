module 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::market {
    struct MarketConfig has key {
        id: 0x2::object::UID,
        version: u64,
        initialized: bool,
        admin_members: 0x2::table::Table<address, bool>,
        providers: 0x2::table::Table<address, Provider>,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        version: u64,
        job_index: u128,
        jobs: 0x2::table::Table<u128, Job>,
    }

    struct Provider has copy, drop, store {
        cp: 0x1::string::String,
    }

    struct Job has store, key {
        id: 0x2::object::UID,
        job_id: u128,
        metadata: 0x1::string::String,
        owner: address,
        provider: address,
        rate: u64,
        last_settled_ms: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct ProviderAdded has copy, drop {
        provider: address,
        cp: 0x1::string::String,
    }

    struct ProviderRemoved has copy, drop {
        provider: address,
    }

    struct ProviderUpdatedWithCp has copy, drop {
        provider: address,
        new_cp: 0x1::string::String,
    }

    struct JobOpened has copy, drop {
        job_id: u128,
        owner: address,
        provider: address,
        metadata: 0x1::string::String,
        rate: u64,
        balance: u64,
        timestamp: u64,
    }

    struct JobClosed has copy, drop {
        job_id: u128,
    }

    struct JobDeposited has copy, drop {
        job_id: u128,
        from: address,
        amount: u64,
    }

    struct JobWithdrew has copy, drop {
        job_id: u128,
        to: address,
        amount: u64,
    }

    struct JobSettled has copy, drop {
        job_id: u128,
        amount: u64,
        settled_until_ms: u64,
    }

    struct JobMetadataUpdated has copy, drop {
        job_id: u128,
        new_metadata: 0x1::string::String,
    }

    struct JobReviseRateInitiated has copy, drop {
        job_id: u128,
        new_rate: u64,
    }

    struct JobReviseRateCancelled has copy, drop {
        job_id: u128,
    }

    struct JobReviseRateFinalized has copy, drop {
        job_id: u128,
        new_rate: u64,
    }

    struct RoleGranted has copy, drop {
        role: u8,
        member: address,
    }

    struct RoleRevoked has copy, drop {
        role: u8,
        member: address,
    }

    public fun add_admin_member(arg0: &mut MarketConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert_admin(arg0, arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.admin_members, arg1), 109);
        0x2::table::add<address, bool>(&mut arg0.admin_members, arg1, true);
        let v0 = RoleGranted{
            role   : 1,
            member : arg1,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    fun assert_admin(arg0: &MarketConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admin_members, 0x2::tx_context::sender(arg1)), 101);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 114);
    }

    public fun current_job_index(arg0: &Marketplace) : u128 {
        arg0.job_index
    }

    fun deposit(arg0: &mut Job, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : u64 {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1)
    }

    public fun extra_decimals() : u8 {
        12
    }

    public fun has_admin_role(arg0: &MarketConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admin_members, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketConfig{
            id            : 0x2::object::new(arg0),
            version       : 1,
            initialized   : false,
            admin_members : 0x2::table::new<address, bool>(arg0),
            providers     : 0x2::table::new<address, Provider>(arg0),
        };
        0x2::transfer::share_object<MarketConfig>(v0);
        let v1 = Marketplace{
            id        : 0x2::object::new(arg0),
            version   : 1,
            job_index : 0,
            jobs      : 0x2::table::new<u128, Job>(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public fun initialize(arg0: &mut MarketConfig, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: address, arg3: vector<vector<u8>>, arg4: vector<u64>) {
        assert!(!arg0.initialized, 113);
        arg0.initialized = true;
        0x2::table::add<address, bool>(&mut arg0.admin_members, arg2, true);
        0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::update_lock_wait_times(arg1, arg3, arg4);
    }

    public fun job_close(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 105);
        if (v0.rate == 0) {
            job_close_internal(arg0, arg1, arg2, arg3, arg4);
        };
        assert!(0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::unlock(arg1, rate_lock_selector(), job_id_bytes(arg2), arg3) == 0, 111);
        job_close_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun job_close_internal(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2);
        settle_job(v0, arg3, arg4);
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance);
        if (v1 > 0) {
            let v2 = v0.owner;
            withdraw(v0, v2, v1, arg4);
        };
        let Job {
            id              : v3,
            job_id          : _,
            metadata        : _,
            owner           : _,
            provider        : _,
            rate            : _,
            last_settled_ms : _,
            balance         : v10,
        } = 0x2::table::remove<u128, Job>(&mut arg0.jobs, arg2);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10);
        0x2::object::delete(v3);
        0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::revert_lock(arg1, rate_lock_selector(), job_id_bytes(arg2));
        let v11 = JobClosed{job_id: arg2};
        0x2::event::emit<JobClosed>(v11);
    }

    public fun job_data(arg0: &Marketplace, arg1: u128) : (u128, 0x1::string::String, address, address, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u128, Job>(&arg0.jobs, arg1);
        (v0.job_id, v0.metadata, v0.owner, v0.provider, v0.rate, v0.last_settled_ms, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance))
    }

    public fun job_deposit(arg0: &mut Marketplace, arg1: u128, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg1);
        let v1 = deposit(v0, arg2);
        let v2 = JobDeposited{
            job_id : v0.job_id,
            from   : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<JobDeposited>(v2);
    }

    public fun job_exists(arg0: &Marketplace, arg1: u128) : bool {
        0x2::table::contains<u128, Job>(&arg0.jobs, arg1)
    }

    fun job_id_bytes(arg0: u128) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u128>(&arg0);
        0x2::hash::keccak256(&v0)
    }

    public fun job_metadata_update(arg0: &mut Marketplace, arg1: u128, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 105);
        assert!(v0.metadata != arg2, 107);
        v0.metadata = arg2;
        let v1 = JobMetadataUpdated{
            job_id       : arg1,
            new_metadata : v0.metadata,
        };
        0x2::event::emit<JobMetadataUpdated>(v1);
    }

    public fun job_open(arg0: &mut Marketplace, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.job_index;
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = Job{
            id              : 0x2::object::new(arg6),
            job_id          : arg0.job_index,
            metadata        : arg1,
            owner           : v0,
            provider        : arg2,
            rate            : arg3,
            last_settled_ms : v2,
            balance         : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        arg0.job_index = v1 + 1;
        0x2::table::add<u128, Job>(&mut arg0.jobs, v1, v3);
        let v4 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, v1);
        let v5 = JobOpened{
            job_id    : v1,
            owner     : v0,
            provider  : arg2,
            metadata  : arg1,
            rate      : arg3,
            balance   : deposit(v4, arg4),
            timestamp : v2,
        };
        0x2::event::emit<JobOpened>(v5);
    }

    public fun job_revise_rate_cancel(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2).owner == 0x2::tx_context::sender(arg4), 105);
        let v0 = rate_lock_selector();
        let v1 = job_id_bytes(arg2);
        assert!(0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::lock_status(arg1, &v0, &v1, arg3) != 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::lock_status_none(), 112);
        0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::revert_lock(arg1, v0, v1);
        let v2 = JobReviseRateCancelled{job_id: arg2};
        0x2::event::emit<JobReviseRateCancelled>(v2);
    }

    public fun job_revise_rate_finalize(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 105);
        revise_job_rate(v0, arg2, (0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::unlock(arg1, rate_lock_selector(), job_id_bytes(arg2), arg3) as u64), arg3, arg4);
    }

    public fun job_revise_rate_initiate(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2).owner == 0x2::tx_context::sender(arg5), 105);
        0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::lock(arg1, rate_lock_selector(), job_id_bytes(arg2), (arg3 as u256), arg4);
        let v0 = JobReviseRateInitiated{
            job_id   : arg2,
            new_rate : arg3,
        };
        0x2::event::emit<JobReviseRateInitiated>(v0);
    }

    public fun job_settle(arg0: &mut Marketplace, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg1);
        settle_job(v0, arg2, arg3);
    }

    public fun job_withdraw(arg0: &mut Marketplace, arg1: &mut 0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::LockData, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(arg3 > 0, 106);
        let v0 = 0x2::table::borrow_mut<u128, Job>(&mut arg0.jobs, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0.owner == v1, 105);
        settle_job(v0, arg4, arg5);
        let v2 = 0x1::u128::pow(10, 12);
        let v3 = ((((v0.rate as u128) * (0x678e25eec276a15ee99073a01dbe05a012d7762595c600b70412c1bef282394::lock::lock_wait_time_ms(arg1, rate_lock_selector()) as u128) + v2 - 1) / v2) as u64);
        let v4 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance);
        assert!(v4 >= v3, 108);
        assert!(arg3 <= v4 - v3, 108);
        withdraw(v0, v1, arg3, arg5);
        let v5 = JobWithdrew{
            job_id : v0.job_id,
            to     : v1,
            amount : arg3,
        };
        0x2::event::emit<JobWithdrew>(v5);
    }

    public fun provider_add(arg0: &mut MarketConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Provider>(&arg0.providers, v0), 102);
        assert!(0x1::string::length(&arg1) > 0, 104);
        let v1 = Provider{cp: arg1};
        0x2::table::add<address, Provider>(&mut arg0.providers, v0, v1);
        let v2 = ProviderAdded{
            provider : v0,
            cp       : arg1,
        };
        0x2::event::emit<ProviderAdded>(v2);
    }

    public fun provider_cp(arg0: &MarketConfig, arg1: address) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, Provider>(&arg0.providers, arg1)) {
            0x1::option::some<0x1::string::String>(0x2::table::borrow<address, Provider>(&arg0.providers, arg1).cp)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun provider_remove(arg0: &mut MarketConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Provider>(&arg0.providers, v0), 103);
        let Provider {  } = 0x2::table::remove<address, Provider>(&mut arg0.providers, v0);
        let v1 = ProviderRemoved{provider: v0};
        0x2::event::emit<ProviderRemoved>(v1);
    }

    public fun provider_update_cp(arg0: &mut MarketConfig, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::string::length(&arg1) > 0, 104);
        0x2::table::borrow_mut<address, Provider>(&mut arg0.providers, v0).cp = arg1;
        let v1 = ProviderUpdatedWithCp{
            provider : v0,
            new_cp   : arg1,
        };
        0x2::event::emit<ProviderUpdatedWithCp>(v1);
    }

    public fun rate_lock_selector() : vector<u8> {
        let v0 = 0x1::string::into_bytes(0x1::string::utf8(b"RATE_LOCK"));
        0x2::hash::keccak256(&v0)
    }

    public fun remove_admin_member(arg0: &mut MarketConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert_admin(arg0, arg2);
        assert!(0x2::table::contains<address, bool>(&arg0.admin_members, arg1), 110);
        0x2::table::remove<address, bool>(&mut arg0.admin_members, arg1);
        let v0 = RoleRevoked{
            role   : 1,
            member : arg1,
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    fun revise_job_rate(arg0: &mut Job, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        settle_job(arg0, arg3, arg4);
        arg0.rate = arg2;
        let v0 = JobReviseRateFinalized{
            job_id   : arg1,
            new_rate : arg2,
        };
        0x2::event::emit<JobReviseRateFinalized>(v0);
    }

    fun settle_job(arg0: &mut Job, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::u128::pow(10, 12);
        let v2 = ((((arg0.rate as u128) * ((v0 - arg0.last_settled_ms) as u128) + v1 - 1) / v1) as u64);
        let v3 = v2;
        let v4 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        if (v2 > v4) {
            v3 = v4;
        };
        let v5 = arg0.provider;
        withdraw(arg0, v5, v3, arg2);
        arg0.last_settled_ms = v0;
        let v6 = JobSettled{
            job_id           : arg0.job_id,
            amount           : v3,
            settled_until_ms : v0,
        };
        0x2::event::emit<JobSettled>(v6);
    }

    fun withdraw(arg0: &mut Job, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg3), arg1);
        };
    }

    // decompiled from Move bytecode v6
}

