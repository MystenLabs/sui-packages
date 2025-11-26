module 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ValidatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct CircuitBreaker has copy, drop, store {
        enabled: bool,
        triggered_at_epoch: u64,
        trigger_reason: 0x1::string::String,
        cooldown_epochs: u64,
    }

    struct WithdrawalLimits has copy, drop, store {
        max_per_epoch_bps: u64,
        min_epochs_between: u64,
        last_withdrawal_epoch: u64,
        total_withdrawn_this_epoch: u64,
    }

    struct VestedBalance has copy, drop, store {
        total_amount: u64,
        unlock_start_epoch: u64,
        unlock_duration_epochs: u64,
        claimed_amount: u64,
    }

    struct BlobRegistration has store, key {
        id: 0x2::object::UID,
        uploader: address,
        created_at_epoch: u64,
        walrus_blob_id: 0x1::option::Option<0x1::string::String>,
        preview_blob_id: 0x1::option::Option<0x1::string::String>,
        seal_policy_id: 0x1::string::String,
        preview_blob_hash: 0x1::option::Option<vector<u8>>,
        is_finalized: bool,
        submission_id: 0x1::option::Option<0x2::object::ID>,
        duration_seconds: u64,
        submitted_at_epoch: u64,
    }

    struct AudioSubmission has store, key {
        id: 0x2::object::UID,
        uploader: address,
        walrus_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        preview_blob_hash: 0x1::option::Option<vector<u8>>,
        duration_seconds: u64,
        quality_score: u8,
        status: u8,
        vested_balance: VestedBalance,
        unlocked_balance: u64,
        dataset_price: u64,
        listed_for_sale: bool,
        purchase_count: u64,
        submitted_at_epoch: u64,
    }

    struct AudioFileEntry has copy, drop, store {
        blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        duration: u64,
    }

    struct DatasetSubmission has store, key {
        id: 0x2::object::UID,
        uploader: address,
        files: vector<AudioFileEntry>,
        total_duration: u64,
        file_count: u64,
        bundle_discount_bps: u64,
        quality_score: u8,
        status: u8,
        vested_balance: VestedBalance,
        unlocked_balance: u64,
        dataset_price: u64,
        listed_for_sale: bool,
        purchase_count: u64,
        submitted_at_epoch: u64,
    }

    struct QualityMarketplace has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>,
        reward_pool: 0x2::balance::Balance<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>,
        reward_pool_initial: u64,
        reward_pool_allocated: u64,
        liquidity_vault: 0x2::balance::Balance<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>,
        total_submissions: u64,
        total_purchases: u64,
        total_burned: u64,
        treasury_address: address,
        admin_cap_id: 0x2::object::ID,
        economic_config: 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::EconomicConfig,
        circuit_breaker: CircuitBreaker,
        withdrawal_limits: WithdrawalLimits,
        sui_payments_enabled: bool,
    }

    struct MarketplaceInitialized has copy, drop {
        marketplace_id: 0x2::object::ID,
        initial_supply: u64,
        reward_pool_funded: u64,
        team_allocation: u64,
        team_wallet: address,
    }

    struct BlobRegistrationCreated has copy, drop {
        registration_id: 0x2::object::ID,
        uploader: address,
        seal_policy_id: 0x1::string::String,
        duration_seconds: u64,
        created_at_epoch: u64,
    }

    struct BlobUploadFinalized has copy, drop {
        registration_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        finalized_at_epoch: u64,
    }

    struct SubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        uploader: address,
        seal_policy_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        duration_seconds: u64,
        burn_fee_paid: u64,
        submitted_at_epoch: u64,
    }

    struct SubmissionFinalized has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        quality_score: u8,
        status: u8,
        reward_amount: u64,
        vesting_start_epoch: u64,
        vesting_duration_epochs: u64,
    }

    struct SubmissionReencrypted has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        old_seal_policy_id: 0x1::string::String,
        new_seal_policy_id: 0x1::string::String,
        old_walrus_blob_id: 0x1::string::String,
        new_walrus_blob_id: 0x1::string::String,
        reencrypted_at_epoch: u64,
    }

    struct DatasetSubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        file_count: u64,
        total_duration: u64,
        bundle_discount_bps: u64,
        burn_fee_paid: u64,
        submitted_at_epoch: u64,
    }

    struct DatasetPurchased has copy, drop {
        submission_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        burned: u64,
        burn_rate_bps: u64,
        liquidity_allocated: u64,
        liquidity_rate_bps: u64,
        uploader_paid: u64,
        uploader_rate_bps: u64,
        treasury_paid: u64,
        circulating_supply: u64,
        economic_tier: u8,
        seal_policy_id: 0x1::string::String,
        purchase_timestamp: u64,
    }

    struct DatasetPurchasedWithSUI has copy, drop {
        submission_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        uploader_paid: u64,
        protocol_paid: u64,
        seal_policy_id: 0x1::string::String,
        purchase_timestamp: u64,
    }

    struct VestedTokensClaimed has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        amount_claimed: u64,
        remaining_vested: u64,
    }

    struct CircuitBreakerActivated has copy, drop {
        reason: 0x1::string::String,
        triggered_at_epoch: u64,
        cooldown_epochs: u64,
    }

    struct CircuitBreakerDeactivated has copy, drop {
        deactivated_at_epoch: u64,
    }

    struct LiquidityVaultWithdrawal has copy, drop {
        amount: u64,
        recipient: address,
        reason: 0x1::string::String,
        remaining_balance: u64,
        withdrawn_by: address,
        timestamp_epoch: u64,
    }

    public fun activate_circuit_breaker(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        arg1.circuit_breaker.enabled = true;
        arg1.circuit_breaker.triggered_at_epoch = v0;
        arg1.circuit_breaker.trigger_reason = arg2;
        let v1 = CircuitBreakerActivated{
            reason             : arg1.circuit_breaker.trigger_reason,
            triggered_at_epoch : v0,
            cooldown_epochs    : arg1.circuit_breaker.cooldown_epochs,
        };
        0x2::event::emit<CircuitBreakerActivated>(v1);
    }

    fun calculate_ai_price(arg0: u8, arg1: u64) : u64 {
        if (arg0 >= 90) {
            arg1 * 10
        } else if (arg0 >= 70) {
            arg1 * 5
        } else if (arg0 >= 50) {
            arg1 * 2
        } else {
            arg1
        }
    }

    public fun calculate_unlocked_amount(arg0: &VestedBalance, arg1: u64) : u64 {
        if (arg0.total_amount == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0.unlock_start_epoch) {
            arg1 - arg0.unlock_start_epoch
        } else {
            0
        };
        let v1 = if (v0 >= arg0.unlock_duration_epochs) {
            arg0.total_amount
        } else {
            arg0.total_amount * v0 / arg0.unlock_duration_epochs
        };
        if (v1 > arg0.claimed_amount) {
            v1 - arg0.claimed_amount
        } else {
            0
        }
    }

    public entry fun claim_vested_tokens(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.uploader, 5001);
        let v0 = calculate_unlocked_amount(&arg1.vested_balance, 0x2::tx_context::epoch(arg2));
        assert!(v0 > 0, 6001);
        arg1.vested_balance.claimed_amount = arg1.vested_balance.claimed_amount + v0;
        arg0.reward_pool_allocated = arg0.reward_pool_allocated - v0;
        let v1 = VestedTokensClaimed{
            submission_id    : 0x2::object::uid_to_inner(&arg1.id),
            uploader         : arg1.uploader,
            amount_claimed   : v0,
            remaining_vested : arg1.vested_balance.total_amount - arg1.vested_balance.claimed_amount,
        };
        0x2::event::emit<VestedTokensClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v0, arg2), arg1.uploader);
    }

    public fun deactivate_circuit_breaker(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.circuit_breaker.enabled = false;
        let v0 = CircuitBreakerDeactivated{deactivated_at_epoch: 0x2::tx_context::epoch(arg2)};
        0x2::event::emit<CircuitBreakerDeactivated>(v0);
    }

    public entry fun finalize_submission(arg0: &ValidatorCap, arg1: &mut QualityMarketplace, arg2: &mut AudioSubmission, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 2003);
        assert!(arg3 <= 100, 2004);
        let v0 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_reward(get_circulating_supply(arg1), arg3);
        let v1 = if (arg3 >= 30) {
            1
        } else {
            2
        };
        if (v1 == 1) {
            assert!(0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg1.reward_pool) - arg1.reward_pool_allocated >= v0, 2005);
            arg1.reward_pool_allocated = arg1.reward_pool_allocated + v0;
            let v2 = 0x2::tx_context::epoch(arg4);
            let v3 = VestedBalance{
                total_amount           : v0,
                unlock_start_epoch     : v2,
                unlock_duration_epochs : 90,
                claimed_amount         : 0,
            };
            arg2.vested_balance = v3;
            let v4 = SubmissionFinalized{
                submission_id           : 0x2::object::uid_to_inner(&arg2.id),
                uploader                : arg2.uploader,
                quality_score           : arg3,
                status                  : v1,
                reward_amount           : v0,
                vesting_start_epoch     : v2,
                vesting_duration_epochs : 90,
            };
            0x2::event::emit<SubmissionFinalized>(v4);
        } else {
            let v5 = SubmissionFinalized{
                submission_id           : 0x2::object::uid_to_inner(&arg2.id),
                uploader                : arg2.uploader,
                quality_score           : arg3,
                status                  : v1,
                reward_amount           : 0,
                vesting_start_epoch     : 0,
                vesting_duration_epochs : 0,
            };
            0x2::event::emit<SubmissionFinalized>(v5);
        };
        if (v1 == 1) {
            arg2.dataset_price = calculate_ai_price(arg3, v0);
            arg2.listed_for_sale = true;
        };
        arg2.quality_score = arg3;
        arg2.status = v1;
    }

    public fun finalize_submission_from_session(arg0: &mut QualityMarketplace, arg1: &mut 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::VerificationSession, arg2: &mut 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::SessionRegistry, arg3: &mut 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::storage_lease::LeaseRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg7), 5002);
        assert!(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::is_encrypted(arg1), 3002);
        assert!(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::is_approved(arg1), 3002);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::owner(arg1) == v0, 5001);
        let v1 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::encrypted_cid(arg1);
        let v2 = *0x1::option::borrow<0x1::string::String>(&v1);
        let v3 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::preview_cid(arg1);
        let v4 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::seal_policy_id(arg1);
        let v5 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::quality_score(arg1);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v6 >= 250000000, 2001);
        assert!(v6 <= 10000000000, 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        let v7 = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_reward(get_circulating_supply(arg0), v5);
        assert!(0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= v7, 2002);
        arg0.reward_pool_allocated = arg0.reward_pool_allocated + v7;
        let v8 = 0x2::object::new(arg7);
        let v9 = 0x2::object::uid_to_inner(&v8);
        let v10 = 0x2::tx_context::epoch(arg7);
        let v11 = VestedBalance{
            total_amount           : v7,
            unlock_start_epoch     : v10,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v12 = AudioSubmission{
            id                 : v8,
            uploader           : v0,
            walrus_blob_id     : v2,
            preview_blob_id    : *0x1::option::borrow<0x1::string::String>(&v3),
            seal_policy_id     : *0x1::option::borrow<0x1::string::String>(&v4),
            preview_blob_hash  : 0x1::option::none<vector<u8>>(),
            duration_seconds   : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::duration_seconds(arg1),
            quality_score      : v5,
            status             : 1,
            vested_balance     : v11,
            unlocked_balance   : 0,
            dataset_price      : arg6,
            listed_for_sale    : arg6 > 0,
            purchase_count     : 0,
            submitted_at_epoch : v10,
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::link_submission(arg1, v9, arg2, arg7);
        0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::storage_lease::create_lease(arg3, v9, v2, 0x1::string::utf8(b""), 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::verification_session::plaintext_size_bytes(arg1), arg5, arg7);
        let v13 = SubmissionFinalized{
            submission_id           : v9,
            uploader                : v0,
            quality_score           : v5,
            status                  : 1,
            reward_amount           : v7,
            vesting_start_epoch     : v10,
            vesting_duration_epochs : 90,
        };
        0x2::event::emit<SubmissionFinalized>(v13);
        0x2::transfer::transfer<AudioSubmission>(v12, v0);
    }

    public entry fun finalize_submission_with_blob(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: BlobRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_finalized, 2008);
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg6), 5002);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 >= 250000000, 2001);
        assert!(v2 <= 10000000000, 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        assert!(0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_reward(get_circulating_supply(arg0), 30), 2002);
        let v3 = BlobUploadFinalized{
            registration_id    : v1,
            walrus_blob_id     : arg3,
            preview_blob_id    : arg4,
            seal_policy_id     : arg2.seal_policy_id,
            finalized_at_epoch : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<BlobUploadFinalized>(v3);
        let v4 = 0x2::object::new(arg6);
        let v5 = VestedBalance{
            total_amount           : 0,
            unlock_start_epoch     : 0,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v6 = AudioSubmission{
            id                 : v4,
            uploader           : v0,
            walrus_blob_id     : arg3,
            preview_blob_id    : arg4,
            seal_policy_id     : arg2.seal_policy_id,
            preview_blob_hash  : arg5,
            duration_seconds   : arg2.duration_seconds,
            quality_score      : 0,
            status             : 0,
            vested_balance     : v5,
            unlocked_balance   : 0,
            dataset_price      : 0,
            listed_for_sale    : false,
            purchase_count     : 0,
            submitted_at_epoch : 0x2::tx_context::epoch(arg6),
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        let v7 = SubmissionCreated{
            submission_id      : 0x2::object::uid_to_inner(&v4),
            registration_id    : v1,
            uploader           : v0,
            seal_policy_id     : v6.seal_policy_id,
            walrus_blob_id     : v6.walrus_blob_id,
            preview_blob_id    : v6.preview_blob_id,
            duration_seconds   : v6.duration_seconds,
            burn_fee_paid      : v2,
            submitted_at_epoch : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<SubmissionCreated>(v7);
        let BlobRegistration {
            id                 : v8,
            uploader           : _,
            created_at_epoch   : _,
            walrus_blob_id     : _,
            preview_blob_id    : _,
            seal_policy_id     : _,
            preview_blob_hash  : _,
            is_finalized       : _,
            submission_id      : _,
            duration_seconds   : _,
            submitted_at_epoch : _,
        } = arg2;
        0x2::object::delete(v8);
        0x2::transfer::transfer<AudioSubmission>(v6, v0);
    }

    public fun get_circulating_supply(arg0: &QualityMarketplace) : u64 {
        let v0 = 0x2::coin::total_supply<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.treasury_cap);
        let v1 = 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) + 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.liquidity_vault);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun get_current_burn_rate(arg0: &QualityMarketplace) : u64 {
        0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::burn_bps(get_circulating_supply(arg0), &arg0.economic_config)
    }

    public fun get_current_tier(arg0: &QualityMarketplace) : u8 {
        0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::get_tier(get_circulating_supply(arg0), &arg0.economic_config)
    }

    public fun get_marketplace_stats(arg0: &QualityMarketplace) : (u64, u64, u64, u64, u64) {
        (arg0.total_submissions, arg0.total_purchases, arg0.total_burned, 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool), 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.liquidity_vault))
    }

    public fun get_submission_info(arg0: &AudioSubmission) : (address, u8, u8, u64, bool, u64) {
        (arg0.uploader, arg0.quality_score, arg0.status, arg0.dataset_price, arg0.listed_for_sale, arg0.purchase_count)
    }

    public fun get_vesting_info(arg0: &AudioSubmission, arg1: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        (arg0.vested_balance.total_amount, arg0.vested_balance.claimed_amount, calculate_unlocked_amount(&arg0.vested_balance, 0x2::tx_context::epoch(arg1)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_marketplace(arg0: 0x2::coin::TreasuryCap<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 100000000000000000;
        let v1 = 0x2::coin::mint<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg0, v0, arg3);
        let v2 = 70000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(v1, arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg3)};
        let v4 = ValidatorCap{id: 0x2::object::new(arg3)};
        let v5 = CircuitBreaker{
            enabled            : false,
            triggered_at_epoch : 0,
            trigger_reason     : 0x1::string::utf8(b""),
            cooldown_epochs    : 24,
        };
        let v6 = WithdrawalLimits{
            max_per_epoch_bps          : 1000,
            min_epochs_between         : 7,
            last_withdrawal_epoch      : 0,
            total_withdrawn_this_epoch : 0,
        };
        let v7 = QualityMarketplace{
            id                    : 0x2::object::new(arg3),
            treasury_cap          : arg0,
            reward_pool           : 0x2::coin::into_balance<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut v1, v2, arg3)),
            reward_pool_initial   : v2,
            reward_pool_allocated : 0,
            liquidity_vault       : 0x2::balance::zero<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(),
            total_submissions     : 0,
            total_purchases       : 0,
            total_burned          : 0,
            treasury_address      : arg2,
            admin_cap_id          : 0x2::object::id<AdminCap>(&v3),
            economic_config       : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::default_config(),
            circuit_breaker       : v5,
            withdrawal_limits     : v6,
            sui_payments_enabled  : true,
        };
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ValidatorCap>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<QualityMarketplace>(v7);
        let v8 = MarketplaceInitialized{
            marketplace_id     : 0x2::object::id<QualityMarketplace>(&v7),
            initial_supply     : v0,
            reward_pool_funded : v2,
            team_allocation    : 30000000000000000,
            team_wallet        : arg1,
        };
        0x2::event::emit<MarketplaceInitialized>(v8);
    }

    public fun is_circuit_breaker_active(arg0: &CircuitBreaker, arg1: &0x2::tx_context::TxContext) : bool {
        if (!arg0.enabled) {
            return false
        };
        0x2::tx_context::epoch(arg1) < arg0.triggered_at_epoch + arg0.cooldown_epochs
    }

    public fun list_for_sale(arg0: &mut AudioSubmission, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.uploader, 5001);
        assert!(arg0.status == 1, 3002);
        arg0.listed_for_sale = true;
        arg0.dataset_price = arg1;
    }

    public entry fun purchase_dataset(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: 0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg3), 5002);
        assert!(arg1.status == 1, 3002);
        assert!(arg1.listed_for_sale, 3001);
        let v0 = arg1.dataset_price;
        assert!(0x2::coin::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg2) >= v0, 3003);
        let v1 = get_circulating_supply(arg0);
        let (v2, v3, v4, v5) = 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_purchase_splits(v0, v1, &arg0.economic_config);
        if (v2 > 0) {
            0x2::balance::decrease_supply<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg2, v2, arg3)));
            arg0.total_burned = arg0.total_burned + v2;
        };
        if (v3 > 0) {
            0x2::balance::join<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg0.liquidity_vault, 0x2::coin::into_balance<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg2, v3, arg3)));
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg2, v5, arg3), arg0.treasury_address);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg2, v4, arg3), arg1.uploader);
        };
        if (0x2::coin::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(arg2);
        };
        let v6 = calculate_unlocked_amount(&arg1.vested_balance, 0x2::tx_context::epoch(arg3));
        if (v6 > 0) {
            arg1.vested_balance.claimed_amount = arg1.vested_balance.claimed_amount + v6;
            arg0.reward_pool_allocated = arg0.reward_pool_allocated - v6;
            arg1.unlocked_balance = arg1.unlocked_balance + v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v6, arg3), arg1.uploader);
        };
        arg1.purchase_count = arg1.purchase_count + 1;
        arg0.total_purchases = arg0.total_purchases + 1;
        let v7 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::purchase_policy::PurchaseReceipt>(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::purchase_policy::mint_receipt(arg1.seal_policy_id, 0x2::object::uid_to_inner(&arg1.id), v7, arg3), v7);
        let v8 = DatasetPurchased{
            submission_id       : 0x2::object::uid_to_inner(&arg1.id),
            buyer               : v7,
            price               : v0,
            burned              : v2,
            burn_rate_bps       : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::burn_bps(v1, &arg0.economic_config),
            liquidity_allocated : v3,
            liquidity_rate_bps  : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::liquidity_bps(v1, &arg0.economic_config),
            uploader_paid       : v4,
            uploader_rate_bps   : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::uploader_bps(v1, &arg0.economic_config),
            treasury_paid       : v5,
            circulating_supply  : v1,
            economic_tier       : 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::get_tier(v1, &arg0.economic_config),
            seal_policy_id      : arg1.seal_policy_id,
            purchase_timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DatasetPurchased>(v8);
    }

    public fun purchase_dataset_with_sui(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sui_payments_enabled, 3004);
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg3), 5002);
        assert!(arg1.status == 1, 3002);
        assert!(arg1.listed_for_sale, 3001);
        let v0 = arg1.dataset_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 3003);
        let v1 = v0 * 6000 / 10000;
        let v2 = v0 - v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3), arg0.treasury_address);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg3), arg1.uploader);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        arg1.purchase_count = arg1.purchase_count + 1;
        arg0.total_purchases = arg0.total_purchases + 1;
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::purchase_policy::PurchaseReceipt>(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::purchase_policy::mint_receipt(arg1.seal_policy_id, 0x2::object::uid_to_inner(&arg1.id), v3, arg3), v3);
        let v4 = DatasetPurchasedWithSUI{
            submission_id      : 0x2::object::uid_to_inner(&arg1.id),
            buyer              : v3,
            price              : v0,
            uploader_paid      : v1,
            protocol_paid      : v2,
            seal_policy_id     : arg1.seal_policy_id,
            purchase_timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DatasetPurchasedWithSUI>(v4);
    }

    public entry fun reencrypt_submission(arg0: &mut AudioSubmission, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.uploader == 0x2::tx_context::sender(arg3), 2010);
        arg0.seal_policy_id = arg2;
        arg0.walrus_blob_id = arg1;
        let v0 = SubmissionReencrypted{
            submission_id        : 0x2::object::uid_to_inner(&arg0.id),
            uploader             : arg0.uploader,
            old_seal_policy_id   : arg0.seal_policy_id,
            new_seal_policy_id   : arg0.seal_policy_id,
            old_walrus_blob_id   : arg0.walrus_blob_id,
            new_walrus_blob_id   : arg0.walrus_blob_id,
            reencrypted_at_epoch : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SubmissionReencrypted>(v0);
    }

    public entry fun register_blob_intent(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = BlobRegistration{
            id                 : v0,
            uploader           : 0x2::tx_context::sender(arg2),
            created_at_epoch   : 0x2::tx_context::epoch(arg2),
            walrus_blob_id     : 0x1::option::none<0x1::string::String>(),
            preview_blob_id    : 0x1::option::none<0x1::string::String>(),
            seal_policy_id     : arg0,
            preview_blob_hash  : 0x1::option::none<vector<u8>>(),
            is_finalized       : false,
            submission_id      : 0x1::option::none<0x2::object::ID>(),
            duration_seconds   : arg1,
            submitted_at_epoch : 0x2::tx_context::epoch(arg2),
        };
        let v2 = BlobRegistrationCreated{
            registration_id  : 0x2::object::uid_to_inner(&v0),
            uploader         : 0x2::tx_context::sender(arg2),
            seal_policy_id   : arg0,
            duration_seconds : arg1,
            created_at_epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<BlobRegistrationCreated>(v2);
        0x2::transfer::transfer<BlobRegistration>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun submit_audio(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<vector<u8>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg7), 5002);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= 250000000, 2001);
        assert!(v1 <= 10000000000, 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        assert!(0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_reward(get_circulating_supply(arg0), 30), 2002);
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::new(arg7);
        0x2::object::delete(v3);
        let v4 = VestedBalance{
            total_amount           : 0,
            unlock_start_epoch     : 0,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v5 = AudioSubmission{
            id                 : v2,
            uploader           : v0,
            walrus_blob_id     : arg2,
            preview_blob_id    : arg3,
            seal_policy_id     : arg4,
            preview_blob_hash  : arg5,
            duration_seconds   : arg6,
            quality_score      : 50,
            status             : 1,
            vested_balance     : v4,
            unlocked_balance   : 0,
            dataset_price      : v1,
            listed_for_sale    : true,
            purchase_count     : 0,
            submitted_at_epoch : 0x2::tx_context::epoch(arg7),
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        let v6 = SubmissionCreated{
            submission_id      : 0x2::object::uid_to_inner(&v2),
            registration_id    : 0x2::object::uid_to_inner(&v3),
            uploader           : v0,
            seal_policy_id     : v5.seal_policy_id,
            walrus_blob_id     : v5.walrus_blob_id,
            preview_blob_id    : v5.preview_blob_id,
            duration_seconds   : arg6,
            burn_fee_paid      : v1,
            submitted_at_epoch : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<SubmissionCreated>(v6);
        0x2::transfer::transfer<AudioSubmission>(v5, v0);
    }

    public entry fun submit_audio_dataset(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg7), 5002);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 > 0, 2006);
        assert!(v0 <= 100, 2006);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == v0, 2006);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v0, 2006);
        assert!(0x1::vector::length<u64>(&arg5) == v0, 2006);
        assert!(arg6 == 1000, 2006);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = (v0 as u64);
        assert!(v2 >= v3 * 250000000 * 9 / 10, 2001);
        assert!(v2 <= v3 * 10000000000 * 9 / 10, 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        assert!(0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::calculate_reward(get_circulating_supply(arg0), 30), 2002);
        let v4 = 0x1::vector::empty<AudioFileEntry>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = AudioFileEntry{
                blob_id         : *0x1::vector::borrow<0x1::string::String>(&arg2, v6),
                preview_blob_id : *0x1::vector::borrow<0x1::string::String>(&arg3, v6),
                seal_policy_id  : *0x1::vector::borrow<0x1::string::String>(&arg4, v6),
                duration        : *0x1::vector::borrow<u64>(&arg5, v6),
            };
            v5 = v5 + *0x1::vector::borrow<u64>(&arg5, v6);
            0x1::vector::push_back<AudioFileEntry>(&mut v4, v7);
            v6 = v6 + 1;
        };
        let v8 = 0x2::object::new(arg7);
        let v9 = VestedBalance{
            total_amount           : 0,
            unlock_start_epoch     : 0,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v10 = DatasetSubmission{
            id                  : v8,
            uploader            : v1,
            files               : v4,
            total_duration      : v5,
            file_count          : v0,
            bundle_discount_bps : arg6,
            quality_score       : 50,
            status              : 1,
            vested_balance      : v9,
            unlocked_balance    : 0,
            dataset_price       : v2,
            listed_for_sale     : true,
            purchase_count      : 0,
            submitted_at_epoch  : 0x2::tx_context::epoch(arg7),
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        let v11 = DatasetSubmissionCreated{
            submission_id       : 0x2::object::uid_to_inner(&v8),
            uploader            : v1,
            file_count          : v0,
            total_duration      : v5,
            bundle_discount_bps : arg6,
            burn_fee_paid       : v2,
            submitted_at_epoch  : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<DatasetSubmissionCreated>(v11);
        0x2::transfer::transfer<DatasetSubmission>(v10, v1);
    }

    public fun toggle_sui_payments(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: bool) {
        arg1.sui_payments_enabled = arg2;
    }

    public fun unlist_from_sale(arg0: &mut AudioSubmission, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.uploader, 5001);
        arg0.listed_for_sale = false;
    }

    public fun update_economic_config(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::EconomicConfig) {
        assert!(0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::validate_config(&arg2), 5001);
        arg1.economic_config = arg2;
    }

    public fun update_economic_config_entry(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        update_economic_config(arg0, arg1, 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::economics::create_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13));
    }

    public fun update_price(arg0: &mut AudioSubmission, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.uploader, 5001);
        arg0.dataset_price = arg1;
    }

    public fun withdraw_liquidity_vault(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = &mut arg1.withdrawal_limits;
        if (v1.last_withdrawal_epoch > 0) {
            assert!(v0 >= v1.last_withdrawal_epoch + v1.min_epochs_between, 5004);
        };
        if (v0 > v1.last_withdrawal_epoch) {
            v1.total_withdrawn_this_epoch = 0;
        };
        assert!(v1.total_withdrawn_this_epoch + arg2 <= 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg1.liquidity_vault) * v1.max_per_epoch_bps / 10000, 5005);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&mut arg1.liquidity_vault, arg2, arg5), arg3);
        v1.total_withdrawn_this_epoch = v1.total_withdrawn_this_epoch + arg2;
        v1.last_withdrawal_epoch = v0;
        let v2 = LiquidityVaultWithdrawal{
            amount            : arg2,
            recipient         : arg3,
            reason            : arg4,
            remaining_balance : 0x2::balance::value<0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token::SONAR_TOKEN>(&arg1.liquidity_vault),
            withdrawn_by      : 0x2::tx_context::sender(arg5),
            timestamp_epoch   : v0,
        };
        0x2::event::emit<LiquidityVaultWithdrawal>(v2);
    }

    // decompiled from Move bytecode v6
}

