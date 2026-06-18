module 0x2e0029466734d5baca6ee6dae6e9ae08b0c44c4ec3d0d0f93b0ccccf2ada290e::rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        admin: address,
        required_nftree_type: vector<u8>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        current_round: u64,
        per_nftree_mist: u64,
        total_funded: u64,
        total_claimed: u64,
        total_claims: u64,
        claimed: 0x2::table::Table<ClaimKey, bool>,
    }

    struct CommunityTokenRewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        reward_coin_type: vector<u8>,
        required_nftree_type: vector<u8>,
        vault: 0x2::balance::Balance<T0>,
        current_round: u64,
        per_nftree_amount: u64,
        total_funded: u64,
        total_claimed: u64,
        total_claims: u64,
        claimed: 0x2::table::Table<ClaimKey, bool>,
    }

    struct EligibilityRegistry has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        admin: address,
        eligible_owners: 0x2::table::Table<ClaimKey, address>,
        snapshot_counts: 0x2::table::Table<u64, u64>,
    }

    struct ClaimKey has copy, drop, store {
        round: u64,
        nftree_id: 0x2::object::ID,
    }

    struct RewardPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        required_nftree_type: vector<u8>,
    }

    struct CommunityTokenRewardPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        reward_coin_type: vector<u8>,
        required_nftree_type: vector<u8>,
    }

    struct EligibilityRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        admin: address,
    }

    struct RewardPoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        vault_balance: u64,
        total_funded: u64,
    }

    struct CommunityTokenRewardPoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        funder: address,
        reward_coin_type: vector<u8>,
        amount: u64,
        vault_balance: u64,
        total_funded: u64,
    }

    struct RewardRoundOpened has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        round: u64,
        per_nftree_mist: u64,
        vault_balance: u64,
    }

    struct CommunityTokenRewardRoundOpened has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        reward_coin_type: vector<u8>,
        round: u64,
        per_nftree_amount: u64,
        vault_balance: u64,
    }

    struct RewardRoundEligibilityAdded has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        admin: address,
        round: u64,
        added_count: u64,
        snapshot_count: u64,
    }

    struct CommunityTokenRewardRoundEligibilityAdded has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        admin: address,
        reward_coin_type: vector<u8>,
        round: u64,
        added_count: u64,
        snapshot_count: u64,
    }

    struct NFTreeRewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        round: u64,
        claimant: address,
        nftree_id: 0x2::object::ID,
        amount: u64,
        vault_balance: u64,
        total_claims: u64,
    }

    struct NFTreeCommunityTokenRewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        round: u64,
        claimant: address,
        nftree_id: 0x2::object::ID,
        reward_coin_type: vector<u8>,
        amount: u64,
        vault_balance: u64,
        total_claims: u64,
    }

    struct RewardPoolWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        amount: u64,
        vault_balance: u64,
    }

    struct CommunityTokenRewardPoolWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        reward_coin_type: vector<u8>,
        amount: u64,
        vault_balance: u64,
    }

    entry fun add_community_token_round_eligibility<T0>(arg0: &AdminCap, arg1: &CommunityTokenRewardPool<T0>, arg2: &mut EligibilityRegistry, arg3: vector<address>, arg4: vector<address>, arg5: &0x2::tx_context::TxContext) {
        assert_community_token_admin<T0>(arg1, arg5);
        assert_registry_for_community_token_pool<T0>(arg1, arg2);
        assert!(arg1.current_round > 0, 5);
        assert!(arg1.per_nftree_amount > 0, 5);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<address>(&arg4), 9);
        assert!(v0 > 0, 4);
        ensure_snapshot_count(arg2, arg1.current_round);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = claim_key(arg1.current_round, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg3, v1)));
            assert!(!0x2::table::contains<ClaimKey, address>(&arg2.eligible_owners, v2), 12);
            0x2::table::add<ClaimKey, address>(&mut arg2.eligible_owners, v2, *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
        let v3 = 0x2::table::borrow_mut<u64, u64>(&mut arg2.snapshot_counts, arg1.current_round);
        *v3 = *v3 + v0;
        let v4 = CommunityTokenRewardRoundEligibilityAdded{
            registry_id      : 0x2::object::id<EligibilityRegistry>(arg2),
            pool_id          : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg1),
            admin            : 0x2::tx_context::sender(arg5),
            reward_coin_type : arg1.reward_coin_type,
            round            : arg1.current_round,
            added_count      : v0,
            snapshot_count   : *v3,
        };
        0x2::event::emit<CommunityTokenRewardRoundEligibilityAdded>(v4);
    }

    entry fun add_round_eligibility(arg0: &AdminCap, arg1: &RewardPool, arg2: &mut EligibilityRegistry, arg3: vector<address>, arg4: vector<address>, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg5);
        assert_registry_for_pool(arg1, arg2);
        assert!(arg1.current_round > 0, 5);
        assert!(arg1.per_nftree_mist > 0, 5);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<address>(&arg4), 9);
        assert!(v0 > 0, 4);
        ensure_snapshot_count(arg2, arg1.current_round);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = claim_key(arg1.current_round, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg3, v1)));
            assert!(!0x2::table::contains<ClaimKey, address>(&arg2.eligible_owners, v2), 12);
            0x2::table::add<ClaimKey, address>(&mut arg2.eligible_owners, v2, *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
        let v3 = 0x2::table::borrow_mut<u64, u64>(&mut arg2.snapshot_counts, arg1.current_round);
        *v3 = *v3 + v0;
        let v4 = RewardRoundEligibilityAdded{
            registry_id    : 0x2::object::id<EligibilityRegistry>(arg2),
            pool_id        : 0x2::object::id<RewardPool>(arg1),
            admin          : 0x2::tx_context::sender(arg5),
            round          : arg1.current_round,
            added_count    : v0,
            snapshot_count : *v3,
        };
        0x2::event::emit<RewardRoundEligibilityAdded>(v4);
    }

    public fun admin(arg0: &RewardPool) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &RewardPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun assert_community_token_admin<T0>(arg0: &CommunityTokenRewardPool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun assert_nftree_type_limited(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 160, 4);
    }

    fun assert_registry_for_community_token_pool<T0>(arg0: &CommunityTokenRewardPool<T0>, arg1: &EligibilityRegistry) {
        assert!(arg1.pool_id == 0x2::object::id<CommunityTokenRewardPool<T0>>(arg0), 13);
    }

    fun assert_registry_for_pool(arg0: &RewardPool, arg1: &EligibilityRegistry) {
        assert!(arg1.pool_id == 0x2::object::id<RewardPool>(arg0), 13);
    }

    entry fun claim<T0: key>(arg0: &mut RewardPool, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) {
        abort 11
    }

    entry fun claim_community_token_snapshot<T0>(arg0: &mut CommunityTokenRewardPool<T0>, arg1: &EligibilityRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_round > 0, 5);
        assert!(arg0.per_nftree_amount > 0, 5);
        assert_registry_for_community_token_pool<T0>(arg0, arg1);
        assert!(arg0.per_nftree_amount <= 0x2::balance::value<T0>(&arg0.vault), 7);
        let v0 = 0x2::object::id_from_address(arg2);
        let v1 = claim_key(arg0.current_round, v0);
        assert!(0x2::table::contains<ClaimKey, address>(&arg1.eligible_owners, v1), 10);
        assert!(*0x2::table::borrow<ClaimKey, address>(&arg1.eligible_owners, v1) == 0x2::tx_context::sender(arg3), 10);
        assert!(!0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v1), 6);
        0x2::table::add<ClaimKey, bool>(&mut arg0.claimed, v1, true);
        arg0.total_claimed = arg0.total_claimed + arg0.per_nftree_amount;
        arg0.total_claims = arg0.total_claims + 1;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = NFTreeCommunityTokenRewardClaimed{
            pool_id          : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg0),
            round            : arg0.current_round,
            claimant         : v2,
            nftree_id        : v0,
            reward_coin_type : arg0.reward_coin_type,
            amount           : arg0.per_nftree_amount,
            vault_balance    : 0x2::balance::value<T0>(&arg0.vault),
            total_claims     : arg0.total_claims,
        };
        0x2::event::emit<NFTreeCommunityTokenRewardClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg0.per_nftree_amount), arg3), v2);
    }

    fun claim_key(arg0: u64, arg1: 0x2::object::ID) : ClaimKey {
        ClaimKey{
            round     : arg0,
            nftree_id : arg1,
        }
    }

    entry fun claim_snapshot(arg0: &mut RewardPool, arg1: &EligibilityRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_round > 0, 5);
        assert!(arg0.per_nftree_mist > 0, 5);
        assert_registry_for_pool(arg0, arg1);
        assert!(arg0.per_nftree_mist <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 7);
        let v0 = 0x2::object::id_from_address(arg2);
        let v1 = claim_key(arg0.current_round, v0);
        assert!(0x2::table::contains<ClaimKey, address>(&arg1.eligible_owners, v1), 10);
        assert!(*0x2::table::borrow<ClaimKey, address>(&arg1.eligible_owners, v1) == 0x2::tx_context::sender(arg3), 10);
        assert!(!0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v1), 6);
        0x2::table::add<ClaimKey, bool>(&mut arg0.claimed, v1, true);
        arg0.total_claimed = arg0.total_claimed + arg0.per_nftree_mist;
        arg0.total_claims = arg0.total_claims + 1;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = NFTreeRewardClaimed{
            pool_id       : 0x2::object::id<RewardPool>(arg0),
            round         : arg0.current_round,
            claimant      : v2,
            nftree_id     : v0,
            amount        : arg0.per_nftree_mist,
            vault_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.vault),
            total_claims  : arg0.total_claims,
        };
        0x2::event::emit<NFTreeRewardClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.per_nftree_mist), arg3), v2);
    }

    public fun community_token_admin<T0>(arg0: &CommunityTokenRewardPool<T0>) : address {
        arg0.admin
    }

    public fun community_token_current_round<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        arg0.current_round
    }

    public fun community_token_has_claimed<T0>(arg0: &CommunityTokenRewardPool<T0>, arg1: u64, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<ClaimKey, bool>(&arg0.claimed, claim_key(arg1, arg2))
    }

    public fun community_token_per_nftree_amount<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        arg0.per_nftree_amount
    }

    public fun community_token_pool_id<T0>(arg0: &CommunityTokenRewardPool<T0>) : 0x2::object::ID {
        0x2::object::id<CommunityTokenRewardPool<T0>>(arg0)
    }

    public fun community_token_required_nftree_type<T0>(arg0: &CommunityTokenRewardPool<T0>) : vector<u8> {
        arg0.required_nftree_type
    }

    public fun community_token_reward_coin_type<T0>(arg0: &CommunityTokenRewardPool<T0>) : vector<u8> {
        arg0.reward_coin_type
    }

    public fun community_token_total_claimed<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        arg0.total_claimed
    }

    public fun community_token_total_claims<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        arg0.total_claims
    }

    public fun community_token_total_funded<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        arg0.total_funded
    }

    public fun community_token_vault_balance<T0>(arg0: &CommunityTokenRewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    entry fun create_community_token_eligibility_registry<T0>(arg0: &AdminCap, arg1: &CommunityTokenRewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_community_token_admin<T0>(arg1, arg2);
        let v0 = EligibilityRegistry{
            id              : 0x2::object::new(arg2),
            pool_id         : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg1),
            admin           : 0x2::tx_context::sender(arg2),
            eligible_owners : 0x2::table::new<ClaimKey, address>(arg2),
            snapshot_counts : 0x2::table::new<u64, u64>(arg2),
        };
        let v1 = EligibilityRegistryCreated{
            registry_id : 0x2::object::id<EligibilityRegistry>(&v0),
            pool_id     : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg1),
            admin       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EligibilityRegistryCreated>(v1);
        0x2::transfer::share_object<EligibilityRegistry>(v0);
    }

    entry fun create_community_token_pool<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_nftree_type_limited(&arg1);
        create_community_token_pool_internal<T0>(arg1, arg2);
    }

    fun create_community_token_pool_internal<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_nftree_type_limited(&arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CommunityTokenRewardPool<T0>{
            id                   : 0x2::object::new(arg1),
            admin                : v0,
            reward_coin_type     : reward_coin_type<T0>(),
            required_nftree_type : arg0,
            vault                : 0x2::balance::zero<T0>(),
            current_round        : 0,
            per_nftree_amount    : 0,
            total_funded         : 0,
            total_claimed        : 0,
            total_claims         : 0,
            claimed              : 0x2::table::new<ClaimKey, bool>(arg1),
        };
        let v2 = CommunityTokenRewardPoolCreated{
            pool_id              : 0x2::object::id<CommunityTokenRewardPool<T0>>(&v1),
            admin                : v0,
            reward_coin_type     : v1.reward_coin_type,
            required_nftree_type : v1.required_nftree_type,
        };
        0x2::event::emit<CommunityTokenRewardPoolCreated>(v2);
        0x2::transfer::share_object<CommunityTokenRewardPool<T0>>(v1);
    }

    entry fun create_default_community_token_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_community_token_pool_internal<T0>(b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT", arg1);
    }

    entry fun create_default_pool(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_pool_internal(b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT", arg1);
    }

    entry fun create_eligibility_registry(arg0: &AdminCap, arg1: &RewardPool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg2);
        let v0 = EligibilityRegistry{
            id              : 0x2::object::new(arg2),
            pool_id         : 0x2::object::id<RewardPool>(arg1),
            admin           : 0x2::tx_context::sender(arg2),
            eligible_owners : 0x2::table::new<ClaimKey, address>(arg2),
            snapshot_counts : 0x2::table::new<u64, u64>(arg2),
        };
        let v1 = EligibilityRegistryCreated{
            registry_id : 0x2::object::id<EligibilityRegistry>(&v0),
            pool_id     : 0x2::object::id<RewardPool>(arg1),
            admin       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EligibilityRegistryCreated>(v1);
        0x2::transfer::share_object<EligibilityRegistry>(v0);
    }

    entry fun create_pool(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_nftree_type_limited(&arg1);
        create_pool_internal(arg1, arg2);
    }

    fun create_pool_internal(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_nftree_type_limited(&arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = RewardPool{
            id                   : 0x2::object::new(arg1),
            admin                : v0,
            required_nftree_type : arg0,
            vault                : 0x2::balance::zero<0x2::sui::SUI>(),
            current_round        : 0,
            per_nftree_mist      : 0,
            total_funded         : 0,
            total_claimed        : 0,
            total_claims         : 0,
            claimed              : 0x2::table::new<ClaimKey, bool>(arg1),
        };
        let v2 = RewardPoolCreated{
            pool_id              : 0x2::object::id<RewardPool>(&v1),
            admin                : v0,
            required_nftree_type : v1.required_nftree_type,
        };
        0x2::event::emit<RewardPoolCreated>(v2);
        0x2::transfer::share_object<RewardPool>(v1);
    }

    public fun current_round(arg0: &RewardPool) : u64 {
        arg0.current_round
    }

    public fun default_nftree_type() : vector<u8> {
        b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT"
    }

    public fun eligible_owner(arg0: &EligibilityRegistry, arg1: u64, arg2: 0x2::object::ID) : address {
        *0x2::table::borrow<ClaimKey, address>(&arg0.eligible_owners, claim_key(arg1, arg2))
    }

    fun ensure_snapshot_count(arg0: &mut EligibilityRegistry, arg1: u64) {
        if (!0x2::table::contains<u64, u64>(&arg0.snapshot_counts, arg1)) {
            0x2::table::add<u64, u64>(&mut arg0.snapshot_counts, arg1, 0);
        };
    }

    entry fun fund_community_token_pool<T0>(arg0: &mut CommunityTokenRewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_funded = arg0.total_funded + v0;
        let v1 = CommunityTokenRewardPoolFunded{
            pool_id          : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg0),
            funder           : 0x2::tx_context::sender(arg2),
            reward_coin_type : arg0.reward_coin_type,
            amount           : v0,
            vault_balance    : 0x2::balance::value<T0>(&arg0.vault),
            total_funded     : arg0.total_funded,
        };
        0x2::event::emit<CommunityTokenRewardPoolFunded>(v1);
    }

    entry fun fund_pool(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_funded = arg0.total_funded + v0;
        let v1 = RewardPoolFunded{
            pool_id       : 0x2::object::id<RewardPool>(arg0),
            funder        : 0x2::tx_context::sender(arg2),
            amount        : v0,
            vault_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.vault),
            total_funded  : arg0.total_funded,
        };
        0x2::event::emit<RewardPoolFunded>(v1);
    }

    public fun has_claimed(arg0: &RewardPool, arg1: u64, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<ClaimKey, bool>(&arg0.claimed, claim_key(arg1, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_eligible(arg0: &EligibilityRegistry, arg1: u64, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<ClaimKey, address>(&arg0.eligible_owners, claim_key(arg1, arg2))
    }

    entry fun open_community_token_round<T0>(arg0: &AdminCap, arg1: &mut CommunityTokenRewardPool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_community_token_admin<T0>(arg1, arg3);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.vault), 7);
        arg1.current_round = arg1.current_round + 1;
        arg1.per_nftree_amount = arg2;
        let v0 = CommunityTokenRewardRoundOpened{
            pool_id           : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg1),
            admin             : 0x2::tx_context::sender(arg3),
            reward_coin_type  : arg1.reward_coin_type,
            round             : arg1.current_round,
            per_nftree_amount : arg2,
            vault_balance     : 0x2::balance::value<T0>(&arg1.vault),
        };
        0x2::event::emit<CommunityTokenRewardRoundOpened>(v0);
    }

    entry fun open_round(arg0: &AdminCap, arg1: &mut RewardPool, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.vault), 7);
        arg1.current_round = arg1.current_round + 1;
        arg1.per_nftree_mist = arg2;
        let v0 = RewardRoundOpened{
            pool_id         : 0x2::object::id<RewardPool>(arg1),
            admin           : 0x2::tx_context::sender(arg3),
            round           : arg1.current_round,
            per_nftree_mist : arg2,
            vault_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.vault),
        };
        0x2::event::emit<RewardRoundOpened>(v0);
    }

    public fun per_nftree_mist(arg0: &RewardPool) : u64 {
        arg0.per_nftree_mist
    }

    public fun pool_id(arg0: &RewardPool) : 0x2::object::ID {
        0x2::object::id<RewardPool>(arg0)
    }

    public fun registry_admin(arg0: &EligibilityRegistry) : address {
        arg0.admin
    }

    public fun registry_pool_id(arg0: &EligibilityRegistry) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun required_nftree_type(arg0: &RewardPool) : vector<u8> {
        arg0.required_nftree_type
    }

    fun reward_coin_type<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))
    }

    public fun snapshot_count(arg0: &EligibilityRegistry, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.snapshot_counts, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.snapshot_counts, arg1)
        } else {
            0
        }
    }

    public fun total_claimed(arg0: &RewardPool) : u64 {
        arg0.total_claimed
    }

    public fun total_claims(arg0: &RewardPool) : u64 {
        arg0.total_claims
    }

    public fun total_funded(arg0: &RewardPool) : u64 {
        arg0.total_funded
    }

    public fun vault_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    entry fun withdraw_community_token_unallocated<T0>(arg0: &AdminCap, arg1: &mut CommunityTokenRewardPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_community_token_admin<T0>(arg1, arg4);
        assert!(arg3 != @0x0, 8);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg1.vault), 8);
        let v0 = CommunityTokenRewardPoolWithdrawn{
            pool_id          : 0x2::object::id<CommunityTokenRewardPool<T0>>(arg1),
            admin            : 0x2::tx_context::sender(arg4),
            recipient        : arg3,
            reward_coin_type : arg1.reward_coin_type,
            amount           : arg2,
            vault_balance    : 0x2::balance::value<T0>(&arg1.vault),
        };
        0x2::event::emit<CommunityTokenRewardPoolWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, arg2), arg4), arg3);
    }

    entry fun withdraw_unallocated(arg0: &AdminCap, arg1: &mut RewardPool, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        assert!(arg3 != @0x0, 8);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.vault), 8);
        let v0 = RewardPoolWithdrawn{
            pool_id       : 0x2::object::id<RewardPool>(arg1),
            admin         : 0x2::tx_context::sender(arg4),
            recipient     : arg3,
            amount        : arg2,
            vault_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.vault),
        };
        0x2::event::emit<RewardPoolWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

