module 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird {
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
        type: u8,
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

    struct BirdVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    public fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg4: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::checkVersion(arg4, 1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8001);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verUpdatePreyPegNonce(v2, arg3);
        let v3 = ClaimPreyRewardEvent{
            owner   : v0,
            hunt_id : 0x2::bcs::peel_u128(&mut v1),
            nonce   : v2,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v3);
    }

    public fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x523e1172f88696b89adba7768fefaaad118ec8b4c41707a04793487e556cbf74::nft::BirdNFT, arg3: &mut BirdVault, arg4: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg5: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::checkVersion(arg5, 1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verifySignature(arg0, arg1, &arg3.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_address(&mut v0);
        let v4 = 0x2::tx_context::sender(arg6);
        assert!(v4 == 0x2::bcs::peel_address(&mut v0), 8001);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verUpdatePreyPegNonce(v2, arg4);
        assert!(v1 > 0, 8003);
        assert!(0x2::object::id_address<0x523e1172f88696b89adba7768fefaaad118ec8b4c41707a04793487e556cbf74::nft::BirdNFT>(&arg2) == v3, 8004);
        0x523e1172f88696b89adba7768fefaaad118ec8b4c41707a04793487e556cbf74::nft::burn(arg2, arg6);
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
        };
        0x2::transfer::share_object<BirdVault>(v1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::cap_vault::createVault<AdminCap>(arg1);
    }

    public fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg4: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::checkVersion(arg4, 1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u128(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u64(&mut v0);
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        let v5 = 0x2::tx_context::sender(arg5);
        assert!(v5 == 0x2::bcs::peel_address(&mut v0), 8001);
        assert!(v3 > 0 && v4 > 0, 8002);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verUpdatePreyPegNonce(v1, arg3);
        assert!(v2 > 0, 8003);
        let v6 = PreyBirdEvent{
            owner      : v5,
            id         : 0,
            power      : v2,
            type       : 0x2::bcs::peel_u8(&mut v0),
            block_time : v3,
            reward     : v4,
            hunt_id    : 0x2::bcs::peel_u128(&mut v0),
            nonce      : v1,
        };
        0x2::event::emit<PreyBirdEvent>(v6);
    }

    public fun updateValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

