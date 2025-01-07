module 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardClaimedEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
        nonce: u128,
    }

    struct RewardDepositEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardEmergencyWithdrawEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        active: bool,
        coins: 0x2::coin::Coin<T0>,
        reward_limit: u64,
    }

    struct BirdMineEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
        type: u8,
    }

    struct NftMineEvent has copy, drop {
        owner: address,
        nft_type: u8,
        id_ext: vector<u8>,
        timestamp: u64,
        type: u8,
        value: u64,
    }

    struct FeedBirdEvent has copy, drop {
        owner: address,
        worm_id: vector<u8>,
        bird_id: vector<u8>,
        power: u64,
    }

    struct PreyBirdEvent has copy, drop {
        owner: address,
        bird_id: vector<u8>,
        power_loss: u64,
        block_time: u64,
        reward: u64,
    }

    struct ClaimReferallRewardEvent has copy, drop {
        owner: address,
        reward: u64,
    }

    struct ClaimPreyRewardEvent has copy, drop {
        owner: address,
        bird_id: vector<u8>,
        reward: u64,
    }

    struct BirdGhost has drop, store {
        amount: u64,
    }

    struct NFTGhost has store, key {
        id: 0x2::object::UID,
        nft_type: u8,
        id_ext: vector<u8>,
        mint_time: u64,
        last_time: u64,
        type: u8,
        value: u64,
        preying: bool,
        prey_reward: u64,
        prey_unblock_at: u64,
    }

    struct BirdArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        bird: BirdGhost,
        nonce: u128,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct BirdReg has store, key {
        id: 0x2::object::UID,
        egg_regs: 0x2::table::Table<address, bool>,
    }

    struct MineBird {
        type: u8,
        owner: address,
        amount: u64,
        nonce: u128,
    }

    struct MineNFT has drop, store {
        owner: address,
        nft_type: u8,
        id_ext: vector<u8>,
        type: u8,
        value: u64,
        nonce: u128,
    }

    struct UserReward has drop, store {
        owner: address,
        pool: address,
        amount: u64,
        nonce: u128,
    }

    struct PreyBird has copy, store {
        owner: address,
        power_loss: u64,
        block_time: u64,
        reward: u64,
        nonce: u128,
    }

    struct ReferallReward has copy, store {
        owner: address,
        reward: u64,
        nonce: u128,
    }

    public fun burnNft(arg0: NFTGhost) {
        let NFTGhost {
            id              : v0,
            nft_type        : _,
            id_ext          : _,
            mint_time       : _,
            last_time       : _,
            type            : _,
            value           : _,
            preying         : _,
            prey_reward     : _,
            prey_unblock_at : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun claimPreyReward(arg0: &mut NFTGhost, arg1: &mut BirdArchieve, arg2: &0x2::clock::Clock, arg3: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg3, 1);
        assert!(arg0.nft_type == 1, 8011);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.preying && arg0.prey_unblock_at <= v0, 8013);
        arg1.bird.amount = arg1.bird.amount + arg0.prey_reward;
        arg1.last_time = v0;
        arg0.preying = false;
        arg0.prey_reward = 0;
        arg0.prey_unblock_at = 0;
        arg0.last_time = v0;
        let v1 = ClaimPreyRewardEvent{
            owner   : 0x2::tx_context::sender(arg4),
            bird_id : arg0.id_ext,
            reward  : arg0.prey_reward,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v1);
    }

    public fun claimReferallReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg5, 1);
        verifySignature(arg0, arg1, arg2);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::tx_context::sender(arg6);
        assert!(v3 == 0x2::bcs::peel_address(&mut v0), 8001);
        assert!(v2 > arg3.nonce, 8003);
        arg3.nonce = v2;
        arg3.last_time = 0x2::clock::timestamp_ms(arg4);
        arg3.bird.amount = arg3.bird.amount + v1;
        let v4 = ClaimReferallRewardEvent{
            owner  : v3,
            reward : v1,
        };
        0x2::event::emit<ClaimReferallRewardEvent>(v4);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut RewardPool<T0>, arg3: &mut BirdStore, arg4: &mut BirdArchieve, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg5, 1);
        assert!(arg2.active, 8006);
        verifySignature(arg0, arg1, arg3);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(0x2::tx_context::sender(arg7) == v1, 8001);
        assert!(0x2::object::id_address<RewardPool<T0>>(arg2) == 0x2::bcs::peel_address(&mut v0), 8008);
        assert!(v3 > arg4.nonce, 8003);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg2.reward_limit == 0 || arg2.reward_limit >= v2, 8007);
        arg4.nonce = v3;
        arg4.last_time = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.coins, v2, arg7), v1);
        let v5 = RewardClaimedEvent{
            owner     : v1,
            amount    : v2,
            timestamp : v4,
            nonce     : v3,
        };
        0x2::event::emit<RewardClaimedEvent>(v5);
    }

    public fun configRewardPool<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg4, 1);
        arg1.active = arg2;
        arg1.reward_limit = arg3;
    }

    public fun createRewardPool<T0>(arg0: &AdminCap, arg1: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg1, 1);
        let v0 = RewardPool<T0>{
            id           : 0x2::object::new(arg2),
            active       : true,
            coins        : 0x2::coin::zero<T0>(arg2),
            reward_limit : 0,
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg2, 1);
        0x2::coin::join<T0>(&mut arg1.coins, arg0);
        let v0 = RewardDepositEvent{
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<T0>(&arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardDepositEvent>(v0);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &TreasureCap, arg1: &mut RewardPool<T0>, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1.coins);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.coins, v1, arg4), v0);
        let v2 = RewardEmergencyWithdrawEvent{
            owner     : v0,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardEmergencyWithdrawEvent>(v2);
    }

    public fun feedBird(arg0: NFTGhost, arg1: &mut NFTGhost, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg2, 1);
        assert!(arg0.nft_type == 0 && arg1.nft_type == 1, 8011);
        let v0 = arg0.value;
        arg1.value = arg1.value + v0;
        arg1.last_time = 0x2::clock::timestamp_ms(arg3);
        burnNft(arg0);
        let v1 = FeedBirdEvent{
            owner   : 0x2::tx_context::sender(arg4),
            worm_id : arg0.id_ext,
            bird_id : arg1.id_ext,
            power   : v0,
        };
        0x2::event::emit<FeedBirdEvent>(v1);
    }

    public fun infoBirdGhost(arg0: &BirdArchieve) : (address, u64, u128) {
        (arg0.owner, arg0.bird.amount, arg0.nonce)
    }

    public fun infoNftGhost(arg0: &NFTGhost) : (u8, vector<u8>, u64, u8, u64) {
        (arg0.nft_type, arg0.id_ext, arg0.mint_time, arg0.type, arg0.value)
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = BirdStore{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<BirdStore>(v2);
        let v3 = BirdReg{
            id       : 0x2::object::new(arg1),
            egg_regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<BirdReg>(v3);
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::createVault<AdminCap>(arg1);
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::createVault<TreasureCap>(arg1);
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::createVault<0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::VAdminCap>(arg1);
    }

    public fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg5, 1);
        verifySignature(arg0, arg1, arg2);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        let v2 = 0x2::bcs::peel_address(&mut v0);
        let v3 = 0x2::bcs::peel_u64(&mut v0);
        let v4 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v1 <= 1, 8004);
        assert!(v4 > arg3.nonce, 8003);
        assert!(v2 == 0x2::tx_context::sender(arg6), 8001);
        assert!(v3 > 0, 8002);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        arg3.bird.amount = arg3.bird.amount + v3;
        arg3.nonce = v4;
        arg3.last_time = v5;
        let v6 = BirdMineEvent{
            owner     : v2,
            amount    : v3,
            timestamp : v5,
            type      : v1,
        };
        0x2::event::emit<BirdMineEvent>(v6);
    }

    public fun mineNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg5, 1);
        verifySignature(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::bcs::new(arg1);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_vec_u8(&mut v2);
        let v5 = 0x2::bcs::peel_u8(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x2::bcs::peel_u128(&mut v2);
        assert!(v3 >= 0 && v3 <= 1, 8004);
        assert!(v7 > arg3.nonce, 8003);
        assert!(0x2::bcs::peel_address(&mut v2) == v0, 8001);
        arg3.nonce = v7;
        arg3.last_time = v1;
        let v8 = NFTGhost{
            id              : 0x2::object::new(arg6),
            nft_type        : v3,
            id_ext          : v4,
            mint_time       : v1,
            last_time       : v1,
            type            : v5,
            value           : v6,
            preying         : false,
            prey_reward     : 0,
            prey_unblock_at : 0,
        };
        0x2::transfer::public_transfer<NFTGhost>(v8, v0);
        let v9 = NftMineEvent{
            owner     : v0,
            nft_type  : v3,
            id_ext    : v4,
            timestamp : v1,
            type      : v5,
            value     : v6,
        };
        0x2::event::emit<NftMineEvent>(v9);
    }

    public fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut NFTGhost, arg3: &mut BirdStore, arg4: &mut BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg6, 1);
        assert!(arg2.nft_type == 1, 8011);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(!arg2.preying || arg2.preying && arg2.prey_unblock_at <= v0, 8013);
        verifySignature(arg0, arg1, arg3);
        if (arg2.preying && arg2.prey_unblock_at <= v0) {
            claimPreyReward(arg2, arg4, arg5, arg6, arg7);
        };
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_u128(&mut v1);
        let v6 = 0x2::tx_context::sender(arg7);
        assert!(v6 == 0x2::bcs::peel_address(&mut v1), 8001);
        assert!(v5 > arg4.nonce, 8003);
        assert!(v3 > 0 && v4 > 0, 8002);
        assert!(v2 > 0 && arg2.value >= v2, 8012);
        arg4.nonce = v5;
        arg4.last_time = v0;
        arg2.preying = true;
        arg2.value = arg2.value - v2;
        arg2.prey_reward = v4;
        arg2.prey_unblock_at = v0 + v3;
        arg2.last_time = v0;
        let v7 = PreyBirdEvent{
            owner      : v6,
            bird_id    : arg2.id_ext,
            power_loss : v2,
            block_time : v3,
            reward     : v4,
        };
        0x2::event::emit<PreyBirdEvent>(v7);
    }

    public fun register(arg0: &mut BirdReg, arg1: &0x2::clock::Clock, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.egg_regs, v0), 8005);
        let v1 = BirdGhost{amount: 0};
        let v2 = BirdArchieve{
            id        : 0x2::object::new(arg3),
            owner     : v0,
            last_time : 0x2::clock::timestamp_ms(arg1),
            bird      : v1,
            nonce     : 0,
        };
        0x2::transfer::public_transfer<BirdArchieve>(v2, v0);
        0x2::table::add<address, bool>(&mut arg0.egg_regs, v0, true);
    }

    public fun sponsor_gas(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) > 0 && arg2 > 0 && 0x2::coin::value<0x2::sui::SUI>(&arg0) >= 0x1::vector::length<address>(&arg1) * arg2, 8009);
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun updateValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &BirdStore) {
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8010);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
    }

    // decompiled from Move bytecode v6
}

