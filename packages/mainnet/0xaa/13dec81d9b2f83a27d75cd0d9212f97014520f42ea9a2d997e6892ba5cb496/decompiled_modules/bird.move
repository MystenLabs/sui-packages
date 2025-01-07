module 0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct BirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardTreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserReward has drop, store {
        owner: address,
        pool: address,
        amount: u64,
        nonce: u128,
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

    struct MineEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
        type: u8,
    }

    struct BirdGhost has drop, store {
        amount: u64,
        time: u64,
    }

    struct NFTGhost has store, key {
        id: 0x2::object::UID,
        nft_type: u8,
        id2: vector<u8>,
        mint_time: u64,
        type: u8,
        value: u64,
        ext: vector<u8>,
    }

    struct BirdArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        checkin: BirdGhost,
        break_egg: BirdGhost,
        prey: BirdGhost,
        nonce: u128,
    }

    struct BirdAction {
        type: u8,
        owner: address,
        amount: u64,
        nonce: u128,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        total_break: u128,
        total_checkin: u128,
        total_prey: u128,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct BirdReg has store, key {
        id: 0x2::object::UID,
        egg_regs: 0x2::table::Table<address, bool>,
    }

    fun breakEgg(arg0: &mut BirdStore, arg1: &mut BirdArchieve, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        arg0.total_break = arg0.total_break + (arg3 as u128);
        arg1.break_egg.amount = arg1.break_egg.amount + arg3;
        arg1.break_egg.time = arg4;
        let v0 = MineEvent{
            owner     : arg2,
            amount    : arg3,
            timestamp : arg4,
            type      : 0,
        };
        0x2::event::emit<MineEvent>(v0);
    }

    public fun burnNft(arg0: NFTGhost) {
        let NFTGhost {
            id        : v0,
            nft_type  : _,
            id2       : _,
            mint_time : _,
            type      : _,
            value     : _,
            ext       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun checkIn(arg0: &mut BirdStore, arg1: &mut BirdArchieve, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        arg0.total_checkin = arg0.total_checkin + (arg3 as u128);
        arg1.checkin.amount = arg1.checkin.amount + arg3;
        arg1.checkin.time = arg4;
        let v0 = MineEvent{
            owner     : arg2,
            amount    : arg3,
            timestamp : arg4,
            type      : 1,
        };
        0x2::event::emit<MineEvent>(v0);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut RewardPool<T0>, arg3: &mut BirdStore, arg4: &mut BirdArchieve, arg5: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg3.validator), 8000);
        assert!(arg2.active, 8009);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg3.validator), &arg1), 8000);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(0x2::tx_context::sender(arg7) == v1, 8001);
        assert!(0x2::object::id_address<RewardPool<T0>>(arg2) == 0x2::bcs::peel_address(&mut v0), 8011);
        assert!(v3 > arg4.nonce, 8003);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg2.reward_limit == 0 || arg2.reward_limit >= v2, 8010);
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

    public fun configRewardPool<T0>(arg0: &BirdAdminCap, arg1: &mut RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg4, 1);
        arg1.active = arg2;
        arg1.reward_limit = arg3;
    }

    public fun createRewardPool<T0>(arg0: &BirdAdminCap, arg1: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg1, 1);
        let v0 = RewardPool<T0>{
            id           : 0x2::object::new(arg2),
            active       : true,
            coins        : 0x2::coin::zero<T0>(arg2),
            reward_limit : 0,
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg2, 1);
        0x2::coin::join<T0>(&mut arg1.coins, arg0);
        let v0 = RewardDepositEvent{
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<T0>(&arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardDepositEvent>(v0);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &RewardTreasureCap, arg1: &mut RewardPool<T0>, arg2: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg2, 1);
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

    public fun infoBirdGhost(arg0: &BirdArchieve) : (u64, u64, u64) {
        (arg0.prey.amount, arg0.break_egg.amount, arg0.checkin.amount)
    }

    public fun infoNftGhost(arg0: &NFTGhost) : (u8, vector<u8>, u64, u8, u64, vector<u8>) {
        (arg0.nft_type, arg0.id2, arg0.mint_time, arg0.type, arg0.value, arg0.ext)
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BirdAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = RewardTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RewardTreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = BirdStore{
            id            : 0x2::object::new(arg1),
            total_break   : 0,
            total_checkin : 0,
            total_prey    : 0,
            validator     : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<BirdStore>(v2);
        let v3 = BirdReg{
            id       : 0x2::object::new(arg1),
            egg_regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<BirdReg>(v3);
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::cap_vault::createVault<BirdAdminCap>(arg1);
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::cap_vault::createVault<RewardTreasureCap>(arg1);
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::cap_vault::createVault<0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::VAdminCap>(arg1);
    }

    public fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8000);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_address(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v2 <= 2, 8004);
        assert!(v5 > arg3.nonce, 8003);
        assert!(v3 == 0x2::tx_context::sender(arg6), 8001);
        assert!(v4 > 0, 8002);
        arg3.nonce = v5;
        if (v2 == 1) {
            checkIn(arg2, arg3, v3, v4, v0, arg6);
        } else if (v2 == 0) {
            breakEgg(arg2, arg3, v3, v4, v0, arg6);
        } else if (v2 == 2) {
            preyBird(arg2, arg3, v3, v4, v0, arg6);
        };
        arg3.last_time = v0;
    }

    public fun mineNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8000);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
        let v2 = 0x2::bcs::new(arg1);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u128(&mut v2);
        assert!(v3 >= 0 && v3 <= 1, 8004);
        assert!(v5 > arg3.nonce, 8003);
        assert!(0x2::bcs::peel_address(&mut v2) == v0, 8001);
        arg3.nonce = v5;
        arg3.last_time = v1;
        let v6 = NFTGhost{
            id        : 0x2::object::new(arg6),
            nft_type  : v3,
            id2       : 0x2::bcs::peel_vec_u8(&mut v2),
            mint_time : v1,
            type      : 0x2::bcs::peel_u8(&mut v2),
            value     : v4,
            ext       : 0x2::bcs::peel_vec_u8(&mut v2),
        };
        0x2::transfer::public_transfer<NFTGhost>(v6, v0);
        let v7 = MineEvent{
            owner     : v0,
            amount    : v4,
            timestamp : v1,
            type      : v3,
        };
        0x2::event::emit<MineEvent>(v7);
    }

    fun preyBird(arg0: &mut BirdStore, arg1: &mut BirdArchieve, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        arg0.total_prey = arg0.total_prey + (arg3 as u128);
        arg1.prey.amount = arg1.prey.amount + arg3;
        arg1.prey.time = arg4;
        let v0 = MineEvent{
            owner     : arg2,
            amount    : arg3,
            timestamp : arg4,
            type      : 2,
        };
        0x2::event::emit<MineEvent>(v0);
    }

    public fun register(arg0: &mut BirdReg, arg1: &0x2::clock::Clock, arg2: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.egg_regs, v0), 8005);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = BirdGhost{
            amount : 0,
            time   : v1,
        };
        let v3 = BirdGhost{
            amount : 0,
            time   : v1,
        };
        let v4 = BirdGhost{
            amount : 0,
            time   : v1,
        };
        let v5 = BirdArchieve{
            id        : 0x2::object::new(arg3),
            owner     : v0,
            last_time : v1,
            checkin   : v2,
            break_egg : v3,
            prey      : v4,
            nonce     : 0,
        };
        0x2::transfer::public_transfer<BirdArchieve>(v5, v0);
        0x2::table::add<address, bool>(&mut arg0.egg_regs, v0, true);
    }

    public fun sponsor_gas(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) > 0 && arg2 > 0 && 0x2::coin::value<0x2::sui::SUI>(&arg0) >= 0x1::vector::length<address>(&arg1) * arg2, 8012);
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun update_validator(arg0: &BirdAdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::Version) {
        0xaa13dec81d9b2f83a27d75cd0d9212f97014520f42ea9a2d997e6892ba5cb496::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

