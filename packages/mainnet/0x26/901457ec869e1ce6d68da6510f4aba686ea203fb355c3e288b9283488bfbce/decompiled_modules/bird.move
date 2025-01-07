module 0x26901457ec869e1ce6d68da6510f4aba686ea203fb355c3e288b9283488bfbce::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeedWormEvent has copy, drop {
        owner: address,
        bird_id: u64,
        power: u64,
        req_id: u128,
        nonce: u128,
        worm_id: address,
    }

    struct PreyBirdEvent has copy, drop {
        owner: address,
        id: u64,
        power: u64,
        block_time: u64,
        reward: u64,
        hunt_id: u128,
        nonce: u128,
    }

    struct ClaimPreyRewardEvent has copy, drop {
        owner: address,
        hunt_id: u128,
        nonce: u128,
    }

    struct NFTLite has drop, store {
        nft_type: u8,
        id: u64,
        mint_time: u64,
        last_time: u64,
        type: u8,
        power: u64,
        preying: bool,
        prey_reward: u64,
        prey_unblock_at: u64,
    }

    struct BirdVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
        bird_nft: 0x1::option::Option<NFTLite>,
    }

    fun addBird(arg0: &mut BirdVault, arg1: NFTLite) {
        assert!(!exist_bird(arg0), 8007);
        0x1::option::fill<NFTLite>(&mut arg0.bird_nft, arg1);
    }

    fun borrowBirdMut(arg0: &mut BirdVault) : &mut NFTLite {
        0x1::option::borrow_mut<NFTLite>(&mut arg0.bird_nft)
    }

    public fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg4: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::checkVersion(arg4, 1);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8001);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verUpdateNftPegNonce(v2, arg3);
        let v3 = ClaimPreyRewardEvent{
            owner   : v0,
            hunt_id : 0x2::bcs::peel_u128(&mut v1),
            nonce   : v2,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v3);
    }

    fun exist_bird(arg0: &BirdVault) : bool {
        0x1::option::is_some<NFTLite>(&arg0.bird_nft)
    }

    public fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::BirdNFT, arg3: &mut BirdVault, arg4: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::checkVersion(arg5, 1);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verifySignature(arg0, arg1, &arg3.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_address(&mut v0);
        let v4 = 0x2::tx_context::sender(arg6);
        assert!(v4 == 0x2::bcs::peel_address(&mut v0), 8001);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verUpdateNftPegNonce(v2, arg4);
        assert!(v1 > 0, 8006);
        assert!(0x2::object::id_address<0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::BirdNFT>(&arg2) == v3, 8008);
        0xe5f460bcf985c3756ea96a7a8ee4921500053c032afee2ffe99f3d286fb3def2::nft::burn(arg2, arg6);
        let v5 = FeedWormEvent{
            owner   : v4,
            bird_id : 0x2::bcs::peel_u64(&mut v0),
            power   : v1,
            req_id  : 0x2::bcs::peel_u128(&mut v0),
            nonce   : v2,
            worm_id : v3,
        };
        0x2::event::emit<FeedWormEvent>(v5);
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = BirdVault{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
            bird_nft  : 0x1::option::none<NFTLite>(),
        };
        0x2::transfer::share_object<BirdVault>(v1);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault::createVault<AdminCap>(arg1);
    }

    public fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::UserArchieve, arg4: &0x2::clock::Clock, arg5: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::checkVersion(arg5, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        let v6 = 0x2::tx_context::sender(arg6);
        assert!(v6 == 0x2::bcs::peel_address(&mut v1), 8001);
        assert!(v4 > 0 && v5 > 0, 8002);
        assert!(v3 > 0, 8006);
        if (!exist_bird(arg2)) {
            let v7 = NFTLite{
                nft_type        : 1,
                id              : 0,
                mint_time       : v0,
                last_time       : v0,
                type            : 0x2::bcs::peel_u8(&mut v1),
                power           : v3,
                preying         : true,
                prey_reward     : v5,
                prey_unblock_at : v0 + v4,
            };
            addBird(arg2, v7);
            0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve::verUpdateNftPegNonce(v2, arg3);
        } else {
            let v8 = borrowBirdMut(arg2);
            if (!v8.preying) {
                v8.preying = true;
                v8.power = v3;
                v8.prey_reward = v5;
                v8.prey_unblock_at = v0 + v4;
                v8.last_time = v0;
            } else {
                claimPreyReward(arg0, arg1, arg2, arg3, arg5, arg6);
                let v9 = borrowBirdMut(arg2);
                v9.preying = true;
                v9.power = v3;
                v9.prey_reward = v5;
                v9.prey_unblock_at = v0 + v4;
                v9.last_time = v0;
            };
        };
        let v10 = PreyBirdEvent{
            owner      : v6,
            id         : 0,
            power      : v3,
            block_time : v4,
            reward     : v5,
            hunt_id    : 0x2::bcs::peel_u128(&mut v1),
            nonce      : v2,
        };
        0x2::event::emit<PreyBirdEvent>(v10);
    }

    public fun updateValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::Version) {
        0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

