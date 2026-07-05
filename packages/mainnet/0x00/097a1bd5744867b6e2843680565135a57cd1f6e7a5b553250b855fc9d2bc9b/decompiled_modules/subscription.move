module 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription {
    struct PlanDef has copy, drop, store {
        tier: u8,
        name: 0x1::string::String,
        price_usdc: u64,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        max_storage_bytes: u64,
        max_transforms: u64,
        max_files_per_job: u64,
        max_concurrent_jobs: u64,
        max_walrus_epochs: u64,
        seal_encryption: bool,
        priority_processing: bool,
        points_multiplier: u64,
        max_files_per_batch: u64,
        max_total_files: u64,
    }

    struct PlanRegistry has key {
        id: 0x2::object::UID,
        plans: vector<PlanDef>,
    }

    struct UserAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        created_epoch: u64,
        total_bytes_stored: u64,
        total_blobs: u64,
        encrypted_blobs: u64,
        plain_blobs: u64,
        total_jobs_completed: u64,
        active_jobs: u64,
        bonus_storage_bytes: u64,
        lifetime_points_earned: u64,
        blob_store_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Subscription has store, key {
        id: 0x2::object::UID,
        owner: address,
        plan_tier: u8,
        started_epoch: u64,
        expires_epoch: u64,
        billing_period_epochs: u64,
        amount_paid_in_coin: u64,
        payment_coin_type: 0x1::string::String,
        status: u8,
        cancel_requested_epoch: 0x1::option::Option<u64>,
        downgrade_to_tier: 0x1::option::Option<u8>,
    }

    struct UserCreated has copy, drop {
        user: address,
        account_id: 0x2::object::ID,
        epoch: u64,
    }

    struct Subscribed has copy, drop {
        user: address,
        tier: u8,
        billing_period_epochs: u64,
        amount_paid_in_coin: u64,
        payment_type: 0x1::string::String,
        epoch: u64,
    }

    struct PlanUpgraded has copy, drop {
        user: address,
        old_tier: u8,
        new_tier: u8,
        additional_paid_in_coin: u64,
        payment_type: 0x1::string::String,
        epoch: u64,
    }

    struct DowngradeRequested has copy, drop {
        user: address,
        current_tier: u8,
        target_tier: u8,
        epoch: u64,
    }

    struct DowngradeCancelled has copy, drop {
        user: address,
        current_tier: u8,
        cancelled_target_tier: u8,
        epoch: u64,
    }

    struct SubscriptionCancelled has copy, drop {
        user: address,
        tier: u8,
        active_until_epoch: u64,
        epoch: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        user: address,
        tier: u8,
        billing_period_epochs: u64,
        amount_paid_in_coin: u64,
        payment_type: 0x1::string::String,
        epoch: u64,
    }

    struct PlanCoinPriceSet has copy, drop {
        tier: u8,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        epoch: u64,
    }

    struct PlanCoinPriceRemoved has copy, drop {
        tier: u8,
        coin_type: 0x1::type_name::TypeName,
        epoch: u64,
    }

    struct EnterpriseActivated has copy, drop {
        beneficiary: address,
        duration_epochs: u64,
        usdc_equivalent: u64,
        activated_by: address,
        epoch: u64,
    }

    struct PlanLimitsUpdated has copy, drop {
        tier: u8,
        name: 0x1::string::String,
        max_storage_bytes: u64,
        max_transforms: u64,
        max_files_per_job: u64,
        max_concurrent_jobs: u64,
        max_walrus_epochs: u64,
        seal_encryption: bool,
        priority_processing: bool,
        points_multiplier: u64,
        max_files_per_batch: u64,
        max_total_files: u64,
        epoch: u64,
    }

    public fun account_active_jobs(arg0: &UserAccount) : u64 {
        arg0.active_jobs
    }

    public fun account_blob_store_id(arg0: &UserAccount) : 0x1::option::Option<0x2::object::ID> {
        arg0.blob_store_id
    }

    public fun account_bonus_storage(arg0: &UserAccount) : u64 {
        arg0.bonus_storage_bytes
    }

    public fun account_created_epoch(arg0: &UserAccount) : u64 {
        arg0.created_epoch
    }

    public fun account_encrypted_blobs(arg0: &UserAccount) : u64 {
        arg0.encrypted_blobs
    }

    public fun account_jobs_completed(arg0: &UserAccount) : u64 {
        arg0.total_jobs_completed
    }

    public fun account_lifetime_points(arg0: &UserAccount) : u64 {
        arg0.lifetime_points_earned
    }

    public fun account_owner(arg0: &UserAccount) : address {
        arg0.owner
    }

    public fun account_plain_blobs(arg0: &UserAccount) : u64 {
        arg0.plain_blobs
    }

    public fun account_total_blobs(arg0: &UserAccount) : u64 {
        arg0.total_blobs
    }

    public fun account_total_bytes(arg0: &UserAccount) : u64 {
        arg0.total_bytes_stored
    }

    public(friend) fun add_bonus_storage(arg0: &mut UserAccount, arg1: u64) {
        arg0.bonus_storage_bytes = arg0.bonus_storage_bytes + arg1;
    }

    public(friend) fun add_lifetime_points(arg0: &mut UserAccount, arg1: u64) {
        arg0.lifetime_points_earned = arg0.lifetime_points_earned + arg1;
    }

    public(friend) fun add_storage(arg0: &mut UserAccount, arg1: u64, arg2: u64, arg3: bool) {
        arg0.total_bytes_stored = arg0.total_bytes_stored + arg1;
        arg0.total_blobs = arg0.total_blobs + arg2;
        if (arg3) {
            arg0.encrypted_blobs = arg0.encrypted_blobs + arg2;
        } else {
            arg0.plain_blobs = arg0.plain_blobs + arg2;
        };
    }

    public fun admin_activate_enterprise(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::AdminCap, arg1: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::GlobalConfig, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_not_paused(arg1);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_version(arg1);
        assert!(arg3 > 0, 100);
        let v0 = new_user_account(arg2, arg5);
        let v1 = 0x2::object::id<UserAccount>(&v0);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::register_user(arg1, arg2, v1, arg5);
        let v2 = Subscription{
            id                     : 0x2::object::new(arg5),
            owner                  : arg2,
            plan_tier              : 3,
            started_epoch          : 0x2::tx_context::epoch(arg5),
            expires_epoch          : 0x2::tx_context::epoch(arg5) + arg3,
            billing_period_epochs  : arg3,
            amount_paid_in_coin    : 0,
            payment_coin_type      : 0x1::string::utf8(b"OFFCHAIN"),
            status                 : 0,
            cancel_requested_epoch : 0x1::option::none<u64>(),
            downgrade_to_tier      : 0x1::option::none<u8>(),
        };
        let v3 = UserCreated{
            user       : arg2,
            account_id : v1,
            epoch      : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<UserCreated>(v3);
        let v4 = EnterpriseActivated{
            beneficiary     : arg2,
            duration_epochs : arg3,
            usdc_equivalent : arg4,
            activated_by    : 0x2::tx_context::sender(arg5),
            epoch           : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<EnterpriseActivated>(v4);
        0x2::transfer::public_transfer<UserAccount>(v0, arg2);
        0x2::transfer::public_transfer<Subscription>(v2, arg2);
    }

    public fun admin_extend_enterprise(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::AdminCap, arg1: &mut Subscription, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.plan_tier == 3, 100);
        assert!(arg2 > 0, 100);
        arg1.expires_epoch = arg1.expires_epoch + arg2;
        if (arg1.status != 0) {
            arg1.status = 0;
        };
        let v0 = EnterpriseActivated{
            beneficiary     : arg1.owner,
            duration_epochs : arg2,
            usdc_equivalent : arg3,
            activated_by    : 0x2::tx_context::sender(arg4),
            epoch           : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<EnterpriseActivated>(v0);
    }

    public fun cancel(arg0: &mut Subscription, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 103);
        assert!(arg0.status == 0, 107);
        arg0.status = 1;
        arg0.cancel_requested_epoch = 0x1::option::some<u64>(0x2::tx_context::epoch(arg1));
        let v0 = SubscriptionCancelled{
            user               : 0x2::tx_context::sender(arg1),
            tier               : arg0.plan_tier,
            active_until_epoch : arg0.expires_epoch,
            epoch              : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<SubscriptionCancelled>(v0);
    }

    public fun cancel_downgrade(arg0: &mut Subscription, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 103);
        assert!(0x1::option::is_some<u8>(&arg0.downgrade_to_tier), 124);
        let v0 = DowngradeCancelled{
            user                  : 0x2::tx_context::sender(arg1),
            current_tier          : arg0.plan_tier,
            cancelled_target_tier : 0x1::option::extract<u8>(&mut arg0.downgrade_to_tier),
            epoch                 : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<DowngradeCancelled>(v0);
    }

    fun coin_type_string<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (v0 == 0x1::type_name::with_original_ids<0x2::sui::SUI>()) {
            0x1::string::utf8(b"SUI")
        } else {
            0x1::string::from_ascii(0x1::type_name::into_string(v0))
        }
    }

    public fun days_until_expiry(arg0: &Subscription, arg1: u64, arg2: u64) : u64 {
        epochs_until_expiry(arg0, arg1) * arg2
    }

    public(friend) fun decrement_active_jobs(arg0: &mut UserAccount) {
        if (arg0.active_jobs > 0) {
            arg0.active_jobs = arg0.active_jobs - 1;
        };
    }

    public fun effective_storage_limit(arg0: &UserAccount, arg1: &PlanRegistry, arg2: u8) : u64 {
        let v0 = 0x1::vector::borrow<PlanDef>(&arg1.plans, (arg2 as u64));
        if (v0.max_storage_bytes == 0) {
            18446744073709551615
        } else {
            v0.max_storage_bytes + arg0.bonus_storage_bytes
        }
    }

    public fun epochs_until_expiry(arg0: &Subscription, arg1: u64) : u64 {
        if (arg0.expires_epoch > arg1) {
            arg0.expires_epoch - arg1
        } else {
            0
        }
    }

    public(friend) fun extend_expiry(arg0: &mut Subscription, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 100);
        assert!(arg0.plan_tier != 3, 123);
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = if (arg0.expires_epoch > v0) {
            arg0.expires_epoch + arg1
        } else {
            v0 + arg1
        };
        arg0.expires_epoch = v1;
        arg0.status = 0;
        arg0.cancel_requested_epoch = 0x1::option::none<u64>();
    }

    fun get_coin_price<T0>(arg0: &PlanDef) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v0), 118);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
    }

    public fun get_plan(arg0: &PlanRegistry, arg1: u8) : &PlanDef {
        0x1::vector::borrow<PlanDef>(&arg0.plans, (arg1 as u64))
    }

    public(friend) fun increment_active_jobs(arg0: &mut UserAccount) {
        arg0.active_jobs = arg0.active_jobs + 1;
    }

    public(friend) fun increment_jobs_completed(arg0: &mut UserAccount) {
        arg0.total_jobs_completed = arg0.total_jobs_completed + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<PlanDef>();
        let v1 = PlanDef{
            tier                : 0,
            name                : 0x1::string::utf8(b"Free"),
            price_usdc          : 0,
            prices              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            max_storage_bytes   : 1073741824 / 2,
            max_transforms      : 5,
            max_files_per_job   : 5,
            max_concurrent_jobs : 1,
            max_walrus_epochs   : 1,
            seal_encryption     : false,
            priority_processing : false,
            points_multiplier   : 0,
            max_files_per_batch : 1,
            max_total_files     : 20,
        };
        0x1::vector::push_back<PlanDef>(&mut v0, v1);
        let v2 = PlanDef{
            tier                : 1,
            name                : 0x1::string::utf8(b"Starter"),
            price_usdc          : 10000000,
            prices              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            max_storage_bytes   : 40 * 1073741824,
            max_transforms      : 10,
            max_files_per_job   : 500,
            max_concurrent_jobs : 3,
            max_walrus_epochs   : 26,
            seal_encryption     : true,
            priority_processing : false,
            points_multiplier   : 2,
            max_files_per_batch : 200,
            max_total_files     : 5000,
        };
        0x1::vector::push_back<PlanDef>(&mut v0, v2);
        let v3 = PlanDef{
            tier                : 2,
            name                : 0x1::string::utf8(b"Pro"),
            price_usdc          : 30000000,
            prices              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            max_storage_bytes   : 200 * 1073741824,
            max_transforms      : 0,
            max_files_per_job   : 0,
            max_concurrent_jobs : 10,
            max_walrus_epochs   : 53,
            seal_encryption     : true,
            priority_processing : true,
            points_multiplier   : 5,
            max_files_per_batch : 666,
            max_total_files     : 50000,
        };
        0x1::vector::push_back<PlanDef>(&mut v0, v3);
        let v4 = PlanDef{
            tier                : 3,
            name                : 0x1::string::utf8(b"Enterprise"),
            price_usdc          : 0,
            prices              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            max_storage_bytes   : 0,
            max_transforms      : 0,
            max_files_per_job   : 0,
            max_concurrent_jobs : 0,
            max_walrus_epochs   : 53,
            seal_encryption     : true,
            priority_processing : true,
            points_multiplier   : 10,
            max_files_per_batch : 0,
            max_total_files     : 0,
        };
        0x1::vector::push_back<PlanDef>(&mut v0, v4);
        let v5 = PlanRegistry{
            id    : 0x2::object::new(arg0),
            plans : v0,
        };
        0x2::transfer::share_object<PlanRegistry>(v5);
    }

    public fun is_active(arg0: &Subscription, arg1: u64) : bool {
        (arg0.status == 0 || arg0.status == 1) && arg0.expires_epoch > arg1
    }

    public fun is_subscription_active(arg0: &Subscription, arg1: u64) : bool {
        is_active(arg0, arg1)
    }

    fun new_user_account(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : UserAccount {
        UserAccount{
            id                     : 0x2::object::new(arg1),
            owner                  : arg0,
            created_epoch          : 0x2::tx_context::epoch(arg1),
            total_bytes_stored     : 0,
            total_blobs            : 0,
            encrypted_blobs        : 0,
            plain_blobs            : 0,
            total_jobs_completed   : 0,
            active_jobs            : 0,
            bonus_storage_bytes    : 0,
            lifetime_points_earned : 0,
            blob_store_id          : 0x1::option::none<0x2::object::ID>(),
        }
    }

    fun pay_and_return_change<T0>(arg0: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::Treasury, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 102);
        if (arg2 > 0) {
            0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg4), 0x2::tx_context::sender(arg4), arg3, 0x2::tx_context::epoch(arg4));
        };
        arg1
    }

    public fun plan_has_priority(arg0: &PlanDef) : bool {
        arg0.priority_processing
    }

    public fun plan_has_seal(arg0: &PlanDef) : bool {
        arg0.seal_encryption
    }

    public fun plan_max_concurrent_jobs(arg0: &PlanDef) : u64 {
        arg0.max_concurrent_jobs
    }

    public fun plan_max_files(arg0: &PlanDef) : u64 {
        arg0.max_files_per_job
    }

    public fun plan_max_files_per_batch(arg0: &PlanDef) : u64 {
        arg0.max_files_per_batch
    }

    public fun plan_max_storage(arg0: &PlanDef) : u64 {
        arg0.max_storage_bytes
    }

    public fun plan_max_total_files(arg0: &PlanDef) : u64 {
        arg0.max_total_files
    }

    public fun plan_max_transforms(arg0: &PlanDef) : u64 {
        arg0.max_transforms
    }

    public fun plan_max_walrus_epochs(arg0: &PlanDef) : u64 {
        arg0.max_walrus_epochs
    }

    public fun plan_name(arg0: &PlanDef) : 0x1::string::String {
        arg0.name
    }

    public fun plan_points_multiplier(arg0: &PlanDef) : u64 {
        arg0.points_multiplier
    }

    public fun plan_price_for_coin<T0>(arg0: &PlanDef) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
        } else {
            0
        }
    }

    public fun plan_price_usdc(arg0: &PlanDef) : u64 {
        arg0.price_usdc
    }

    public fun plan_prices(arg0: &PlanDef) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.prices
    }

    public fun plan_tier(arg0: &PlanDef) : u8 {
        arg0.tier
    }

    public(friend) fun release_storage(arg0: &mut UserAccount, arg1: u64, arg2: u64, arg3: bool) {
        let v0 = if (arg0.total_bytes_stored > arg1) {
            arg0.total_bytes_stored - arg1
        } else {
            0
        };
        arg0.total_bytes_stored = v0;
        let v1 = if (arg0.total_blobs > arg2) {
            arg0.total_blobs - arg2
        } else {
            0
        };
        arg0.total_blobs = v1;
        if (arg3) {
            let v2 = if (arg0.encrypted_blobs > arg2) {
                arg0.encrypted_blobs - arg2
            } else {
                0
            };
            arg0.encrypted_blobs = v2;
        } else {
            let v3 = if (arg0.plain_blobs > arg2) {
                arg0.plain_blobs - arg2
            } else {
                0
            };
            arg0.plain_blobs = v3;
        };
    }

    public fun remove_plan_coin_price<T0>(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::AdminCap, arg1: &mut PlanRegistry, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 3, 100);
        let v0 = (arg2 as u64);
        assert!(v0 < 0x1::vector::length<PlanDef>(&arg1.plans), 115);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x1::vector::borrow_mut<PlanDef>(&mut arg1.plans, v0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.prices, &v1), 121);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2.prices, &v1);
        let v5 = PlanCoinPriceRemoved{
            tier      : arg2,
            coin_type : v1,
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<PlanCoinPriceRemoved>(v5);
    }

    public fun renew<T0>(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::GlobalConfig, arg1: &PlanRegistry, arg2: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::Treasury, arg3: &mut Subscription, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_not_paused(arg0);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_version(arg0);
        assert!(arg3.owner == 0x2::tx_context::sender(arg5), 103);
        let v0 = arg3.status == 0 && arg3.expires_epoch > 0x2::tx_context::epoch(arg5);
        assert!(!v0, 116);
        let v1 = coin_type_string<T0>();
        let v2 = 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::billing_period_epochs(arg0);
        let v3 = if (0x1::option::is_some<u8>(&arg3.downgrade_to_tier)) {
            0x1::option::extract<u8>(&mut arg3.downgrade_to_tier)
        } else {
            arg3.plan_tier
        };
        assert!(v3 <= 3, 100);
        assert!(v3 != 3, 123);
        let v4 = 0x1::vector::borrow<PlanDef>(&arg1.plans, (v3 as u64));
        let v5 = if (v3 == 0) {
            0
        } else {
            get_coin_price<T0>(v4)
        };
        let v6 = pay_and_return_change<T0>(arg2, arg4, v5, v4.price_usdc, arg5);
        let v7 = if (arg3.expires_epoch > 0x2::tx_context::epoch(arg5)) {
            arg3.expires_epoch
        } else {
            0x2::tx_context::epoch(arg5)
        };
        arg3.plan_tier = v3;
        arg3.started_epoch = v7;
        arg3.expires_epoch = v7 + v2;
        arg3.billing_period_epochs = v2;
        arg3.amount_paid_in_coin = v5;
        arg3.payment_coin_type = v1;
        arg3.status = 0;
        arg3.cancel_requested_epoch = 0x1::option::none<u64>();
        let v8 = SubscriptionRenewed{
            user                  : 0x2::tx_context::sender(arg5),
            tier                  : v3,
            billing_period_epochs : v2,
            amount_paid_in_coin   : v5,
            payment_type          : v1,
            epoch                 : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<SubscriptionRenewed>(v8);
        v6
    }

    public fun request_downgrade(arg0: &mut Subscription, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 103);
        assert!(arg0.status == 0, 104);
        assert!(arg1 < arg0.plan_tier, 106);
        assert!(arg1 <= 3, 100);
        arg0.downgrade_to_tier = 0x1::option::some<u8>(arg1);
        let v0 = DowngradeRequested{
            user         : 0x2::tx_context::sender(arg2),
            current_tier : arg0.plan_tier,
            target_tier  : arg1,
            epoch        : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DowngradeRequested>(v0);
    }

    public(friend) fun set_account_owner(arg0: &mut UserAccount, arg1: address) {
        arg0.owner = arg1;
    }

    public(friend) fun set_blob_store_id(arg0: &mut UserAccount, arg1: 0x2::object::ID) {
        arg0.blob_store_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_plan_coin_price<T0>(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::AdminCap, arg1: &mut PlanRegistry, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 3, 100);
        let v0 = (arg2 as u64);
        assert!(v0 < 0x1::vector::length<PlanDef>(&arg1.plans), 115);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x1::vector::borrow_mut<PlanDef>(&mut arg1.plans, v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.prices, &v1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2.prices, &v1);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.prices, v1, arg3);
        let v5 = PlanCoinPriceSet{
            tier      : arg2,
            coin_type : v1,
            price     : arg3,
            epoch     : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<PlanCoinPriceSet>(v5);
    }

    public(friend) fun set_sub_owner(arg0: &mut Subscription, arg1: address) {
        arg0.owner = arg1;
    }

    public fun sub_amount_paid_in_coin(arg0: &Subscription) : u64 {
        arg0.amount_paid_in_coin
    }

    public fun sub_billing_period(arg0: &Subscription) : u64 {
        arg0.billing_period_epochs
    }

    public fun sub_cancel_epoch(arg0: &Subscription) : &0x1::option::Option<u64> {
        &arg0.cancel_requested_epoch
    }

    public fun sub_downgrade_tier(arg0: &Subscription) : &0x1::option::Option<u8> {
        &arg0.downgrade_to_tier
    }

    public fun sub_expires_epoch(arg0: &Subscription) : u64 {
        arg0.expires_epoch
    }

    public fun sub_owner(arg0: &Subscription) : address {
        arg0.owner
    }

    public fun sub_payment_coin_type(arg0: &Subscription) : 0x1::string::String {
        arg0.payment_coin_type
    }

    public fun sub_started_epoch(arg0: &Subscription) : u64 {
        arg0.started_epoch
    }

    public fun sub_status(arg0: &Subscription) : u8 {
        arg0.status
    }

    public fun sub_tier(arg0: &Subscription) : u8 {
        arg0.plan_tier
    }

    public fun subscribe<T0>(arg0: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::GlobalConfig, arg1: &PlanRegistry, arg2: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::Treasury, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (UserAccount, Subscription, 0x2::coin::Coin<T0>) {
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_not_paused(arg0);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_version(arg0);
        assert!(arg3 <= 3, 100);
        assert!(arg3 != 3, 123);
        let v0 = 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::billing_period_epochs(arg0);
        let v1 = 0x1::vector::borrow<PlanDef>(&arg1.plans, (arg3 as u64));
        let v2 = if (arg3 == 0) {
            0
        } else {
            get_coin_price<T0>(v1)
        };
        let v3 = pay_and_return_change<T0>(arg2, arg4, v2, v1.price_usdc, arg5);
        let v4 = coin_type_string<T0>();
        let v5 = 0x2::tx_context::sender(arg5);
        let v6 = new_user_account(v5, arg5);
        let v7 = 0x2::object::id<UserAccount>(&v6);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::register_user(arg0, 0x2::tx_context::sender(arg5), v7, arg5);
        let v8 = Subscription{
            id                     : 0x2::object::new(arg5),
            owner                  : 0x2::tx_context::sender(arg5),
            plan_tier              : arg3,
            started_epoch          : 0x2::tx_context::epoch(arg5),
            expires_epoch          : 0x2::tx_context::epoch(arg5) + v0,
            billing_period_epochs  : v0,
            amount_paid_in_coin    : v2,
            payment_coin_type      : v4,
            status                 : 0,
            cancel_requested_epoch : 0x1::option::none<u64>(),
            downgrade_to_tier      : 0x1::option::none<u8>(),
        };
        let v9 = UserCreated{
            user       : 0x2::tx_context::sender(arg5),
            account_id : v7,
            epoch      : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<UserCreated>(v9);
        let v10 = Subscribed{
            user                  : 0x2::tx_context::sender(arg5),
            tier                  : arg3,
            billing_period_epochs : v0,
            amount_paid_in_coin   : v2,
            payment_type          : v4,
            epoch                 : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<Subscribed>(v10);
        (v6, v8, v3)
    }

    public fun update_plan_limits(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::AdminCap, arg1: &mut PlanRegistry, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 3, 100);
        let v0 = (arg2 as u64);
        assert!(v0 < 0x1::vector::length<PlanDef>(&arg1.plans), 115);
        let v1 = 0x1::vector::borrow_mut<PlanDef>(&mut arg1.plans, v0);
        v1.tier = arg2;
        v1.name = arg3;
        v1.max_storage_bytes = arg4;
        v1.max_transforms = arg5;
        v1.max_files_per_job = arg6;
        v1.max_concurrent_jobs = arg7;
        v1.max_walrus_epochs = arg8;
        v1.seal_encryption = arg9;
        v1.priority_processing = arg10;
        v1.points_multiplier = arg11;
        v1.max_files_per_batch = arg12;
        v1.max_total_files = arg13;
        let v2 = PlanLimitsUpdated{
            tier                : arg2,
            name                : arg3,
            max_storage_bytes   : arg4,
            max_transforms      : arg5,
            max_files_per_job   : arg6,
            max_concurrent_jobs : arg7,
            max_walrus_epochs   : arg8,
            seal_encryption     : arg9,
            priority_processing : arg10,
            points_multiplier   : arg11,
            max_files_per_batch : arg12,
            max_total_files     : arg13,
            epoch               : 0x2::tx_context::epoch(arg14),
        };
        0x2::event::emit<PlanLimitsUpdated>(v2);
    }

    public fun upgrade<T0>(arg0: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::GlobalConfig, arg1: &PlanRegistry, arg2: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::Treasury, arg3: &mut Subscription, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_not_paused(arg0);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::assert_version(arg0);
        assert!(arg3.owner == 0x2::tx_context::sender(arg6), 103);
        assert!(arg3.status == 0, 104);
        assert!(arg4 <= 3, 100);
        assert!(arg4 != 3, 123);
        assert!(arg4 > arg3.plan_tier, 105);
        assert!(arg3.expires_epoch > 0x2::tx_context::epoch(arg6), 108);
        let v0 = coin_type_string<T0>();
        assert!(arg3.payment_coin_type == v0, 122);
        let v1 = arg3.expires_epoch - 0x2::tx_context::epoch(arg6);
        let v2 = arg3.billing_period_epochs;
        let v3 = if (v2 > 0) {
            arg3.amount_paid_in_coin * v1 / v2
        } else {
            0
        };
        let v4 = 0x1::vector::borrow<PlanDef>(&arg1.plans, (arg4 as u64));
        let v5 = if (v2 > 0) {
            get_coin_price<T0>(v4) * v1 / v2
        } else {
            0
        };
        let v6 = if (v5 > v3) {
            v5 - v3
        } else {
            0
        };
        let v7 = 0x1::vector::borrow<PlanDef>(&arg1.plans, (arg3.plan_tier as u64)).price_usdc;
        let v8 = v4.price_usdc;
        let v9 = if (v2 > 0 && v8 > v7) {
            (v8 - v7) * v1 / v2
        } else {
            0
        };
        let v10 = pay_and_return_change<T0>(arg2, arg5, v6, v9, arg6);
        arg3.plan_tier = arg4;
        arg3.amount_paid_in_coin = arg3.amount_paid_in_coin + v6;
        arg3.downgrade_to_tier = 0x1::option::none<u8>();
        let v11 = PlanUpgraded{
            user                    : 0x2::tx_context::sender(arg6),
            old_tier                : arg3.plan_tier,
            new_tier                : arg4,
            additional_paid_in_coin : v6,
            payment_type            : v0,
            epoch                   : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<PlanUpgraded>(v11);
        v10
    }

    // decompiled from Move bytecode v7
}

