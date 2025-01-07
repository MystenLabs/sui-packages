module 0xfe5f5d6aaf3dcc8ae9c36ecb99348a15c39c2520cf2ea9ca5fb8459c29afc3a7::boosted_reward_distruibutor {
    struct DLPRewardPool has store, key {
        id: 0x2::object::UID,
        version: u8,
        pool: RewardPool,
    }

    struct BaseRewardPool has store, key {
        id: 0x2::object::UID,
        version: u8,
        pool: RewardPool,
    }

    struct RewardPool has store {
        pool_ids: vector<u8>,
        reward_assets: vector<u8>,
        assets_reward_rates: 0x2::table::Table<u8, PoolRewardRates>,
    }

    struct PoolRewardRates has store {
        id: 0x2::object::UID,
        rates: 0x2::table::Table<u8, u256>,
    }

    struct RewardAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun claim_all_base_boosted_reward(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun claim_all_dlp_boosted_reward(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun claim_base_boosted_reward(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun claim_dlp_boosted_reward(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RewardAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RewardPool{
            pool_ids            : 0x1::vector::empty<u8>(),
            reward_assets       : 0x1::vector::empty<u8>(),
            assets_reward_rates : 0x2::table::new<u8, PoolRewardRates>(arg0),
        };
        let v2 = RewardPool{
            pool_ids            : 0x1::vector::empty<u8>(),
            reward_assets       : 0x1::vector::empty<u8>(),
            assets_reward_rates : 0x2::table::new<u8, PoolRewardRates>(arg0),
        };
        let v3 = DLPRewardPool{
            id      : 0x2::object::new(arg0),
            version : 6,
            pool    : v1,
        };
        0x2::transfer::share_object<DLPRewardPool>(v3);
        let v4 = BaseRewardPool{
            id      : 0x2::object::new(arg0),
            version : 6,
            pool    : v2,
        };
        0x2::transfer::share_object<BaseRewardPool>(v4);
    }

    public entry fun register_base_reward_asset<T0>(arg0: &RewardAdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun register_dlp_reward_asset<T0>(arg0: &RewardAdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun register_reward_pool(arg0: &RewardAdminCap, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun set_base_reward_rates(arg0: &RewardAdminCap, arg1: vector<u8>, arg2: vector<u256>) {
    }

    public entry fun set_base_reward_rates_for_asset(arg0: &RewardAdminCap, arg1: vector<u64>, arg2: u8, arg3: vector<u64>) {
    }

    public entry fun set_dlp_reward_factors_for_asset(arg0: &RewardAdminCap, arg1: vector<u64>, arg2: u8, arg3: vector<u64>) {
    }

    public entry fun set_dlp_reward_rates(arg0: &RewardAdminCap, arg1: vector<u8>, arg2: vector<u256>) {
    }

    public entry fun set_staking_reward_rate(arg0: &RewardAdminCap, arg1: vector<u64>, arg2: u256) {
    }

    public(friend) fun update_user_reward_state(arg0: address, arg1: bool) {
    }

    // decompiled from Move bytecode v6
}

