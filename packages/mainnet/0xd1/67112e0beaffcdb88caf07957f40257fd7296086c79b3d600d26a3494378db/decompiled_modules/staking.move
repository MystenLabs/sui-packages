module 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        fee_id: 0x2::object::ID,
    }

    struct Fees has store, key {
        id: 0x2::object::UID,
        fee_collector_1: address,
        fee_collector_2: address,
        unstake_fee_1: u64,
        unstake_fee_2: u64,
        claim_fee_1: u64,
        claim_fee_2: u64,
    }

    struct StakeEntry has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        nft_owner: address,
        staked_at_epoch: u64,
        last_claimed_epoch: u64,
        stake_pool_id: 0x2::object::ID,
        url: 0x1::option::Option<0x2::url::Url>,
    }

    public entry fun create_stake_pool<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::StakePool<T0>>(0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::create_stake_pool<T0>(arg0, 0x1::type_name::get<T1>(), 0x2::tx_context::sender(arg6), arg1, arg2, arg3, arg4, arg5, 1, arg6));
    }

    public entry fun claim<T0>(arg0: &mut StakeEntry, arg1: &mut 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::StakePool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.nft_owner, 1);
        assert!(0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::id<T0>(arg1) == arg0.stake_pool_id, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_claimed_epoch = v1;
        0x2::coin::mint_and_transfer<T0>(0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::treasury_cap_<T0>(arg1), rewards_since_last_claim(v1, arg0.last_claimed_epoch, 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::reward_rate<T0>(arg1)), v0, arg3);
    }

    public fun create_stake_entry(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : StakeEntry {
        StakeEntry{
            id                 : 0x2::object::new(arg5),
            nft_id             : arg0,
            nft_owner          : arg1,
            staked_at_epoch    : arg2,
            last_claimed_epoch : arg3,
            stake_pool_id      : arg4,
            url                : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://QmY4MFz7WiFQH8DehNixY42JomCiA9yVoRZBvXRhbmg5yP"))),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Fees{
            id              : 0x2::object::new(arg0),
            fee_collector_1 : @0x8b8e72597359f8404a58a950bc471a923cc10312912c247cfb60794c9716f563,
            fee_collector_2 : @0x8b8e72597359f8404a58a950bc471a923cc10312912c247cfb60794c9716f563,
            unstake_fee_1   : 5,
            unstake_fee_2   : 5,
            claim_fee_1     : 5,
            claim_fee_2     : 5,
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            fee_id : 0x2::object::id<Fees>(&v0),
        };
        0x2::transfer::public_share_object<Fees>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun redeem_and_destroy_stake_entry<T0>(arg0: StakeEntry, arg1: &mut 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::StakePool<T0>, arg2: &mut 0x2::kiosk::Kiosk) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg2, arg0.nft_id, 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::uid<T0>(arg1));
        let StakeEntry {
            id                 : v0,
            nft_id             : _,
            nft_owner          : _,
            staked_at_epoch    : _,
            last_claimed_epoch : _,
            stake_pool_id      : _,
            url                : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun rewards_since_last_claim(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (arg0 - arg1) * arg2
    }

    public entry fun stake<T0: store + key, T1>(arg0: 0x2::object::ID, arg1: &mut 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::StakePool<T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::nft_type<T1>(arg1) == 0x1::type_name::get<T0>(), 2);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T0>(arg2, arg0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg2, arg0, 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::uid<T1>(arg1), arg4);
        0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::increment_staked_nfts_<T1>(arg1);
        0x2::transfer::transfer<StakeEntry>(create_stake_entry(arg0, v0, 0x2::clock::timestamp_ms(arg3), 0x2::clock::timestamp_ms(arg3), 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::id<T1>(arg1), arg4), v0);
    }

    public entry fun unstake<T0>(arg0: StakeEntry, arg1: &mut 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::StakePool<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.nft_owner, 1);
        assert!(0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::id<T0>(arg1) == arg0.stake_pool_id, 2);
        let v0 = &mut arg0;
        claim<T0>(v0, arg1, arg3, arg4);
        redeem_and_destroy_stake_entry<T0>(arg0, arg1, arg2);
        0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_pool::decrement_staked_nfts_<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

