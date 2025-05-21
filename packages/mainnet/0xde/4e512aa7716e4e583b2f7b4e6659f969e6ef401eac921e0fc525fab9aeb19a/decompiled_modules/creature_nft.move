module 0xde4e512aa7716e4e583b2f7b4e6659f969e6ef401eac921e0fc525fab9aeb19a::creature_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct EventStatus has copy, drop, store {
        active: bool,
        start_time: u64,
        duration: u64,
        reward_rate: u64,
    }

    struct BrainrotCollection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        staked_universe: u64,
        staked_sky: u64,
        staked_seabed: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fee_bps: u16,
        duplicate_recipe_fee: u64,
        recipes: 0x2::table::Table<vector<u8>, address>,
        universe_event: EventStatus,
        sky_event: EventStatus,
        seabed_event: EventStatus,
        pending_rewards: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct CreatureNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        style: 0x1::string::String,
        elements: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        recipe_hash: vector<u8>,
        image_uri: 0x1::string::String,
        creator: address,
        created_at: u64,
    }

    struct StakeInfo has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner: address,
        environment: u8,
        stake_time: u64,
        last_reward_time: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTStaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        environment: u8,
        stake_time: u64,
    }

    struct NFTUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        environment: u8,
        total_staked_time: u64,
    }

    struct RewardClaimed has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventStarted has copy, drop {
        environment: u8,
        start_time: u64,
        duration: u64,
        reward_rate: u64,
    }

    struct EventEnded has copy, drop {
        environment: u8,
        total_duration: u64,
    }

    public entry fun add_treasury_funds(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    fun calculate_and_accumulate_rewards(arg0: &mut BrainrotCollection, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: u64) {
        assert!(arg4 > arg1, 3);
        let v0 = get_event_status(arg0, arg3);
        assert!(v0.active, 4);
        let v1 = max(arg1, v0.start_time);
        let v2 = min(arg4, v0.start_time + v0.duration);
        assert!(v2 > v1, 5);
        let v3 = v2 - v1;
        let v4 = v3 % 86400000;
        let v5 = v0.reward_rate * v3 / 86400000;
        let v6 = v5;
        if (v4 > 0) {
            v6 = v5 + v0.reward_rate * v4 / 86400000;
        };
        if (v6 > 0) {
            if (0x2::table::contains<0x2::object::ID, u64>(&arg0.pending_rewards, arg2)) {
                let v7 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.pending_rewards, arg2);
                *v7 = *v7 + v6;
            } else {
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.pending_rewards, arg2, v6);
            };
        };
    }

    public fun calculate_recipe_hash(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : vector<u8> {
        0x1::hash::sha2_256(serialize_recipe_data(arg0, arg1, arg2))
    }

    public fun check_recipe(arg0: &BrainrotCollection, arg1: &vector<u8>) : (bool, address) {
        if (0x2::table::contains<vector<u8>, address>(&arg0.recipes, *arg1)) {
            (true, *0x2::table::borrow<vector<u8>, address>(&arg0.recipes, *arg1))
        } else {
            (false, @0x0)
        }
    }

    public fun claim_rewards(arg0: &mut BrainrotCollection, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0x2::object::id<StakeInfo>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        calculate_and_accumulate_rewards(arg0, arg1.last_reward_time, v0, arg1.environment, v1);
        arg1.last_reward_time = v1;
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.pending_rewards, v0), 6);
        let v2 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.pending_rewards, v0);
        assert!(v2 > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= v2, 6);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.pending_rewards, v0);
        let v3 = RewardClaimed{
            owner  : arg1.owner,
            nft_id : arg1.nft_id,
            amount : v2,
        };
        0x2::event::emit<RewardClaimed>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v2), arg3)
    }

    public entry fun claim_staking_rewards(arg0: &mut BrainrotCollection, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun end_event(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 9);
        let v1 = get_event_status_mut(arg1, arg2);
        assert!(v1.active, 7);
        let v2 = 0x2::clock::timestamp_ms(arg3) - v1.start_time;
        v1.duration = v2;
        v1.active = false;
        let v3 = EventEnded{
            environment    : arg2,
            total_duration : v2,
        };
        0x2::event::emit<EventEnded>(v3);
    }

    fun get_event_status(arg0: &BrainrotCollection, arg1: u8) : &EventStatus {
        if (arg1 == 0) {
            &arg0.universe_event
        } else if (arg1 == 1) {
            &arg0.sky_event
        } else {
            &arg0.seabed_event
        }
    }

    fun get_event_status_mut(arg0: &mut BrainrotCollection, arg1: u8) : &mut EventStatus {
        if (arg1 == 0) {
            &mut arg0.universe_event
        } else if (arg1 == 1) {
            &mut arg0.sky_event
        } else {
            &mut arg0.seabed_event
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = EventStatus{
            active      : false,
            start_time  : 0,
            duration    : 0,
            reward_rate : 600000000,
        };
        let v2 = EventStatus{
            active      : false,
            start_time  : 0,
            duration    : 0,
            reward_rate : 200000000,
        };
        let v3 = EventStatus{
            active      : false,
            start_time  : 0,
            duration    : 0,
            reward_rate : 100000000,
        };
        let v4 = BrainrotCollection{
            id                   : 0x2::object::new(arg0),
            minted_count         : 0,
            staked_universe      : 0,
            staked_sky           : 0,
            staked_seabed        : 0,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fee_bps      : 250,
            duplicate_recipe_fee : 10000000,
            recipes              : 0x2::table::new<vector<u8>, address>(arg0),
            universe_event       : v1,
            sky_event            : v2,
            seabed_event         : v3,
            pending_rewards      : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::share_object<BrainrotCollection>(v4);
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun mint_creature_nft(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        if (0x1::string::length(&arg4) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"head"), arg4);
        };
        if (0x1::string::length(&arg5) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"head_accessory"), arg5);
        };
        if (0x1::string::length(&arg6) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"body"), arg6);
        };
        if (0x1::string::length(&arg7) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"hand"), arg7);
        };
        if (0x1::string::length(&arg8) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"leg"), arg8);
        };
        if (0x1::string::length(&arg9) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"environment"), arg9);
        };
        0x2::transfer::public_transfer<CreatureNFT>(mint_nft(arg1, arg2, arg3, v0, arg10, arg11, arg13, arg14), arg12);
    }

    public fun mint_nft(arg0: &mut BrainrotCollection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: 0x1::string::String, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : CreatureNFT {
        let v0 = calculate_recipe_hash(&arg1, &arg2, &arg3);
        let (v1, v2) = check_recipe(arg0, &v0);
        if (v1) {
            let v3 = arg0.duplicate_recipe_fee;
            assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v3, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v3, arg7), v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, 0x2::coin::value<0x2::sui::SUI>(arg5), arg7), @0xce1b022dd5633fae11efabc9a48c871637b66c2f3e608929cf8fd4ba7683e205);
            0x2::table::add<vector<u8>, address>(&mut arg0.recipes, v0, 0x2::tx_context::sender(arg7));
        };
        let v4 = CreatureNFT{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            style       : arg2,
            elements    : arg3,
            recipe_hash : v0,
            image_uri   : arg4,
            creator     : 0x2::tx_context::sender(arg7),
            created_at  : 0x2::clock::timestamp_ms(arg6),
        };
        arg0.minted_count = arg0.minted_count + 1;
        let v5 = NFTMinted{
            nft_id  : 0x2::object::id<CreatureNFT>(&v4),
            name    : v4.name,
            creator : v4.creator,
        };
        0x2::event::emit<NFTMinted>(v5);
        v4
    }

    fun serialize_recipe_data(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, 0);
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(&v1, v2);
            0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(v3));
            0x1::vector::push_back<u8>(&mut v0, 0);
            0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg2, v3)));
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun stake_creature_nft(arg0: &mut BrainrotCollection, arg1: CreatureNFT, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake_nft(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<StakeInfo>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun stake_nft(arg0: &mut BrainrotCollection, arg1: CreatureNFT, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakeInfo {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0);
        let v1 = 0x2::object::id<CreatureNFT>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = StakeInfo{
            id               : 0x2::object::new(arg4),
            nft_id           : v1,
            owner            : 0x2::tx_context::sender(arg4),
            environment      : arg2,
            stake_time       : v2,
            last_reward_time : v2,
        };
        if (arg2 == 0) {
            arg0.staked_universe = arg0.staked_universe + 1;
        } else if (arg2 == 1) {
            arg0.staked_sky = arg0.staked_sky + 1;
        } else if (arg2 == 2) {
            arg0.staked_seabed = arg0.staked_seabed + 1;
        };
        let v4 = NFTStaked{
            nft_id      : v1,
            owner       : 0x2::tx_context::sender(arg4),
            environment : arg2,
            stake_time  : v2,
        };
        0x2::event::emit<NFTStaked>(v4);
        0x2::transfer::public_freeze_object<CreatureNFT>(arg1);
        v3
    }

    public entry fun start_event(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 9);
        let v1 = get_event_status_mut(arg1, arg2);
        assert!(!v1.active, 8);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = arg3 * 86400000;
        v1.active = true;
        v1.start_time = v2;
        v1.duration = v3;
        v1.reward_rate = arg4;
        let v4 = EventStarted{
            environment : arg2,
            start_time  : v2,
            duration    : v3,
            reward_rate : arg4,
        };
        0x2::event::emit<EventStarted>(v4);
    }

    public entry fun unstake_creature_nft(arg0: &mut BrainrotCollection, arg1: StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        unstake_nft(arg0, arg1, arg2, arg3);
    }

    public fun unstake_nft(arg0: &mut BrainrotCollection, arg1: StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = arg1.environment;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v0 == 0) {
            arg0.staked_universe = arg0.staked_universe - 1;
        } else if (v0 == 1) {
            arg0.staked_sky = arg0.staked_sky - 1;
        } else if (v0 == 2) {
            arg0.staked_seabed = arg0.staked_seabed - 1;
        };
        calculate_and_accumulate_rewards(arg0, arg1.last_reward_time, 0x2::object::id<StakeInfo>(&arg1), v0, v1);
        let v2 = NFTUnstaked{
            nft_id            : arg1.nft_id,
            owner             : 0x2::tx_context::sender(arg3),
            environment       : v0,
            total_staked_time : v1 - arg1.stake_time,
        };
        0x2::event::emit<NFTUnstaked>(v2);
        let StakeInfo {
            id               : v3,
            nft_id           : _,
            owner            : _,
            environment      : _,
            stake_time       : _,
            last_reward_time : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    public entry fun update_creator_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u16) {
        assert!(arg2 <= 10000, 0);
        arg1.creator_fee_bps = arg2;
    }

    public entry fun update_duplicate_recipe_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u64) {
        arg1.duplicate_recipe_fee = arg2;
    }

    public entry fun update_reward_rate(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: u64) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0);
        get_event_status_mut(arg1, arg2).reward_rate = arg3;
    }

    // decompiled from Move bytecode v6
}

