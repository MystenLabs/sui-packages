module 0x6a51125921dc5f94096ff48bea86a8618ff185c3026f2c15b3e4a0409a0eef79::bird {
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

    public fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::UserArchieve, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg4, 2);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8001);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verUpdatePreyPegNonce(v2, arg3);
        let v3 = ClaimPreyRewardEvent{
            owner   : v0,
            hunt_id : 0x2::bcs::peel_u128(&mut v1),
            nonce   : v2,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v3);
    }

    public fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x9159bcb6c488cb6f5b1c08a5fe60aba8c8710b5ba1acef0d4d997f2933582394::nft::BirdNFT, arg3: &mut BirdVault, arg4: &mut 0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::UserArchieve, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg5, 2);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verifySignature(arg0, arg1, &arg3.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_address(&mut v0);
        let v4 = 0x2::tx_context::sender(arg6);
        assert!(v4 == 0x2::bcs::peel_address(&mut v0), 8001);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verUpdatePreyPegNonce(v2, arg4);
        assert!(v1 > 0, 8003);
        assert!(0x2::object::id_address<0x9159bcb6c488cb6f5b1c08a5fe60aba8c8710b5ba1acef0d4d997f2933582394::nft::BirdNFT>(&arg2) == v3, 8004);
        0x9159bcb6c488cb6f5b1c08a5fe60aba8c8710b5ba1acef0d4d997f2933582394::nft::burn(arg2, arg6);
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
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::cap_vault::createVault<AdminCap>(arg1);
    }

    public fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &mut 0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::UserArchieve, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg4, 2);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u128(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u64(&mut v0);
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        let v5 = 0x2::tx_context::sender(arg5);
        assert!(v5 == 0x2::bcs::peel_address(&mut v0), 8001);
        assert!(v3 > 0 && v4 > 0, 8002);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::archieve::verUpdatePreyPegNonce(v1, arg3);
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

    public fun updateValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut BirdVault, arg3: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg3, 2);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

