module 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird {
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
    }

    struct ClaimPreyRewardEvent has copy, drop {
        owner: address,
        hunt_id: u128,
        nonce: u128,
    }

    struct BirdGhost has drop, store {
        amount: u64,
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

    struct BirdArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        bird: BirdGhost,
        nonce: u128,
        bird_nft: 0x1::option::Option<NFTLite>,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct BirdReg has store, key {
        id: 0x2::object::UID,
        egg_regs: 0x2::table::Table<address, bool>,
    }

    fun addBird(arg0: &mut BirdArchieve, arg1: NFTLite) {
        assert!(!exist_bird(arg0), 8007);
        0x1::option::fill<NFTLite>(&mut arg0.bird_nft, arg1);
    }

    fun borrowBirdMut(arg0: &mut BirdArchieve) : &mut NFTLite {
        0x1::option::borrow_mut<NFTLite>(&mut arg0.bird_nft)
    }

    public fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::checkVersion(arg5, 1);
        verifySignature(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 8001);
        assert!(v2 > arg3.nonce, 8003);
        arg3.nonce = v2;
        arg3.last_time = 0x2::clock::timestamp_ms(arg4);
        let v3 = ClaimPreyRewardEvent{
            owner   : v0,
            hunt_id : 0x2::bcs::peel_u128(&mut v1),
            nonce   : v2,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v3);
    }

    fun exist_bird(arg0: &BirdArchieve) : bool {
        0x1::option::is_some<NFTLite>(&arg0.bird_nft)
    }

    public fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::BirdNFT, arg3: &mut BirdStore, arg4: &mut BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::checkVersion(arg6, 1);
        verifySignature(arg0, arg1, arg3);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_address(&mut v0);
        let v4 = 0x2::tx_context::sender(arg7);
        assert!(v4 == 0x2::bcs::peel_address(&mut v0), 8001);
        assert!(v2 > arg4.nonce, 8003);
        assert!(v1 > 0, 8006);
        assert!(0x2::object::id_address<0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::BirdNFT>(&arg2) == v3, 8008);
        arg4.nonce = v2;
        arg4.last_time = 0x2::clock::timestamp_ms(arg5);
        0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::burn(arg2, arg7);
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

    public fun infoBirdGhost(arg0: &BirdArchieve) : (address, u64, u128) {
        (arg0.owner, arg0.bird.amount, arg0.nonce)
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = BirdStore{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<BirdStore>(v1);
        let v2 = BirdReg{
            id       : 0x2::object::new(arg1),
            egg_regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<BirdReg>(v2);
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::createVault<AdminCap>(arg1);
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::createVault<0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::VAdminCap>(arg1);
    }

    public fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::checkVersion(arg5, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        verifySignature(arg0, arg1, arg2);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        let v6 = 0x2::tx_context::sender(arg6);
        assert!(v6 == 0x2::bcs::peel_address(&mut v1), 8001);
        assert!(v2 > arg3.nonce, 8003);
        assert!(v4 > 0 && v5 > 0, 8002);
        assert!(v3 > 0, 8006);
        if (!exist_bird(arg3)) {
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
            addBird(arg3, v7);
        } else {
            let v8 = borrowBirdMut(arg3);
            if (!v8.preying) {
                v8.preying = true;
                v8.power = v3;
                v8.prey_reward = v5;
                v8.prey_unblock_at = v0 + v4;
                v8.last_time = v0;
            } else {
                claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
                let v9 = borrowBirdMut(arg3);
                v9.preying = true;
                v9.power = v3;
                v9.prey_reward = v5;
                v9.prey_unblock_at = v0 + v4;
                v9.last_time = v0;
            };
        };
        arg3.nonce = v2;
        arg3.last_time = v0;
        let v10 = PreyBirdEvent{
            owner      : v6,
            id         : 0,
            power      : v3,
            block_time : v4,
            reward     : v5,
            hunt_id    : 0x2::bcs::peel_u128(&mut v1),
        };
        0x2::event::emit<PreyBirdEvent>(v10);
    }

    public fun register(arg0: &mut BirdReg, arg1: &0x2::clock::Clock, arg2: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.egg_regs, v0), 8004);
        let v1 = BirdGhost{amount: 0};
        let v2 = BirdArchieve{
            id        : 0x2::object::new(arg3),
            owner     : v0,
            last_time : 0x2::clock::timestamp_ms(arg1),
            bird      : v1,
            nonce     : 0,
            bird_nft  : 0x1::option::none<NFTLite>(),
        };
        0x2::transfer::public_transfer<BirdArchieve>(v2, v0);
        0x2::table::add<address, bool>(&mut arg0.egg_regs, v0, true);
    }

    public fun updateValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &BirdStore) {
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8005);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
    }

    // decompiled from Move bytecode v6
}

