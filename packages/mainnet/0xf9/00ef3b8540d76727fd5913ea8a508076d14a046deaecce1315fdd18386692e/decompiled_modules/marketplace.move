module 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::marketplace {
    struct VotingStatsKey has copy, drop, store {
        dummy_field: bool,
    }

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

    struct KioskDesk has store {
        sonar_reserve: 0x2::balance::Balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        base_sonar_price: u64,
        price_override: 0x1::option::Option<u64>,
        current_tier: u8,
        sui_cut_percentage: u64,
        total_sonar_sold: u64,
        total_datasets_purchased: u64,
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

    struct VotingStats has copy, drop, store {
        upvotes: u64,
        downvotes: u64,
        voters: 0x2::vec_set::VecSet<address>,
    }

    struct AudioSubmission has store, key {
        id: 0x2::object::UID,
        uploader: address,
        walrus_blob_id: 0x1::string::String,
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
        treasury_cap: 0x2::coin::TreasuryCap<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>,
        reward_pool: 0x2::balance::Balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>,
        reward_pool_initial: u64,
        reward_pool_allocated: u64,
        liquidity_vault: 0x2::balance::Balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>,
        kiosk: KioskDesk,
        total_submissions: u64,
        total_purchases: u64,
        total_burned: u64,
        treasury_address: address,
        admin_cap_id: 0x2::object::ID,
        economic_config: 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::EconomicConfig,
        circuit_breaker: CircuitBreaker,
        withdrawal_limits: WithdrawalLimits,
    }

    struct MarketplaceInitialized has copy, drop {
        marketplace_id: 0x2::object::ID,
        initial_supply: u64,
        reward_pool_funded: u64,
        team_allocation: u64,
        team_wallet: address,
    }

    struct SubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        seal_policy_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
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

    struct KioskFunded has copy, drop {
        amount: u64,
    }

    struct SonarSold has copy, drop {
        buyer: address,
        sui_amount: u64,
        sonar_amount: u64,
    }

    struct DatasetPurchasedViaKiosk has copy, drop {
        buyer: address,
        dataset_id: 0x2::object::ID,
        sonar_amount: u64,
    }

    struct KioskPriceUpdated has copy, drop {
        base_price: u64,
        override_price: 0x1::option::Option<u64>,
        tier: u8,
    }

    struct KioskSuiCutUpdated has copy, drop {
        percentage: u64,
    }

    struct VoteCast has copy, drop {
        submission_id: 0x2::object::ID,
        voter: address,
        is_upvote: bool,
        new_upvotes: u64,
        new_downvotes: u64,
        net_score: u64,
        timestamp: u64,
    }

    struct VoteRemoved has copy, drop {
        submission_id: 0x2::object::ID,
        voter: address,
        was_upvote: bool,
        new_upvotes: u64,
        new_downvotes: u64,
        net_score: u64,
    }

    struct SubmissionGraduated has copy, drop {
        submission_id: 0x2::object::ID,
        uploader: address,
        net_score: u64,
        timestamp: u64,
    }

    public entry fun activate_circuit_breaker(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
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

    fun ceil_div_sui_payment(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 % 1000000000;
        let v1 = arg0 / 1000000000 * arg1;
        let v2 = v1;
        if (v0 > 0) {
            v2 = v1 + (v0 * arg1 + 1000000000 - 1) / 1000000000;
        };
        v2
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v0, arg2), arg1.uploader);
    }

    public entry fun deactivate_circuit_breaker(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.circuit_breaker.enabled = false;
        let v0 = CircuitBreakerDeactivated{deactivated_at_epoch: 0x2::tx_context::epoch(arg2)};
        0x2::event::emit<CircuitBreakerDeactivated>(v0);
    }

    public entry fun finalize_submission(arg0: &ValidatorCap, arg1: &mut QualityMarketplace, arg2: &mut AudioSubmission, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 2003);
        assert!(arg3 <= 100, 2004);
        let v0 = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_reward(get_circulating_supply(arg1), arg3);
        let v1 = if (arg3 >= 30) {
            1
        } else {
            2
        };
        if (v1 == 1) {
            assert!(0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg1.reward_pool) - arg1.reward_pool_allocated >= v0, 2005);
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
        arg2.quality_score = arg3;
        arg2.status = v1;
    }

    public entry fun fund_kiosk_sonar(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>) {
        0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg1.kiosk.sonar_reserve, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(arg2));
        let v0 = KioskFunded{amount: 0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg2)};
        0x2::event::emit<KioskFunded>(v0);
    }

    public fun get_circulating_supply(arg0: &QualityMarketplace) : u64 {
        let v0 = 0x2::coin::total_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.treasury_cap);
        let v1 = 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) + 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.liquidity_vault);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun get_current_burn_rate(arg0: &QualityMarketplace) : u64 {
        0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::burn_bps(get_circulating_supply(arg0), &arg0.economic_config)
    }

    public fun get_current_tier(arg0: &QualityMarketplace) : u8 {
        0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::get_tier(get_circulating_supply(arg0), &arg0.economic_config)
    }

    public fun get_kiosk_price(arg0: &QualityMarketplace) : u64 {
        if (0x1::option::is_some<u64>(&arg0.kiosk.price_override)) {
            *0x1::option::borrow<u64>(&arg0.kiosk.price_override)
        } else {
            arg0.kiosk.base_sonar_price
        }
    }

    public fun get_marketplace_stats(arg0: &QualityMarketplace) : (u64, u64, u64, u64, u64) {
        (arg0.total_submissions, arg0.total_purchases, arg0.total_burned, 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.reward_pool), 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.liquidity_vault))
    }

    public fun get_net_score(arg0: &AudioSubmission) : u64 {
        let v0 = get_voting_stats(arg0);
        if (v0.upvotes >= v0.downvotes) {
            v0.upvotes - v0.downvotes
        } else {
            0
        }
    }

    fun get_or_create_voting_stats(arg0: &mut AudioSubmission) : &mut VotingStats {
        let v0 = VotingStatsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<VotingStatsKey>(&arg0.id, v0)) {
            let v1 = VotingStats{
                upvotes   : 0,
                downvotes : 0,
                voters    : 0x2::vec_set::empty<address>(),
            };
            0x2::dynamic_field::add<VotingStatsKey, VotingStats>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_field::borrow_mut<VotingStatsKey, VotingStats>(&mut arg0.id, v0)
    }

    public fun get_submission_info(arg0: &AudioSubmission) : (address, u8, u8, u64, bool, u64) {
        (arg0.uploader, arg0.quality_score, arg0.status, arg0.dataset_price, arg0.listed_for_sale, arg0.purchase_count)
    }

    public fun get_vesting_info(arg0: &AudioSubmission, arg1: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        (arg0.vested_balance.total_amount, arg0.vested_balance.claimed_amount, calculate_unlocked_amount(&arg0.vested_balance, 0x2::tx_context::epoch(arg1)))
    }

    public fun get_vote_count(arg0: &AudioSubmission) : (u64, u64, u64) {
        let v0 = get_voting_stats(arg0);
        let v1 = if (v0.upvotes >= v0.downvotes) {
            v0.upvotes - v0.downvotes
        } else {
            0
        };
        (v0.upvotes, v0.downvotes, v1)
    }

    fun get_voting_stats(arg0: &AudioSubmission) : VotingStats {
        let v0 = VotingStatsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<VotingStatsKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<VotingStatsKey, VotingStats>(&arg0.id, v0)
        } else {
            VotingStats{upvotes: 0, downvotes: 0, voters: 0x2::vec_set::empty<address>()}
        }
    }

    public fun has_voted(arg0: &AudioSubmission, arg1: address) : bool {
        let v0 = get_voting_stats(arg0);
        0x2::vec_set::contains<address>(&v0.voters, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_marketplace(arg0: 0x2::coin::TreasuryCap<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 100000000000000000;
        let v1 = 0x2::coin::mint<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0, v0, arg3);
        let v2 = 70000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(v1, arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg3)};
        let v4 = ValidatorCap{id: 0x2::object::new(arg3)};
        let v5 = KioskDesk{
            sonar_reserve            : 0x2::balance::zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(),
            sui_reserve              : 0x2::balance::zero<0x2::sui::SUI>(),
            base_sonar_price         : 1000000000,
            price_override           : 0x1::option::none<u64>(),
            current_tier             : 1,
            sui_cut_percentage       : 5,
            total_sonar_sold         : 0,
            total_datasets_purchased : 0,
        };
        let v6 = CircuitBreaker{
            enabled            : false,
            triggered_at_epoch : 0,
            trigger_reason     : 0x1::string::utf8(b""),
            cooldown_epochs    : 24,
        };
        let v7 = WithdrawalLimits{
            max_per_epoch_bps          : 1000,
            min_epochs_between         : 7,
            last_withdrawal_epoch      : 0,
            total_withdrawn_this_epoch : 0,
        };
        let v8 = QualityMarketplace{
            id                    : 0x2::object::new(arg3),
            treasury_cap          : arg0,
            reward_pool           : 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v1, v2, arg3)),
            reward_pool_initial   : v2,
            reward_pool_allocated : 0,
            liquidity_vault       : 0x2::balance::zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(),
            kiosk                 : v5,
            total_submissions     : 0,
            total_purchases       : 0,
            total_burned          : 0,
            treasury_address      : arg2,
            admin_cap_id          : 0x2::object::id<AdminCap>(&v3),
            economic_config       : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::default_config(),
            circuit_breaker       : v6,
            withdrawal_limits     : v7,
        };
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ValidatorCap>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<QualityMarketplace>(v8);
        let v9 = MarketplaceInitialized{
            marketplace_id     : 0x2::object::id<QualityMarketplace>(&v8),
            initial_supply     : v0,
            reward_pool_funded : v2,
            team_allocation    : 30000000000000000,
            team_wallet        : arg1,
        };
        0x2::event::emit<MarketplaceInitialized>(v9);
    }

    public fun is_circuit_breaker_active(arg0: &CircuitBreaker, arg1: &0x2::tx_context::TxContext) : bool {
        if (!arg0.enabled) {
            return false
        };
        0x2::tx_context::epoch(arg1) < arg0.triggered_at_epoch + arg0.cooldown_epochs
    }

    public entry fun list_for_sale(arg0: &mut AudioSubmission, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.uploader, 5001);
        assert!(arg0.status == 1, 3002);
        arg0.listed_for_sale = true;
        arg0.dataset_price = arg1;
    }

    public entry fun purchase_dataset(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: 0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg3), 5002);
        assert!(arg1.status == 1, 3002);
        assert!(arg1.listed_for_sale, 3001);
        let v0 = arg1.dataset_price;
        assert!(0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg2) >= v0, 3003);
        let v1 = get_circulating_supply(arg0);
        let v2 = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::get_tier(v1, &arg0.economic_config);
        update_kiosk_tier_and_price(arg0);
        let (v3, v4, v5, v6) = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_purchase_splits(v0, v1, &arg0.economic_config);
        if (v3 > 0) {
            0x2::balance::decrease_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v3, arg3)));
            arg0.total_burned = arg0.total_burned + v3;
        };
        if (v4 > 0) {
            let v7 = 0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v4, arg3);
            let v8 = v4 * arg0.kiosk.sui_cut_percentage / 100;
            if (v8 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v7, v8, arg3)));
            };
            if (v4 - v8 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.liquidity_vault, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v7));
            } else {
                0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v7);
            };
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v6, arg3), arg0.treasury_address);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v5, arg3), arg1.uploader);
        };
        if (0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(arg2);
        };
        let v9 = calculate_unlocked_amount(&arg1.vested_balance, 0x2::tx_context::epoch(arg3));
        if (v9 > 0) {
            arg1.vested_balance.claimed_amount = arg1.vested_balance.claimed_amount + v9;
            arg0.reward_pool_allocated = arg0.reward_pool_allocated - v9;
            arg1.unlocked_balance = arg1.unlocked_balance + v9;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v9, arg3), arg1.uploader);
        };
        arg1.purchase_count = arg1.purchase_count + 1;
        arg0.total_purchases = arg0.total_purchases + 1;
        let v10 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::purchase_policy::PurchaseReceipt>(0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::purchase_policy::mint_receipt(arg1.seal_policy_id, 0x2::object::uid_to_inner(&arg1.id), v10, arg3), v10);
        let v11 = DatasetPurchased{
            submission_id       : 0x2::object::uid_to_inner(&arg1.id),
            buyer               : v10,
            price               : v0,
            burned              : v3,
            burn_rate_bps       : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::burn_bps(v1, &arg0.economic_config),
            liquidity_allocated : v4,
            liquidity_rate_bps  : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::liquidity_bps(v1, &arg0.economic_config),
            uploader_paid       : v5,
            uploader_rate_bps   : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::uploader_bps(v1, &arg0.economic_config),
            treasury_paid       : v6,
            circulating_supply  : v1,
            economic_tier       : v2,
            seal_policy_id      : arg1.seal_policy_id,
            purchase_timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DatasetPurchased>(v11);
    }

    public entry fun purchase_dataset_kiosk(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: 0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg3), 5002);
        assert!(arg1.status == 1, 3002);
        assert!(arg1.listed_for_sale, 3001);
        let v0 = arg1.dataset_price;
        assert!(0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg2) >= v0, 3003);
        let v1 = get_circulating_supply(arg0);
        let v2 = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::get_tier(v1, &arg0.economic_config);
        update_kiosk_tier_and_price(arg0);
        let (v3, v4, v5, v6) = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_purchase_splits(v0, v1, &arg0.economic_config);
        if (v3 > 0) {
            0x2::balance::decrease_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v3, arg3)));
            arg0.total_burned = arg0.total_burned + v3;
        };
        if (v4 > 0) {
            let v7 = 0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v4, arg3);
            let v8 = v4 * arg0.kiosk.sui_cut_percentage / 100;
            if (v8 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v7, v8, arg3)));
            };
            if (v4 - v8 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.liquidity_vault, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v7));
            } else {
                0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v7);
            };
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v6, arg3), arg0.treasury_address);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg2, v5, arg3), arg1.uploader);
        };
        if (0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(arg2);
        };
        let v9 = calculate_unlocked_amount(&arg1.vested_balance, 0x2::tx_context::epoch(arg3));
        if (v9 > 0) {
            arg1.vested_balance.claimed_amount = arg1.vested_balance.claimed_amount + v9;
            arg0.reward_pool_allocated = arg0.reward_pool_allocated - v9;
            arg1.unlocked_balance = arg1.unlocked_balance + v9;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v9, arg3), arg1.uploader);
        };
        arg1.purchase_count = arg1.purchase_count + 1;
        arg0.total_purchases = arg0.total_purchases + 1;
        arg0.kiosk.total_datasets_purchased = arg0.kiosk.total_datasets_purchased + 1;
        let v10 = DatasetPurchasedViaKiosk{
            buyer        : 0x2::tx_context::sender(arg3),
            dataset_id   : 0x2::object::uid_to_inner(&arg1.id),
            sonar_amount : v0,
        };
        0x2::event::emit<DatasetPurchasedViaKiosk>(v10);
        let v11 = DatasetPurchased{
            submission_id       : 0x2::object::uid_to_inner(&arg1.id),
            buyer               : 0x2::tx_context::sender(arg3),
            price               : v0,
            burned              : v3,
            burn_rate_bps       : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::burn_bps(v1, &arg0.economic_config),
            liquidity_allocated : v4,
            liquidity_rate_bps  : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::liquidity_bps(v1, &arg0.economic_config),
            uploader_paid       : v5,
            uploader_rate_bps   : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::uploader_bps(v1, &arg0.economic_config),
            treasury_paid       : v6,
            circulating_supply  : v1,
            economic_tier       : v2,
            seal_policy_id      : arg1.seal_policy_id,
            purchase_timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DatasetPurchased>(v11);
    }

    public entry fun purchase_dataset_kiosk_with_sui(arg0: &mut QualityMarketplace, arg1: &mut AudioSubmission, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 3002);
        assert!(arg1.listed_for_sale, 3001);
        update_kiosk_tier_and_price(arg0);
        let v0 = get_kiosk_price(arg0);
        assert!(v0 > 0, 4002);
        let v1 = arg1.dataset_price;
        let v2 = ceil_div_sui_payment(v1, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 3003);
        assert!(0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.kiosk.sonar_reserve) >= v1, 4001);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.kiosk.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = 0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, v1, arg3);
        let v4 = get_circulating_supply(arg0);
        let (v5, v6, v7, v8) = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_purchase_splits(v1, v4, &arg0.economic_config);
        if (v5 > 0) {
            0x2::balance::decrease_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v3, v5, arg3)));
            arg0.total_burned = arg0.total_burned + v5;
        };
        if (v6 > 0) {
            let v9 = 0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v3, v6, arg3);
            let v10 = v6 * arg0.kiosk.sui_cut_percentage / 100;
            if (v10 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v9, v10, arg3)));
            };
            if (v6 - v10 > 0) {
                0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.liquidity_vault, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v9));
            } else {
                0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v9);
            };
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v3, v8, arg3), arg0.treasury_address);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::split<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut v3, v7, arg3), arg1.uploader);
        };
        if (0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&v3) > 0) {
            0x2::balance::join<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v3));
        } else {
            0x2::coin::destroy_zero<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(v3);
        };
        let v11 = calculate_unlocked_amount(&arg1.vested_balance, 0x2::tx_context::epoch(arg3));
        if (v11 > 0) {
            arg1.vested_balance.claimed_amount = arg1.vested_balance.claimed_amount + v11;
            arg0.reward_pool_allocated = arg0.reward_pool_allocated - v11;
            arg1.unlocked_balance = arg1.unlocked_balance + v11;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.reward_pool, v11, arg3), arg1.uploader);
        };
        arg1.purchase_count = arg1.purchase_count + 1;
        arg0.total_purchases = arg0.total_purchases + 1;
        arg0.kiosk.total_datasets_purchased = arg0.kiosk.total_datasets_purchased + 1;
        let v12 = DatasetPurchasedViaKiosk{
            buyer        : 0x2::tx_context::sender(arg3),
            dataset_id   : 0x2::object::uid_to_inner(&arg1.id),
            sonar_amount : v1,
        };
        0x2::event::emit<DatasetPurchasedViaKiosk>(v12);
        let v13 = DatasetPurchased{
            submission_id       : 0x2::object::uid_to_inner(&arg1.id),
            buyer               : 0x2::tx_context::sender(arg3),
            price               : v1,
            burned              : v5,
            burn_rate_bps       : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::burn_bps(v4, &arg0.economic_config),
            liquidity_allocated : v6,
            liquidity_rate_bps  : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::liquidity_bps(v4, &arg0.economic_config),
            uploader_paid       : v7,
            uploader_rate_bps   : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::uploader_bps(v4, &arg0.economic_config),
            treasury_paid       : v8,
            circulating_supply  : v4,
            economic_tier       : 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::get_tier(v4, &arg0.economic_config),
            seal_policy_id      : arg1.seal_policy_id,
            purchase_timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DatasetPurchased>(v13);
    }

    public entry fun remove_vote(arg0: &mut AudioSubmission, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = VotingStatsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<VotingStatsKey>(&arg0.id, v1), 7002);
        let v2 = 0x2::dynamic_field::borrow_mut<VotingStatsKey, VotingStats>(&mut arg0.id, v1);
        assert!(0x2::vec_set::contains<address>(&v2.voters, &v0), 7002);
        0x2::vec_set::remove<address>(&mut v2.voters, &v0);
        if (arg1) {
            v2.upvotes = v2.upvotes - 1;
        } else {
            v2.downvotes = v2.downvotes - 1;
        };
        let v3 = if (v2.upvotes >= v2.downvotes) {
            v2.upvotes - v2.downvotes
        } else {
            0
        };
        let v4 = VoteRemoved{
            submission_id : 0x2::object::uid_to_inner(&arg0.id),
            voter         : v0,
            was_upvote    : arg1,
            new_upvotes   : v2.upvotes,
            new_downvotes : v2.downvotes,
            net_score     : v3,
        };
        0x2::event::emit<VoteRemoved>(v4);
    }

    public entry fun sell_sonar(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        update_kiosk_tier_and_price(arg0);
        let v0 = get_kiosk_price(arg0);
        assert!(v0 > 0, 4002);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 3003);
        let v2 = v1 * 1000000000 / v0;
        assert!(v2 > 0, 3003);
        assert!(0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.kiosk.sonar_reserve) >= v2, 4001);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.kiosk.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg2)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.kiosk.sonar_reserve, v2, arg2), 0x2::tx_context::sender(arg2));
        arg0.kiosk.total_sonar_sold = arg0.kiosk.total_sonar_sold + v2;
        let v3 = SonarSold{
            buyer        : 0x2::tx_context::sender(arg2),
            sui_amount   : v1,
            sonar_amount : v2,
        };
        0x2::event::emit<SonarSold>(v3);
    }

    public entry fun submit_audio(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg6), 5002);
        let v0 = get_circulating_supply(arg0);
        let v1 = 0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg1);
        assert!(v1 >= 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_burn_fee(v0), 2001);
        0x2::balance::decrease_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(arg1));
        arg0.total_burned = arg0.total_burned + v1;
        assert!(0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_reward(v0, 30), 2002);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = VestedBalance{
            total_amount           : 0,
            unlock_start_epoch     : 0,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v5 = AudioSubmission{
            id                 : v2,
            uploader           : v3,
            walrus_blob_id     : arg2,
            seal_policy_id     : arg3,
            preview_blob_hash  : arg4,
            duration_seconds   : arg5,
            quality_score      : 0,
            status             : 0,
            vested_balance     : v4,
            unlocked_balance   : 0,
            dataset_price      : 0,
            listed_for_sale    : false,
            purchase_count     : 0,
            submitted_at_epoch : 0x2::tx_context::epoch(arg6),
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        let v6 = SubmissionCreated{
            submission_id      : 0x2::object::uid_to_inner(&v2),
            uploader           : v3,
            seal_policy_id     : v5.seal_policy_id,
            walrus_blob_id     : v5.walrus_blob_id,
            duration_seconds   : arg5,
            burn_fee_paid      : v1,
            submitted_at_epoch : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<SubmissionCreated>(v6);
        0x2::transfer::transfer<AudioSubmission>(v5, v3);
    }

    public entry fun submit_audio_dataset(arg0: &mut QualityMarketplace, arg1: 0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_circuit_breaker_active(&arg0.circuit_breaker, arg7), 5002);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 > 0, 2006);
        assert!(v0 <= 100, 2006);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == v0, 2006);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v0, 2006);
        assert!(0x1::vector::length<u64>(&arg5) == v0, 2006);
        assert!(arg6 <= 5000, 2006);
        let v1 = get_circulating_supply(arg0);
        let v2 = 0x2::coin::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg1);
        assert!(v2 >= 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_burn_fee(v1), 2001);
        0x2::balance::decrease_supply<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg0.treasury_cap), 0x2::coin::into_balance<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(arg1));
        arg0.total_burned = arg0.total_burned + v2;
        assert!(0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg0.reward_pool) >= 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::calculate_reward(v1, 30), 2002);
        let v3 = 0x1::vector::empty<AudioFileEntry>();
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = AudioFileEntry{
                blob_id         : *0x1::vector::borrow<0x1::string::String>(&arg2, v5),
                preview_blob_id : *0x1::vector::borrow<0x1::string::String>(&arg3, v5),
                seal_policy_id  : *0x1::vector::borrow<0x1::string::String>(&arg4, v5),
                duration        : *0x1::vector::borrow<u64>(&arg5, v5),
            };
            v4 = v4 + *0x1::vector::borrow<u64>(&arg5, v5);
            0x1::vector::push_back<AudioFileEntry>(&mut v3, v6);
            v5 = v5 + 1;
        };
        let v7 = 0x2::object::new(arg7);
        let v8 = 0x2::tx_context::sender(arg7);
        let v9 = VestedBalance{
            total_amount           : 0,
            unlock_start_epoch     : 0,
            unlock_duration_epochs : 90,
            claimed_amount         : 0,
        };
        let v10 = DatasetSubmission{
            id                  : v7,
            uploader            : v8,
            files               : v3,
            total_duration      : v4,
            file_count          : v0,
            bundle_discount_bps : arg6,
            quality_score       : 0,
            status              : 0,
            vested_balance      : v9,
            unlocked_balance    : 0,
            dataset_price       : 0,
            listed_for_sale     : false,
            purchase_count      : 0,
            submitted_at_epoch  : 0x2::tx_context::epoch(arg7),
        };
        arg0.total_submissions = arg0.total_submissions + 1;
        let v11 = DatasetSubmissionCreated{
            submission_id       : 0x2::object::uid_to_inner(&v7),
            uploader            : v8,
            file_count          : v0,
            total_duration      : v4,
            bundle_discount_bps : arg6,
            burn_fee_paid       : v2,
            submitted_at_epoch  : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<DatasetSubmissionCreated>(v11);
        0x2::transfer::transfer<DatasetSubmission>(v10, v8);
    }

    public entry fun unlist_from_sale(arg0: &mut AudioSubmission, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.uploader, 5001);
        arg0.listed_for_sale = false;
    }

    public fun update_economic_config(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::EconomicConfig) {
        assert!(0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::validate_config(&arg2), 5001);
        arg1.economic_config = arg2;
    }

    public entry fun update_economic_config_entry(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        update_economic_config(arg0, arg1, 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::create_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13));
    }

    public entry fun update_kiosk_price_override(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(*0x1::option::borrow<u64>(&arg2) > 0, 4002);
        };
        arg1.kiosk.price_override = arg2;
        update_kiosk_tier_and_price(arg1);
        let v0 = KioskPriceUpdated{
            base_price     : arg1.kiosk.base_sonar_price,
            override_price : arg1.kiosk.price_override,
            tier           : arg1.kiosk.current_tier,
        };
        0x2::event::emit<KioskPriceUpdated>(v0);
    }

    public entry fun update_kiosk_sui_cut(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 20, 4003);
        arg1.kiosk.sui_cut_percentage = arg2;
        let v0 = KioskSuiCutUpdated{percentage: arg2};
        0x2::event::emit<KioskSuiCutUpdated>(v0);
    }

    fun update_kiosk_tier_and_price(arg0: &mut QualityMarketplace) {
        let v0 = 0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::economics::get_tier(get_circulating_supply(arg0), &arg0.economic_config);
        if (0x1::option::is_none<u64>(&arg0.kiosk.price_override)) {
            if (v0 == 1) {
                arg0.kiosk.base_sonar_price = 1000000000;
            } else if (v0 == 2) {
                arg0.kiosk.base_sonar_price = 800000000;
            } else if (v0 == 3) {
                arg0.kiosk.base_sonar_price = 600000000;
            } else if (v0 == 4) {
                arg0.kiosk.base_sonar_price = 400000000;
            } else {
                arg0.kiosk.base_sonar_price = 1000000000;
            };
        };
        arg0.kiosk.current_tier = v0;
    }

    public entry fun update_price(arg0: &mut AudioSubmission, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.uploader, 5001);
        arg0.dataset_price = arg1;
    }

    public entry fun vote_on_submission(arg0: &mut AudioSubmission, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = arg0.uploader;
        assert!(v0 != v2, 7003);
        let v3 = get_or_create_voting_stats(arg0);
        if (0x2::vec_set::contains<address>(&v3.voters, &v0)) {
            0x2::vec_set::remove<address>(&mut v3.voters, &v0);
        } else {
            0x2::vec_set::insert<address>(&mut v3.voters, v0);
        };
        if (arg1) {
            v3.upvotes = v3.upvotes + 1;
        } else {
            v3.downvotes = v3.downvotes + 1;
        };
        let v4 = if (v3.upvotes >= v3.downvotes) {
            v3.upvotes - v3.downvotes
        } else {
            0
        };
        let v5 = VoteCast{
            submission_id : v1,
            voter         : v0,
            is_upvote     : arg1,
            new_upvotes   : v3.upvotes,
            new_downvotes : v3.downvotes,
            net_score     : v4,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<VoteCast>(v5);
        if (v4 >= 10 && !arg0.listed_for_sale) {
            arg0.listed_for_sale = true;
            let v6 = SubmissionGraduated{
                submission_id : v1,
                uploader      : v2,
                net_score     : v4,
                timestamp     : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<SubmissionGraduated>(v6);
        };
    }

    public entry fun withdraw_kiosk_sui(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.kiosk.sui_reserve) >= arg2, 4001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.kiosk.sui_reserve, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_liquidity_vault(arg0: &AdminCap, arg1: &mut QualityMarketplace, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = &mut arg1.withdrawal_limits;
        if (v1.last_withdrawal_epoch > 0) {
            assert!(v0 >= v1.last_withdrawal_epoch + v1.min_epochs_between, 5004);
        };
        if (v0 > v1.last_withdrawal_epoch) {
            v1.total_withdrawn_this_epoch = 0;
        };
        assert!(v1.total_withdrawn_this_epoch + arg2 <= 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg1.liquidity_vault) * v1.max_per_epoch_bps / 10000, 5005);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>>(0x2::coin::take<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&mut arg1.liquidity_vault, arg2, arg5), arg3);
        v1.total_withdrawn_this_epoch = v1.total_withdrawn_this_epoch + arg2;
        v1.last_withdrawal_epoch = v0;
        let v2 = LiquidityVaultWithdrawal{
            amount            : arg2,
            recipient         : arg3,
            reason            : arg4,
            remaining_balance : 0x2::balance::value<0x63d29adf5adde737a28f9a541f62070c251e1cc0bd5c76d96d4e5800cfd77950::sonar_token::SONAR_TOKEN>(&arg1.liquidity_vault),
            withdrawn_by      : 0x2::tx_context::sender(arg5),
            timestamp_epoch   : v0,
        };
        0x2::event::emit<LiquidityVaultWithdrawal>(v2);
    }

    // decompiled from Move bytecode v6
}

