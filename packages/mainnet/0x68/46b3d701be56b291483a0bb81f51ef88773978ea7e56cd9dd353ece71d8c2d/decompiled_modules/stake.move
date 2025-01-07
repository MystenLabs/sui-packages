module 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    struct Admincap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        stopAll: bool,
        lock_period: u64,
        min_stake: u128,
        total_reward_claimed: u128,
        reward_coins: 0x2::coin::Coin<T1>,
        stake_coins: 0x2::coin::Coin<T0>,
        stakes: vector<address>,
    }

    struct StakeItem has store, key {
        id: 0x2::object::UID,
        pool: address,
        owner: address,
        apy: u128,
        staked_amount: u128,
        unstaked: bool,
        reward_remaining: u128,
        lastest_updated_time: u64,
        time_stake: u64,
        unlock_times: u64,
    }

    struct RegistryStakePool has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, PoolInfo>,
        user_items: 0x2::table::Table<address, vector<address>>,
    }

    struct PoolInfo has copy, drop, store {
        id: address,
        rTypeCoin: vector<u8>,
        sTypeCoin: vector<u8>,
    }

    struct UserStakePoolInfo has store, key {
        id: 0x2::object::UID,
        users_staked: 0x2::table::Table<address, PoolStakedInfo>,
    }

    struct PoolStakedInfo has store {
        pools_staked: 0x2::table::Table<address, u128>,
    }

    struct RequestId has store, key {
        id: 0x2::object::UID,
        request: vector<vector<u8>>,
    }

    struct VaultDAO has store, key {
        id: 0x2::object::UID,
        dao: 0x2::table::Table<address, VoteInfo>,
        quorum: u8,
        num_confirmations_required: u8,
        treasury: address,
    }

    struct VoteInfo has copy, drop, store {
        vote: bool,
    }

    struct RequestFundInfo has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        request_creator: address,
        total_amount: u128,
        agree: u8,
        executed: bool,
        time_confirm: u64,
        voted: vector<address>,
    }

    struct RequestChangeTreasuryInfo has store, key {
        id: 0x2::object::UID,
        request_creator: address,
        agree: u8,
        executed: bool,
        time_confirm: u64,
        new_treasury_address: address,
        voted: vector<address>,
    }

    struct RequestChangeVoterInfo has store, key {
        id: 0x2::object::UID,
        request_creator: address,
        agree: u8,
        executed: bool,
        time_confirm: u64,
        new_address_voter: address,
        voted: vector<address>,
    }

    struct RegistryRequest has store, key {
        id: 0x2::object::UID,
        request_fund: vector<address>,
        request_treasury: vector<address>,
        request_change_voter: vector<address>,
    }

    struct Providers has store, key {
        id: 0x2::object::UID,
        providers_address: vector<address>,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: address,
        apy: u128,
        lock_period: u64,
    }

    struct StakeEvent has copy, drop, store {
        pool_id: address,
        owner: address,
        apy: u128,
        staked_amount: u128,
        stake_item_id: address,
        is_unstaked: bool,
        time_stake: u64,
        user_lastest_updated_time: u64,
        unlock_time: u64,
    }

    struct UnStakeEvent has copy, drop, store {
        pool_id: address,
        owner: address,
        staked_amount: u128,
        user_reward_remaining: u128,
        unlock_time: u64,
        stake_item_id: address,
        is_unstaked: bool,
        time_stake: u64,
    }

    struct RestakeRewardEvent has copy, drop, store {
        pool_id: address,
        owner: address,
        staked_amount: u128,
        stake_item_id: address,
        is_unstaked: bool,
        time_stake: u64,
        unlock_time: u64,
    }

    struct MigrateStakeEvent has copy, drop, store {
        pool_id: address,
        stake_item_id: address,
        owner: address,
        unlock_time: u64,
        staked_amount: u128,
        is_unstaked: bool,
        time_stake: u64,
        reqId: vector<u8>,
    }

    struct ClaimEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount_claimed: u128,
        stake_item_id: address,
    }

    struct DepositRewardEvent has copy, drop, store {
        pool_id: address,
        amount: u128,
        total_reward: u128,
    }

    struct WithdarawRewardEvent has copy, drop, store {
        pool_id: address,
        total_reward: u128,
    }

    struct UpdateApyEvent has copy, drop, store {
        user_address: address,
        stake_item_id: address,
        apy: u128,
        user_reward_remaining: u128,
    }

    struct StopEmergencyEvent has copy, drop, store {
        pool_id: address,
        total_staked: u128,
        paused: bool,
        stake_item_id: address,
    }

    struct RequestFundEvent has copy, drop, store {
        pool_id: address,
        vault_id: address,
        member: address,
        total_amount: u128,
        total_agree: u8,
        time_confirm: u64,
    }

    struct ConfirmRequest has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
        total_agree: u8,
    }

    struct ExecuteRequestFundEvent has copy, drop, store {
        pool_id: address,
        vault_id: address,
        request_info_id: address,
        member: address,
        total_agree: u8,
        total_amount: u128,
        executed: bool,
    }

    struct RevokeRequestFundEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
    }

    struct RequestChangeTreasuryEvent has copy, drop, store {
        vault_id: address,
        member: address,
        new_treasury: address,
        total_agree: u8,
        time_confirm: u64,
    }

    struct ConfirmRequestChangeTreasuryEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
        total_agree: u8,
    }

    struct ExecuteRequestChangeTreasuryEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
        new_treasury: address,
        total_agree: u8,
    }

    struct RevokeRequestChangeTreasuryEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
    }

    struct RequestChangeVoterEvent has copy, drop, store {
        vault_id: address,
        member: address,
        new_address_voter: address,
        total_agree: u8,
        time_confirm: u64,
    }

    struct ConfirmRequestChangeVoteEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
        total_agree: u8,
    }

    struct ExecuteRequestChangeVoterEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
        new_address_voter: address,
        total_agree: u8,
    }

    struct RevokeRequestChangeVoterEvent has copy, drop, store {
        vault_id: address,
        request_info_id: address,
        member: address,
    }

    struct UpdateLockPeriodEvent has copy, drop, store {
        pool_id: address,
        value: u64,
    }

    struct UpdateApyPool has copy, drop, store {
        pool_id: address,
        apy: u128,
    }

    struct UpdateMinStakeEvent has copy, drop, store {
        pool_id: address,
        value: u128,
    }

    struct UpgradeStakeItem has copy, drop, store {
        pool_id_old: address,
        pool_id_new: address,
        user_address: address,
        stake_item_id: address,
        staked_mount: u128,
        apy: u128,
        unlock_time: u128,
    }

    struct AddProviderEvent has copy, drop, store {
        provider_id: address,
        provider_mem_address: address,
    }

    struct RemoveProviderEvent has copy, drop, store {
        provider_id: address,
        provider_mem_address: address,
    }

    struct Restake has copy, drop, store {
        pool_id: address,
        owner: address,
        staked_amount: u128,
        stake_item_id: address,
        is_unstaked: bool,
        time_stake: u64,
        unlock_time: u64,
    }

    struct StakeEmergencyWithdrawEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut RegistryStakePool, arg4: &mut UserStakePoolInfo, arg5: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg5, 1);
        assert!(!arg0.paused, 8008);
        assert!(!arg0.stopAll, 8022);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = (0x2::coin::value<T0>(&arg1) as u128);
        assert!(v1 > 0, 8002);
        assert!(v1 >= arg0.min_stake, 8019);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = arg0.apy;
        let v4 = 0x2::object::id_address<StakePool<T0, T1>>(arg0);
        let v5 = StakeItem{
            id                   : 0x2::object::new(arg6),
            pool                 : v4,
            owner                : v2,
            apy                  : v3,
            staked_amount        : v1,
            unstaked             : false,
            reward_remaining     : 0,
            lastest_updated_time : v0,
            time_stake           : v0,
            unlock_times         : v0 + arg0.lock_period,
        };
        let (v6, _) = 0x1::vector::index_of<address>(&arg0.stakes, &v2);
        if (!v6) {
            0x1::vector::push_back<address>(&mut arg0.stakes, v2);
        };
        addRegistryStakePool(arg3, v2, 0x2::object::id_address<StakeItem>(&v5));
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg1);
        if (!0x2::table::contains<address, PoolStakedInfo>(&arg4.users_staked, v2)) {
            let v8 = PoolStakedInfo{pools_staked: 0x2::table::new<address, u128>(arg6)};
            0x2::table::add<address, u128>(&mut v8.pools_staked, v4, v1);
            0x2::table::add<address, PoolStakedInfo>(&mut arg4.users_staked, v2, v8);
        } else {
            let v9 = 0x2::table::borrow_mut<address, PoolStakedInfo>(&mut arg4.users_staked, v2);
            if (0x2::table::contains<address, u128>(&v9.pools_staked, v4)) {
                0x2::table::remove<address, u128>(&mut v9.pools_staked, v4);
                0x2::table::add<address, u128>(&mut v9.pools_staked, v4, v1 + *0x2::table::borrow_mut<address, u128>(&mut v9.pools_staked, v4));
            } else {
                0x2::table::add<address, u128>(&mut v9.pools_staked, v4, v1);
            };
        };
        let v10 = StakeEvent{
            pool_id                   : v4,
            owner                     : v2,
            apy                       : v3,
            staked_amount             : v1,
            stake_item_id             : 0x2::object::id_address<StakeItem>(&v5),
            is_unstaked               : false,
            time_stake                : v0,
            user_lastest_updated_time : v0,
            unlock_time               : v0 + arg0.lock_period,
        };
        0x2::event::emit<StakeEvent>(v10);
        0x2::transfer::share_object<StakeItem>(v5);
    }

    public fun addProvider(arg0: &Admincap, arg1: &mut Providers, arg2: address, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        let (v0, _) = 0x1::vector::index_of<address>(&arg1.providers_address, &arg2);
        if (!v0) {
            0x1::vector::push_back<address>(&mut arg1.providers_address, arg2);
        };
        let v2 = AddProviderEvent{
            provider_id          : 0x2::object::id_address<Providers>(arg1),
            provider_mem_address : arg2,
        };
        0x2::event::emit<AddProviderEvent>(v2);
    }

    fun addRegistryStakePool(arg0: &mut RegistryStakePool, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_items, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_items, arg1);
            let (v1, _) = 0x1::vector::index_of<address>(v0, &arg2);
            if (!v1) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.user_items, arg1, v3);
        };
    }

    public fun change_admin(arg0: Admincap, arg1: address, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        0x2::transfer::public_transfer<Admincap>(arg0, arg1);
    }

    public fun change_treasure(arg0: TreasureCap, arg1: address, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        0x2::transfer::public_transfer<TreasureCap>(arg0, arg1);
    }

    public fun claim<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut StakeItem, arg2: &mut RegistryStakePool, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        assert!(!arg0.stopAll, 8022);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<StakePool<T0, T1>>(arg0);
        assert!(0x1::vector::contains<address>(&arg0.stakes, &v0), 8001);
        assert!(0x2::table::contains<address, vector<address>>(&arg2.user_items, v0), 8001);
        assert!(0x2::table::contains<address, PoolInfo>(&arg2.pools, v1), 8001);
        assert!(arg1.pool == v1, 8001);
        assert!(arg1.owner == v0, 8001);
        let v2 = arg1.apy;
        update_reward_remaining(v2, 0x2::clock::timestamp_ms(arg3), arg1);
        arg0.total_reward_claimed = arg0.total_reward_claimed + arg1.reward_remaining;
        let v3 = (0x2::coin::value<T1>(&arg0.reward_coins) as u128);
        let v4 = arg1.reward_remaining;
        assert!(v4 > 0 && v3 >= v4, 8003);
        arg1.reward_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg5), v0);
        let v5 = ClaimEvent{
            pool_id        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address   : v0,
            amount_claimed : v3,
            stake_item_id  : 0x2::object::id_address<StakeItem>(arg1),
        };
        0x2::event::emit<ClaimEvent>(v5);
    }

    fun claim_<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut StakeItem, arg2: &RegistryStakePool, arg3: &0x2::clock::Clock, arg4: &0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        assert!(!arg0.stopAll, 8022);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<StakePool<T0, T1>>(arg0);
        assert!(0x1::vector::contains<address>(&arg0.stakes, &v0), 8001);
        assert!(0x2::table::contains<address, vector<address>>(&arg2.user_items, v0), 8001);
        assert!(0x2::table::contains<address, PoolInfo>(&arg2.pools, v1), 8001);
        assert!(arg1.pool == v1, 8001);
        assert!(arg1.owner == v0, 8001);
        let v2 = arg1.apy;
        update_reward_remaining(v2, 0x2::clock::timestamp_ms(arg3), arg1);
        arg0.total_reward_claimed = arg0.total_reward_claimed + arg1.reward_remaining;
        let v3 = (0x2::coin::value<T1>(&arg0.reward_coins) as u128);
        let v4 = arg1.reward_remaining;
        assert!(v4 >= 0 && v3 >= v4, 8003);
        arg1.reward_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg5), v0);
        let v5 = ClaimEvent{
            pool_id        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address   : v0,
            amount_claimed : v3,
            stake_item_id  : 0x2::object::id_address<StakeItem>(arg1),
        };
        0x2::event::emit<ClaimEvent>(v5);
    }

    public fun confirmRequestChangeTreasury(arg0: &mut VaultDAO, arg1: &mut RequestChangeTreasuryInfo, arg2: &mut RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<RequestChangeTreasuryInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg0.dao, v0), 8010);
        assert!(0x1::vector::contains<address>(&arg2.request_treasury, &v1), 8003);
        assert!(!0x1::vector::contains<address>(&arg1.voted, &v0), 8010);
        assert!(arg1.time_confirm >= 0x2::clock::timestamp_ms(arg3), 8010);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg0.dao, v0).vote = true;
        arg1.agree = arg1.agree + 1;
        0x1::vector::push_back<address>(&mut arg1.voted, v0);
        let v2 = ConfirmRequestChangeTreasuryEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg0),
            request_info_id : 0x2::object::id_address<RequestChangeTreasuryInfo>(arg1),
            member          : v0,
            total_agree     : arg1.agree,
        };
        0x2::event::emit<ConfirmRequestChangeTreasuryEvent>(v2);
    }

    public fun confirmRequestChangeVoter(arg0: &mut VaultDAO, arg1: &mut RequestChangeVoterInfo, arg2: &mut RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<RequestChangeVoterInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg0.dao, v0), 8010);
        assert!(0x1::vector::contains<address>(&arg2.request_change_voter, &v1), 8003);
        assert!(!0x1::vector::contains<address>(&arg1.voted, &v0), 8010);
        assert!(arg1.time_confirm >= 0x2::clock::timestamp_ms(arg3), 8010);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg0.dao, v0).vote = true;
        arg1.agree = arg1.agree + 1;
        0x1::vector::push_back<address>(&mut arg1.voted, v0);
        let v2 = ConfirmRequestChangeVoteEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg0),
            request_info_id : v1,
            member          : v0,
            total_agree     : arg1.agree,
        };
        0x2::event::emit<ConfirmRequestChangeVoteEvent>(v2);
    }

    public fun confirmRequestFund(arg0: &mut VaultDAO, arg1: &mut RequestFundInfo, arg2: &mut RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<RequestFundInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg0.dao, v0), 8010);
        assert!(0x1::vector::contains<address>(&arg2.request_fund, &v1), 8003);
        assert!(!0x1::vector::contains<address>(&arg1.voted, &v0), 8010);
        assert!(arg1.time_confirm >= 0x2::clock::timestamp_ms(arg3), 8010);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg0.dao, v0).vote = true;
        arg1.agree = arg1.agree + 1;
        0x1::vector::push_back<address>(&mut arg1.voted, v0);
        let v2 = ConfirmRequest{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg0),
            request_info_id : 0x2::object::id_address<RequestFundInfo>(arg1),
            member          : v0,
            total_agree     : arg1.agree,
        };
        0x2::event::emit<ConfirmRequest>(v2);
    }

    public fun createPool<T0, T1>(arg0: &Admincap, arg1: u128, arg2: u64, arg3: &mut RegistryStakePool, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg6, 1);
        assert!(arg1 > 0 && arg2 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id                   : 0x2::object::new(arg7),
            apy                  : arg1,
            paused               : false,
            stopAll              : false,
            lock_period          : arg2,
            min_stake            : 500000000000,
            total_reward_claimed : 0,
            reward_coins         : 0x2::coin::zero<T1>(arg7),
            stake_coins          : 0x2::coin::zero<T0>(arg7),
            stakes               : 0x1::vector::empty<address>(),
        };
        let v1 = 0x2::object::id_address<StakePool<T0, T1>>(&v0);
        let v2 = PoolInfo{
            id        : v1,
            rTypeCoin : arg4,
            sTypeCoin : arg5,
        };
        0x2::table::add<address, PoolInfo>(&mut arg3.pools, v1, v2);
        let v3 = CreatePoolEvent{
            pool_id     : v1,
            apy         : arg1,
            lock_period : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v3);
        0x2::transfer::share_object<StakePool<T0, T1>>(v0);
    }

    public fun depositRewardCoins<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        let v0 = (0x2::coin::value<T1>(&arg3) as u128);
        assert!(v0 > 0, 8002);
        0x2::coin::join<T1>(&mut arg1.reward_coins, arg3);
        let v1 = DepositRewardEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount       : v0,
            total_reward : (0x2::coin::value<T1>(&arg1.reward_coins) as u128),
        };
        0x2::event::emit<DepositRewardEvent>(v1);
    }

    public fun emergencyStakeWithdraw<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1.stake_coins);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, v1, arg4), v0);
        let v2 = StakeEmergencyWithdrawEvent{
            owner     : v0,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakeEmergencyWithdrawEvent>(v2);
    }

    public fun executeRequestChangeTreasury(arg0: &mut RegistryRequest, arg1: &mut RequestChangeTreasuryInfo, arg2: &mut VaultDAO, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<RequestChangeTreasuryInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg2.dao, v0), 8013);
        assert!(0x1::vector::contains<address>(&arg0.request_treasury, &v1), 8003);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.time_confirm, 8013);
        assert!(0x2::table::borrow<address, VoteInfo>(&arg2.dao, v0).vote == true, 8013);
        assert!(0x1::vector::contains<address>(&arg1.voted, &v0), 8013);
        assert!(arg1.agree >= arg2.num_confirmations_required, 8013);
        arg1.executed = true;
        arg2.treasury = arg1.new_treasury_address;
        let v2 = ExecuteRequestChangeTreasuryEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg2),
            request_info_id : 0x2::object::id_address<RequestChangeTreasuryInfo>(arg1),
            member          : v0,
            new_treasury    : arg2.treasury,
            total_agree     : arg1.agree,
        };
        0x2::event::emit<ExecuteRequestChangeTreasuryEvent>(v2);
    }

    public fun executeRequestChangeVoter(arg0: &mut RegistryRequest, arg1: &mut RequestChangeVoterInfo, arg2: &mut VaultDAO, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id_address<RequestChangeVoterInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg2.dao, v0), 8015);
        assert!(0x1::vector::contains<address>(&arg0.request_change_voter, &v1), 8003);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.time_confirm, 8015);
        assert!(0x2::table::borrow_mut<address, VoteInfo>(&mut arg2.dao, v0).vote == true, 8015);
        assert!(0x1::vector::contains<address>(&arg1.voted, &v0), 8015);
        assert!(arg1.agree >= arg2.num_confirmations_required, 8015);
        arg1.executed = true;
        0x2::table::remove<address, VoteInfo>(&mut arg2.dao, arg1.request_creator);
        arg2.quorum = arg2.quorum - 1;
        let v2 = VoteInfo{vote: false};
        0x2::table::add<address, VoteInfo>(&mut arg2.dao, arg1.new_address_voter, v2);
        arg2.quorum = arg2.quorum + 1;
        let v3 = ExecuteRequestChangeVoterEvent{
            vault_id          : 0x2::object::id_address<VaultDAO>(arg2),
            request_info_id   : v1,
            member            : v0,
            new_address_voter : arg1.new_address_voter,
            total_agree       : arg1.agree,
        };
        0x2::event::emit<ExecuteRequestChangeVoterEvent>(v3);
    }

    public fun executeRequestFund<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut RequestFundInfo, arg2: &mut RegistryRequest, arg3: &mut VaultDAO, arg4: &0x2::clock::Clock, arg5: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg5, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id_address<RequestFundInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg3.dao, v0), 8011);
        assert!(0x1::vector::contains<address>(&arg2.request_fund, &v1), 8003);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg1.time_confirm, 8011);
        assert!(0x2::table::borrow<address, VoteInfo>(&arg3.dao, v0).vote == true, 8011);
        assert!(0x1::vector::contains<address>(&arg1.voted, &v0), 8011);
        assert!(0x2::object::id_address<StakePool<T0, T1>>(arg0) == arg1.pool_id, 8011);
        assert!(arg1.agree >= arg3.num_confirmations_required, 8011);
        arg1.executed = true;
        withdrawRewardCoins<T0, T1>(arg3, arg1, arg0, arg6);
        let v2 = ExecuteRequestFundEvent{
            pool_id         : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            vault_id        : 0x2::object::id_address<VaultDAO>(arg3),
            request_info_id : 0x2::object::id_address<RequestFundInfo>(arg1),
            member          : v0,
            total_agree     : arg1.agree,
            total_amount    : arg1.total_amount,
            executed        : arg1.executed,
        };
        0x2::event::emit<ExecuteRequestFundEvent>(v2);
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admincap{id: 0x2::object::new(arg1)};
        let v1 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Admincap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<TreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = RegistryStakePool{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<address, PoolInfo>(arg1),
            user_items : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<RegistryStakePool>(v2);
        let v3 = RegistryRequest{
            id                   : 0x2::object::new(arg1),
            request_fund         : 0x1::vector::empty<address>(),
            request_treasury     : 0x1::vector::empty<address>(),
            request_change_voter : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<RegistryRequest>(v3);
        let v4 = Providers{
            id                : 0x2::object::new(arg1),
            providers_address : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Providers>(v4);
        let v5 = UserStakePoolInfo{
            id           : 0x2::object::new(arg1),
            users_staked : 0x2::table::new<address, PoolStakedInfo>(arg1),
        };
        0x2::transfer::share_object<UserStakePoolInfo>(v5);
        let v6 = RequestId{
            id      : 0x2::object::new(arg1),
            request : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<RequestId>(v6);
        let v7 = VaultDAO{
            id                         : 0x2::object::new(arg1),
            dao                        : 0x2::table::new<address, VoteInfo>(arg1),
            quorum                     : 3,
            num_confirmations_required : 2,
            treasury                   : @0x20cbe8951a9d41feb945dd24abbe024ea4d37cc3570b46482eaccf3f413543bc,
        };
        let v8 = VoteInfo{vote: false};
        0x2::table::add<address, VoteInfo>(&mut v7.dao, @0x145177f5e2a04734a9f362874e76beb573aa8bbf2d821b8041d25f4b780aefc5, v8);
        0x2::table::add<address, VoteInfo>(&mut v7.dao, @0xeff23cd7514e75cf170b5507e96c831c944077a9e70cf6a46d1c74665abcca9e, v8);
        0x2::table::add<address, VoteInfo>(&mut v7.dao, @0xea9f3b2f71e969fe47b256c521a67518e5bc5b9839cb2d55b208d61cbdf01342, v8);
        0x2::transfer::share_object<VaultDAO>(v7);
    }

    public fun migrateStake<T0, T1>(arg0: &mut Providers, arg1: &mut StakePool<T0, T1>, arg2: &mut RegistryStakePool, arg3: &mut UserStakePoolInfo, arg4: &mut RequestId, arg5: vector<u8>, arg6: address, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg9, 1);
        assert!(!arg1.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x1::vector::contains<address>(&arg0.providers_address, &v0), 8001);
        assert!(!0x1::vector::contains<vector<u8>>(&arg4.request, &arg5), 8023);
        0x1::vector::push_back<vector<u8>>(&mut arg4.request, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = (0x2::coin::value<T0>(&arg7) as u128);
        assert!(v2 > 0, 8002);
        let v3 = 0x2::object::id_address<StakePool<T0, T1>>(arg1);
        let v4 = StakeItem{
            id                   : 0x2::object::new(arg10),
            pool                 : v3,
            owner                : arg6,
            apy                  : arg1.apy,
            staked_amount        : v2,
            unstaked             : false,
            reward_remaining     : 0,
            lastest_updated_time : v1,
            time_stake           : v1,
            unlock_times         : v1 + arg1.lock_period,
        };
        let v5 = 0x2::object::id_address<StakeItem>(&v4);
        let (v6, _) = 0x1::vector::index_of<address>(&arg1.stakes, &arg6);
        if (!v6) {
            0x1::vector::push_back<address>(&mut arg1.stakes, arg6);
        };
        addRegistryStakePool(arg2, arg6, v5);
        0x2::coin::join<T0>(&mut arg1.stake_coins, arg7);
        if (!0x2::table::contains<address, PoolStakedInfo>(&arg3.users_staked, arg6)) {
            let v8 = PoolStakedInfo{pools_staked: 0x2::table::new<address, u128>(arg10)};
            0x2::table::add<address, u128>(&mut v8.pools_staked, v3, v2);
            0x2::table::add<address, PoolStakedInfo>(&mut arg3.users_staked, arg6, v8);
        } else {
            let v9 = 0x2::table::borrow_mut<address, PoolStakedInfo>(&mut arg3.users_staked, arg6);
            if (0x2::table::contains<address, u128>(&v9.pools_staked, v3)) {
                0x2::table::remove<address, u128>(&mut v9.pools_staked, v3);
                0x2::table::add<address, u128>(&mut v9.pools_staked, v3, v2 + *0x2::table::borrow_mut<address, u128>(&mut v9.pools_staked, v3));
            } else {
                0x2::table::add<address, u128>(&mut v9.pools_staked, v3, v2);
            };
        };
        let v10 = MigrateStakeEvent{
            pool_id       : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            stake_item_id : v5,
            owner         : arg6,
            unlock_time   : v1 + arg1.lock_period,
            staked_amount : v2,
            is_unstaked   : false,
            time_stake    : v1,
            reqId         : arg5,
        };
        0x2::event::emit<MigrateStakeEvent>(v10);
        0x2::transfer::share_object<StakeItem>(v4);
    }

    public fun pause<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        arg1.paused = true;
    }

    public fun reStakeRewards<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut StakeItem, arg2: &mut RegistryStakePool, arg3: &mut UserStakePoolInfo, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        assert!(!arg0.paused, 8008);
        assert!(!arg0.stopAll, 8022);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::id_address<StakePool<T0, T1>>(arg0);
        assert!(0x1::vector::contains<address>(&arg0.stakes, &v1), 8001);
        assert!(0x2::table::contains<address, vector<address>>(&arg2.user_items, v1), 8001);
        assert!(0x2::table::contains<address, PoolInfo>(&arg2.pools, v2), 8001);
        assert!(arg1.pool == v2, 8001);
        assert!(arg1.owner == v1, 8001);
        let v3 = arg1.apy;
        update_reward_remaining(v3, v0, arg1);
        let v4 = arg1.reward_remaining;
        assert!(v4 > 0, 8020);
        arg1.staked_amount = arg1.staked_amount + v4;
        arg1.reward_remaining = 0;
        if (v0 <= arg1.unlock_times) {
            let v5 = 0x2::table::borrow_mut<address, PoolStakedInfo>(&mut arg3.users_staked, v1);
            0x2::table::remove<address, u128>(&mut v5.pools_staked, v2);
            0x2::table::add<address, u128>(&mut v5.pools_staked, v2, *0x2::table::borrow_mut<address, u128>(&mut v5.pools_staked, v2) + v4);
        };
        let v6 = RestakeRewardEvent{
            pool_id       : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            owner         : v1,
            staked_amount : arg1.staked_amount,
            stake_item_id : 0x2::object::id_address<StakeItem>(arg1),
            is_unstaked   : arg1.unstaked,
            time_stake    : arg1.time_stake,
            unlock_time   : arg1.unlock_times,
        };
        0x2::event::emit<RestakeRewardEvent>(v6);
    }

    public fun removeProvider(arg0: &Admincap, arg1: &mut Providers, arg2: address, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.providers_address, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.providers_address, v1);
        };
        let v2 = RemoveProviderEvent{
            provider_id          : 0x2::object::id_address<Providers>(arg1),
            provider_mem_address : arg2,
        };
        0x2::event::emit<RemoveProviderEvent>(v2);
    }

    public fun requestChangeTreasury(arg0: address, arg1: &mut VaultDAO, arg2: &mut RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, VoteInfo>(&arg1.dao, v0), 8017);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg1.dao, v0).vote = true;
        let v1 = RequestChangeTreasuryInfo{
            id                   : 0x2::object::new(arg5),
            request_creator      : v0,
            agree                : 1,
            executed             : false,
            time_confirm         : 0x2::clock::timestamp_ms(arg3) + 3600000,
            new_treasury_address : arg0,
            voted                : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v1.voted, v0);
        0x1::vector::push_back<address>(&mut arg2.request_treasury, 0x2::object::id_address<RequestChangeTreasuryInfo>(&v1));
        let v2 = RequestChangeTreasuryEvent{
            vault_id     : 0x2::object::id_address<VaultDAO>(arg1),
            member       : v0,
            new_treasury : arg0,
            total_agree  : v1.agree,
            time_confirm : v1.time_confirm,
        };
        0x2::event::emit<RequestChangeTreasuryEvent>(v2);
        0x2::transfer::share_object<RequestChangeTreasuryInfo>(v1);
    }

    public fun requestChangeVoter(arg0: address, arg1: &mut VaultDAO, arg2: &mut RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, VoteInfo>(&arg1.dao, v0), 8016);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg1.dao, v0).vote = true;
        let v1 = RequestChangeVoterInfo{
            id                : 0x2::object::new(arg5),
            request_creator   : v0,
            agree             : 1,
            executed          : false,
            time_confirm      : 0x2::clock::timestamp_ms(arg3) + 3600000,
            new_address_voter : arg0,
            voted             : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v1.voted, v0);
        0x1::vector::push_back<address>(&mut arg2.request_change_voter, 0x2::object::id_address<RequestChangeVoterInfo>(&v1));
        let v2 = RequestChangeVoterEvent{
            vault_id          : 0x2::object::id_address<VaultDAO>(arg1),
            member            : v0,
            new_address_voter : arg0,
            total_agree       : v1.agree,
            time_confirm      : v1.time_confirm,
        };
        0x2::event::emit<RequestChangeVoterEvent>(v2);
        0x2::transfer::share_object<RequestChangeVoterInfo>(v1);
    }

    public fun requestFund<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut VaultDAO, arg2: &mut RegistryStakePool, arg3: &mut RegistryRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg5, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, PoolInfo>(&arg2.pools, 0x2::object::id_address<StakePool<T0, T1>>(arg0)), 8003);
        let v1 = (0x2::coin::value<T1>(&arg0.reward_coins) as u128);
        assert!(v1 > 0, 8003);
        assert!(0x2::table::contains<address, VoteInfo>(&arg1.dao, v0), 8010);
        0x2::table::borrow_mut<address, VoteInfo>(&mut arg1.dao, v0).vote = true;
        let v2 = RequestFundInfo{
            id              : 0x2::object::new(arg6),
            pool_id         : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            request_creator : v0,
            total_amount    : v1,
            agree           : 1,
            executed        : false,
            time_confirm    : 0x2::clock::timestamp_ms(arg4) + 3600000,
            voted           : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v2.voted, v0);
        0x1::vector::push_back<address>(&mut arg3.request_fund, 0x2::object::id_address<RequestFundInfo>(&v2));
        let v3 = RequestFundEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            vault_id     : 0x2::object::id_address<VaultDAO>(arg1),
            member       : 0x2::tx_context::sender(arg6),
            total_amount : v2.total_amount,
            total_agree  : v2.agree,
            time_confirm : v2.time_confirm,
        };
        0x2::event::emit<RequestFundEvent>(v3);
        0x2::transfer::share_object<RequestFundInfo>(v2);
    }

    public fun restake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut StakeItem, arg2: &mut RegistryStakePool, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        assert!(!arg0.stopAll, 8022);
        claim_<T0, T1>(arg0, arg1, arg2, arg4, arg3, arg5);
        arg1.unlock_times = 0x2::clock::timestamp_ms(arg4) + arg0.lock_period;
        let v0 = Restake{
            pool_id       : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            owner         : 0x2::tx_context::sender(arg5),
            staked_amount : arg1.staked_amount,
            stake_item_id : 0x2::object::id_address<StakeItem>(arg1),
            is_unstaked   : arg1.unstaked,
            time_stake    : arg1.time_stake,
            unlock_time   : arg1.unlock_times,
        };
        0x2::event::emit<Restake>(v0);
    }

    public fun revokeRequestChangeTreasury(arg0: &mut RegistryRequest, arg1: &mut VaultDAO, arg2: &mut RequestChangeTreasuryInfo, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id_address<RequestChangeTreasuryInfo>(arg2);
        assert!(0x2::table::contains<address, VoteInfo>(&arg1.dao, v0), 8014);
        assert!(0x1::vector::contains<address>(&arg0.request_treasury, &v1), 8003);
        assert!(arg2.request_creator == v0, 8014);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg0.request_treasury, &v1);
        if (v2) {
            0x1::vector::remove<address>(&mut arg0.request_treasury, v3);
        };
        let v4 = RevokeRequestChangeTreasuryEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg1),
            request_info_id : v1,
            member          : v0,
        };
        0x2::event::emit<RevokeRequestChangeTreasuryEvent>(v4);
    }

    public fun revokeRequestChangeVoter(arg0: &mut RegistryRequest, arg1: &mut VaultDAO, arg2: &mut RequestChangeVoterInfo, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id_address<RequestChangeVoterInfo>(arg2);
        assert!(0x2::table::contains<address, VoteInfo>(&arg1.dao, v0), 8018);
        assert!(0x1::vector::contains<address>(&arg0.request_change_voter, &v1), 8003);
        assert!(arg2.new_address_voter == v0 || arg2.request_creator == v0, 8018);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg0.request_change_voter, &v1);
        if (v2) {
            0x1::vector::remove<address>(&mut arg0.request_change_voter, v3);
        };
        let v4 = RevokeRequestChangeVoterEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg1),
            request_info_id : v1,
            member          : v0,
        };
        0x2::event::emit<RevokeRequestChangeVoterEvent>(v4);
    }

    public fun revokeRequestFund(arg0: &mut VaultDAO, arg1: &mut RequestFundInfo, arg2: &mut RegistryRequest, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id_address<RequestFundInfo>(arg1);
        assert!(0x2::table::contains<address, VoteInfo>(&arg0.dao, v0), 8012);
        assert!(0x1::vector::contains<address>(&arg2.request_fund, &v1), 8003);
        assert!(arg1.request_creator == v0, 8012);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg2.request_fund, &v1);
        if (v2) {
            0x1::vector::remove<address>(&mut arg2.request_fund, v3);
        };
        let v4 = RevokeRequestFundEvent{
            vault_id        : 0x2::object::id_address<VaultDAO>(arg0),
            request_info_id : v1,
            member          : v0,
        };
        0x2::event::emit<RevokeRequestFundEvent>(v4);
    }

    public fun stopAll<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        arg1.stopAll = true;
    }

    public fun stopEmergency<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut StakeItem, arg3: &mut RegistryStakePool, arg4: &mut UserStakePoolInfo, arg5: address, arg6: bool, arg7: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg7, 1);
        let v0 = 0x2::object::id_address<StakePool<T0, T1>>(arg1);
        assert!(0x1::vector::contains<address>(&arg1.stakes, &arg5), 8001);
        assert!(0x2::table::contains<address, vector<address>>(&arg3.user_items, arg5), 8001);
        assert!(0x2::table::contains<address, PoolInfo>(&arg3.pools, v0), 8001);
        assert!(arg2.pool == v0, 8001);
        assert!(arg2.owner == arg5, 8001);
        let v1 = arg2.staked_amount;
        assert!(v1 > 0 && v1 <= (0x2::coin::value<T0>(&arg1.stake_coins) as u128), 8003);
        arg2.staked_amount = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, (v1 as u64), arg9), arg5);
        arg1.paused = arg6;
        if (0x2::clock::timestamp_ms(arg8) <= arg2.unlock_times) {
            let v2 = 0x2::table::borrow_mut<address, PoolStakedInfo>(&mut arg4.users_staked, arg5);
            0x2::table::remove<address, u128>(&mut v2.pools_staked, v0);
            0x2::table::add<address, u128>(&mut v2.pools_staked, v0, *0x2::table::borrow_mut<address, u128>(&mut v2.pools_staked, v0) - v1);
        };
        let v3 = StopEmergencyEvent{
            pool_id       : v0,
            total_staked  : (0x2::coin::value<T0>(&arg1.stake_coins) as u128),
            paused        : arg6,
            stake_item_id : 0x2::object::id_address<StakeItem>(arg2),
        };
        0x2::event::emit<StopEmergencyEvent>(v3);
    }

    public fun unPause<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        assert!(arg1.paused == true, 8003);
        arg1.paused = false;
    }

    public fun unStopAll<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg2, 1);
        assert!(arg1.stopAll == true, 8003);
        arg1.stopAll = false;
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut StakeItem, arg3: &mut RegistryStakePool, arg4: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg4, 1);
        assert!(!arg0.stopAll, 8022);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::id_address<StakePool<T0, T1>>(arg0);
        assert!(0x1::vector::contains<address>(&arg0.stakes, &v1), 8009);
        assert!(0x2::table::contains<address, vector<address>>(&arg3.user_items, v1), 8001);
        assert!(0x2::table::contains<address, PoolInfo>(&arg3.pools, v2), 8001);
        assert!(arg2.pool == v2, 8001);
        assert!(arg2.owner == v1, 8001);
        assert!(v0 >= arg2.unlock_times, 8006);
        let v3 = arg2.apy;
        update_reward_remaining(v3, v0, arg2);
        arg0.total_reward_claimed = arg0.total_reward_claimed + arg2.reward_remaining;
        let v4 = arg2.reward_remaining;
        assert!(v4 >= 0 && (0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v4, 8003);
        arg2.reward_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg5), v1);
        let v5 = (0x2::coin::value<T0>(&arg0.stake_coins) as u128);
        let v6 = arg2.staked_amount;
        assert!(v5 > 0 && v5 >= v6, 8005);
        arg2.unstaked = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.stake_coins, (v6 as u64), arg5), v1);
        let v7 = UnStakeEvent{
            pool_id               : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            owner                 : v1,
            staked_amount         : v6,
            user_reward_remaining : arg2.reward_remaining,
            unlock_time           : arg2.unlock_times,
            stake_item_id         : 0x2::object::id_address<StakeItem>(arg2),
            is_unstaked           : arg2.unstaked,
            time_stake            : arg2.time_stake,
        };
        0x2::event::emit<UnStakeEvent>(v7);
    }

    public fun updateApyPool<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: u128, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        arg1.apy = arg2;
        let v0 = UpdateApyPool{
            pool_id : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            apy     : arg2,
        };
        0x2::event::emit<UpdateApyPool>(v0);
    }

    public fun updateApyStakeItem(arg0: &Admincap, arg1: u128, arg2: address, arg3: &mut StakeItem, arg4: &RegistryStakePool, arg5: &0x2::clock::Clock, arg6: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg6, 1);
        assert!(0x2::table::contains<address, vector<address>>(&arg4.user_items, arg2), 8001);
        assert!(arg3.owner == arg2, 8001);
        let v0 = arg3.apy;
        update_reward_remaining(v0, 0x2::clock::timestamp_ms(arg5), arg3);
        arg3.apy = arg1;
        let v1 = UpdateApyEvent{
            user_address          : arg2,
            stake_item_id         : 0x2::object::id_address<StakeItem>(arg3),
            apy                   : arg1,
            user_reward_remaining : arg3.reward_remaining,
        };
        0x2::event::emit<UpdateApyEvent>(v1);
    }

    public fun updateLockPeriod<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: u64, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        arg1.lock_period = arg2;
        let v0 = UpdateLockPeriodEvent{
            pool_id : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            value   : arg2,
        };
        0x2::event::emit<UpdateLockPeriodEvent>(v0);
    }

    public fun updateMinStake<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: u128, arg3: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        arg1.min_stake = arg2;
        let v0 = UpdateMinStakeEvent{
            pool_id : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            value   : arg2,
        };
        0x2::event::emit<UpdateMinStakeEvent>(v0);
    }

    fun update_reward_remaining(arg0: u128, arg1: u64, arg2: &mut StakeItem) {
        assert!(arg0 > 0, 8001);
        let v0 = arg2.unlock_times;
        if (arg1 >= v0) {
            let v1 = if (v0 >= arg2.lastest_updated_time) {
                ((v0 - arg2.lastest_updated_time) as u128)
            } else {
                0
            };
            if (v1 >= 0) {
                arg2.reward_remaining = arg2.reward_remaining + v1 * arg2.staked_amount * arg0 / ((31536000000 * 10000) as u128);
                arg2.lastest_updated_time = arg1;
            };
        } else {
            arg2.reward_remaining = arg2.reward_remaining + ((arg1 - arg2.lastest_updated_time) as u128) * arg2.staked_amount * arg0 / ((31536000000 * 10000) as u128);
            arg2.lastest_updated_time = arg1;
        };
    }

    public fun upgradeStakeItem<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut StakePool<T0, T1>, arg2: &mut StakeItem, arg3: &mut RegistryStakePool, arg4: &0x2::clock::Clock, arg5: &mut UserStakePoolInfo, arg6: &mut 0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6846b3d701be56b291483a0bb81f51ef88773978ea7e56cd9dd353ece71d8c2d::version::checkVersion(arg6, 1);
        assert!(!arg1.paused, 8008);
        assert!(!arg1.stopAll, 8022);
        assert!(!arg0.stopAll, 8022);
        assert!(arg1.lock_period > arg0.lock_period, 8021);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg7);
        claim_<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7);
        let v2 = 0x2::object::id_address<StakePool<T0, T1>>(arg1);
        let v3 = arg2.staked_amount;
        let v4 = 0x2::table::borrow_mut<address, PoolStakedInfo>(&mut arg5.users_staked, v1);
        if (!0x2::table::contains<address, u128>(&v4.pools_staked, v2) && v0 <= arg2.unlock_times) {
            0x2::table::add<address, u128>(&mut v4.pools_staked, v2, v3);
        } else {
            0x2::table::remove<address, u128>(&mut v4.pools_staked, v2);
            0x2::table::add<address, u128>(&mut v4.pools_staked, v2, v3 + *0x2::table::borrow_mut<address, u128>(&mut v4.pools_staked, 0x2::object::id_address<StakePool<T0, T1>>(arg1)));
        };
        if (v0 <= arg2.unlock_times) {
            0x2::table::remove<address, u128>(&mut v4.pools_staked, 0x2::object::id_address<StakePool<T0, T1>>(arg0));
            0x2::table::add<address, u128>(&mut v4.pools_staked, 0x2::object::id_address<StakePool<T0, T1>>(arg0), *0x2::table::borrow_mut<address, u128>(&mut v4.pools_staked, 0x2::object::id_address<StakePool<T0, T1>>(arg0)) - v3);
        };
        if (v0 < arg2.unlock_times) {
            arg2.unlock_times = v0 + arg1.lock_period - v0 - arg2.time_stake;
        } else {
            arg2.unlock_times = v0 + arg1.lock_period - arg0.lock_period;
        };
        arg2.pool = v2;
        arg2.apy = arg1.apy;
        arg2.owner = v1;
        arg2.lastest_updated_time = v0;
        arg2.time_stake = v0;
        0x2::coin::join<T0>(&mut arg1.stake_coins, 0x2::coin::split<T0>(&mut arg0.stake_coins, (v3 as u64), arg7));
        let (v5, _) = 0x1::vector::index_of<address>(&arg1.stakes, &v1);
        if (!v5) {
            0x1::vector::push_back<address>(&mut arg1.stakes, v1);
        };
        let v7 = UpgradeStakeItem{
            pool_id_old   : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            pool_id_new   : v2,
            user_address  : v1,
            stake_item_id : 0x2::object::id_address<StakeItem>(arg2),
            staked_mount  : arg2.staked_amount,
            apy           : arg1.apy,
            unlock_time   : (arg2.unlock_times as u128),
        };
        0x2::event::emit<UpgradeStakeItem>(v7);
    }

    fun withdrawRewardCoins<T0, T1>(arg0: &VaultDAO, arg1: &RequestFundInfo, arg2: &mut StakePool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T1>(&arg2.reward_coins) as u128);
        assert!(v0 > 0 && arg1.total_amount <= v0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2.reward_coins, (v0 as u64), arg3), arg0.treasury);
        let v1 = WithdarawRewardEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(arg2),
            total_reward : v0,
        };
        0x2::event::emit<WithdarawRewardEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

