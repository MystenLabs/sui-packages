module 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::staking {
    struct StakeEntry<T0: store + key> has key {
        id: 0x2::object::UID,
        nft: T0,
        nft_owner: address,
        staked_at_epoch: u64,
        last_claimed_epoch: u64,
        stake_pool_id: 0x2::object::ID,
        url: 0x1::option::Option<0x2::url::Url>,
    }

    public entry fun create_stake_pool<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::StakePool<T0>>(0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::create_stake_pool<T0>(arg0, 0x2::tx_context::sender(arg6), arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun claim<T0: store + key, T1>(arg0: &mut StakeEntry<T0>, arg1: &mut 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::StakePool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.nft_owner, 1);
        assert!(0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::id<T1>(arg1) == arg0.stake_pool_id, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_claimed_epoch = v1;
        0x2::coin::mint_and_transfer<T1>(0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::treasury_cap_<T1>(arg1), rewards_since_last_claim(v1, arg0.last_claimed_epoch, 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::reward_rate<T1>(arg1)), v0, arg3);
    }

    public fun create_stake_entry<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : StakeEntry<T0> {
        StakeEntry<T0>{
            id                 : 0x2::object::new(arg5),
            nft                : arg0,
            nft_owner          : arg1,
            staked_at_epoch    : arg2,
            last_claimed_epoch : arg3,
            stake_pool_id      : arg4,
            url                : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://QmY4MFz7WiFQH8DehNixY42JomCiA9yVoRZBvXRhbmg5yP"))),
        }
    }

    public fun redeem_and_destroy_stake_entry<T0: store + key>(arg0: StakeEntry<T0>, arg1: address) {
        let StakeEntry {
            id                 : v0,
            nft                : v1,
            nft_owner          : _,
            staked_at_epoch    : _,
            last_claimed_epoch : _,
            stake_pool_id      : _,
            url                : _,
        } = arg0;
        0x2::transfer::public_transfer<T0>(v1, arg1);
        0x2::object::delete(v0);
    }

    fun rewards_since_last_claim(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (arg0 - arg1) * arg2
    }

    public entry fun stake<T0: store + key, T1>(arg0: T0, arg1: &mut 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::StakePool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::increment_staked_nfts_<T1>(arg1);
        0x2::transfer::transfer<StakeEntry<T0>>(create_stake_entry<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2), 0x2::clock::timestamp_ms(arg2), 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::id<T1>(arg1), arg3), v0);
    }

    public entry fun unstake<T0: store + key, T1>(arg0: StakeEntry<T0>, arg1: &mut 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::StakePool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.nft_owner, 1);
        assert!(0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::id<T1>(arg1) == arg0.stake_pool_id, 2);
        let v1 = &mut arg0;
        claim<T0, T1>(v1, arg1, arg2, arg3);
        redeem_and_destroy_stake_entry<T0>(arg0, v0);
        0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool::decrement_staked_nfts_<T1>(arg1);
    }

    // decompiled from Move bytecode v6
}

