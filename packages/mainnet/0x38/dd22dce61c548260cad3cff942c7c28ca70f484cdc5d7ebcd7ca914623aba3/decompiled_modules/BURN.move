module 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::BURN {
    struct BurnPool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        reward_balance: 0x2::balance::Balance<T0>,
        reward_per_burn: u64,
        total_burns: u64,
        total_rewards_distributed: u64,
        is_active: bool,
    }

    struct PoolCreated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        initial_balance: u64,
        reward_per_burn: u64,
    }

    struct NFTBurned has copy, drop {
        burner: address,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
    }

    struct RewardClaimed<phantom T0> has copy, drop {
        burner: address,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct BalanceAdded<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct BalanceRemoved<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        remaining_balance: u64,
    }

    struct PoolDestroyed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        remaining_balance: u64,
    }

    struct PoolStatusChanged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        is_active: bool,
    }

    struct UserClaimInfo has copy, drop, store {
        last_claim: u64,
    }

    struct TimedBurnPool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        reward_balance: 0x2::balance::Balance<T0>,
        reward_per_burn: u64,
        total_burns: u64,
        total_rewards_distributed: u64,
        is_active: bool,
        claim_delay: u64,
    }

    struct TimedPoolCreated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        initial_balance: u64,
        reward_per_burn: u64,
        claim_delay: u64,
    }

    public entry fun add_rewards<T0>(arg0: &mut BurnPool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 2);
        assert!(arg2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        let v0 = BalanceAdded<T0>{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount      : arg2,
            new_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<BalanceAdded<T0>>(v0);
    }

    public entry fun add_timed_pool_rewards<T0>(arg0: &mut TimedBurnPool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 2);
        assert!(arg2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        let v0 = BalanceAdded<T0>{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount      : arg2,
            new_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<BalanceAdded<T0>>(v0);
    }

    public entry fun burn_and_claim<T0>(arg0: &mut BurnPool<T0>, arg1: 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::NFT, arg2: &mut 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::CollectionCap, arg3: 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg0.reward_per_burn, 5);
        arg0.total_burns = safe_add(arg0.total_burns, 1);
        arg0.total_rewards_distributed = safe_add(arg0.total_rewards_distributed, arg0.reward_per_burn);
        let v0 = NFTBurned{
            burner        : 0x2::tx_context::sender(arg4),
            nft_id        : 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::get_nft_id(&arg1),
            collection_id : 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::get_nft_collection_id(&arg1),
        };
        0x2::event::emit<NFTBurned>(v0);
        let v1 = RewardClaimed<T0>{
            burner  : 0x2::tx_context::sender(arg4),
            amount  : arg0.reward_per_burn,
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<RewardClaimed<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg0.reward_per_burn), arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x1::vector::empty<0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance>();
        0x1::vector::push_back<0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance>(&mut v2, arg3);
        0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::burn_art20(arg1, arg2, v2, arg4);
    }

    public entry fun create_burn_pool<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        assert!(arg1 > 0, 2);
        assert!(arg2 > 0, 3);
        let v0 = BurnPool<T0>{
            id                        : 0x2::object::new(arg3),
            creator                   : 0x2::tx_context::sender(arg3),
            reward_balance            : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg3)),
            reward_per_burn           : arg2,
            total_burns               : 0,
            total_rewards_distributed : 0,
            is_active                 : true,
        };
        let v1 = PoolCreated<T0>{
            pool_id         : 0x2::object::uid_to_inner(&v0.id),
            creator         : 0x2::tx_context::sender(arg3),
            initial_balance : arg1,
            reward_per_burn : arg2,
        };
        0x2::event::emit<PoolCreated<T0>>(v1);
        0x2::transfer::share_object<BurnPool<T0>>(v0);
    }

    public entry fun create_timed_burn_pool<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        assert!(arg1 > 0, 2);
        assert!(arg2 > 0, 3);
        assert!(arg3 > 0, 10);
        let v0 = TimedBurnPool<T0>{
            id                        : 0x2::object::new(arg4),
            creator                   : 0x2::tx_context::sender(arg4),
            reward_balance            : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg4)),
            reward_per_burn           : arg2,
            total_burns               : 0,
            total_rewards_distributed : 0,
            is_active                 : true,
            claim_delay               : arg3,
        };
        let v1 = TimedPoolCreated<T0>{
            pool_id         : 0x2::object::uid_to_inner(&v0.id),
            creator         : 0x2::tx_context::sender(arg4),
            initial_balance : arg1,
            reward_per_burn : arg2,
            claim_delay     : arg3,
        };
        0x2::event::emit<TimedPoolCreated<T0>>(v1);
        0x2::transfer::share_object<TimedBurnPool<T0>>(v0);
    }

    public entry fun deactivate_pool<T0>(arg0: &mut BurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.is_active, 4);
        arg0.is_active = false;
        let v0 = PoolStatusChanged<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_active : false,
        };
        0x2::event::emit<PoolStatusChanged<T0>>(v0);
    }

    public entry fun deactivate_timed_pool<T0>(arg0: &mut TimedBurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.is_active, 4);
        arg0.is_active = false;
        let v0 = PoolStatusChanged<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_active : false,
        };
        0x2::event::emit<PoolStatusChanged<T0>>(v0);
    }

    public entry fun destroy_pool<T0>(arg0: BurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        let BurnPool {
            id                        : v0,
            creator                   : _,
            reward_balance            : v2,
            reward_per_burn           : _,
            total_burns               : _,
            total_rewards_distributed : _,
            is_active                 : _,
        } = arg0;
        let v7 = v2;
        let v8 = v0;
        let v9 = 0x2::balance::value<T0>(&v7);
        let v10 = PoolDestroyed<T0>{
            pool_id           : 0x2::object::uid_to_inner(&v8),
            remaining_balance : v9,
        };
        0x2::event::emit<PoolDestroyed<T0>>(v10);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        0x2::object::delete(v8);
    }

    public entry fun destroy_timed_pool<T0>(arg0: TimedBurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        let TimedBurnPool {
            id                        : v0,
            creator                   : _,
            reward_balance            : v2,
            reward_per_burn           : _,
            total_burns               : _,
            total_rewards_distributed : _,
            is_active                 : _,
            claim_delay               : _,
        } = arg0;
        let v8 = v2;
        let v9 = v0;
        let v10 = 0x2::balance::value<T0>(&v8);
        let v11 = PoolDestroyed<T0>{
            pool_id           : 0x2::object::uid_to_inner(&v9),
            remaining_balance : v10,
        };
        0x2::event::emit<PoolDestroyed<T0>>(v11);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
        0x2::object::delete(v9);
    }

    fun get_claim_field_name(arg0: address) : vector<u8> {
        let v0 = b"claim_";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        v0
    }

    public fun get_pool_balance<T0>(arg0: &BurnPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    public fun get_pool_info<T0>(arg0: &BurnPool<T0>) : (address, u64, u64, u64, u64, bool) {
        (arg0.creator, 0x2::balance::value<T0>(&arg0.reward_balance), arg0.reward_per_burn, arg0.total_burns, arg0.total_rewards_distributed, arg0.is_active)
    }

    public fun get_reward_per_burn<T0>(arg0: &BurnPool<T0>) : u64 {
        arg0.reward_per_burn
    }

    public fun get_time_to_next_claim<T0>(arg0: &TimedBurnPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = get_claim_field_name(arg1);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, UserClaimInfo>(&arg0.id, v0).last_claim + arg0.claim_delay;
        if (v1 >= v2) {
            0
        } else {
            v2 - v1
        }
    }

    public fun get_timed_pool_info<T0>(arg0: &TimedBurnPool<T0>) : (address, u64, u64, u64, u64, bool, u64) {
        (arg0.creator, 0x2::balance::value<T0>(&arg0.reward_balance), arg0.reward_per_burn, arg0.total_burns, arg0.total_rewards_distributed, arg0.is_active, arg0.claim_delay)
    }

    public fun is_pool_active<T0>(arg0: &BurnPool<T0>) : bool {
        arg0.is_active
    }

    public entry fun reactivate_pool<T0>(arg0: &mut BurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(!arg0.is_active, 7);
        arg0.is_active = true;
        let v0 = PoolStatusChanged<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_active : true,
        };
        0x2::event::emit<PoolStatusChanged<T0>>(v0);
    }

    public entry fun reactivate_timed_pool<T0>(arg0: &mut TimedBurnPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(!arg0.is_active, 7);
        arg0.is_active = true;
        let v0 = PoolStatusChanged<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_active : true,
        };
        0x2::event::emit<PoolStatusChanged<T0>>(v0);
    }

    public entry fun remove_rewards<T0>(arg0: &mut BurnPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg1, 2);
        let v0 = BalanceRemoved<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<BalanceRemoved<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg1), arg2), arg0.creator);
    }

    public entry fun remove_timed_pool_rewards<T0>(arg0: &mut TimedBurnPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg1, 2);
        let v0 = BalanceRemoved<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<BalanceRemoved<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg1), arg2), arg0.creator);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 6);
        arg0 + arg1
    }

    public entry fun timed_burn_and_claim<T0>(arg0: &mut TimedBurnPool<T0>, arg1: 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::NFT, arg2: &mut 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::CollectionCap, arg3: 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = get_claim_field_name(v0);
        let v3 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::dynamic_field::borrow<vector<u8>, UserClaimInfo>(&arg0.id, v2).last_claim
        } else {
            0
        };
        assert!(v1 >= v3 + arg0.claim_delay, 11);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg0.reward_per_burn, 5);
        arg0.total_burns = safe_add(arg0.total_burns, 1);
        arg0.total_rewards_distributed = safe_add(arg0.total_rewards_distributed, arg0.reward_per_burn);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::dynamic_field::remove<vector<u8>, UserClaimInfo>(&mut arg0.id, v2);
        };
        let v4 = UserClaimInfo{last_claim: v1};
        0x2::dynamic_field::add<vector<u8>, UserClaimInfo>(&mut arg0.id, v2, v4);
        let v5 = NFTBurned{
            burner        : v0,
            nft_id        : 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::get_nft_id(&arg1),
            collection_id : 0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::get_nft_collection_id(&arg1),
        };
        0x2::event::emit<NFTBurned>(v5);
        let v6 = RewardClaimed<T0>{
            burner  : v0,
            amount  : arg0.reward_per_burn,
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<RewardClaimed<T0>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg0.reward_per_burn), arg4), v0);
        let v7 = 0x1::vector::empty<0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance>();
        0x1::vector::push_back<0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::UserBalance>(&mut v7, arg3);
        0x38dd22dce61c548260cad3cff942c7c28ca70f484cdc5d7ebcd7ca914623aba3::ART20::burn_art20(arg1, arg2, v7, arg4);
    }

    // decompiled from Move bytecode v6
}

