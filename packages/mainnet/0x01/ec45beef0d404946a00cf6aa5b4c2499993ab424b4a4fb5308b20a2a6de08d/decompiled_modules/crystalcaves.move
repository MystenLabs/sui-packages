module 0x1ec45beef0d404946a00cf6aa5b4c2499993ab424b4a4fb5308b20a2a6de08d::crystalcaves {
    struct InitGameCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GeneralConfig has store, key {
        id: 0x2::object::UID,
        powMode: u8,
        name: 0x1::string::String,
        sizeX: u16,
        sizeY: u16,
        maxEnergy: u32,
        energyResetTime: u64,
        startTime: u64,
        gameDuration: u64,
        trustedSigner: address,
    }

    struct DefogConfig has store, key {
        id: 0x2::object::UID,
        maxRounds: u32,
        repeatRounds: u32,
        thresholds: vector<u32>,
    }

    struct MiningConfig has store, key {
        id: 0x2::object::UID,
        blockDifficulties: vector<u8>,
        blockMiningTimes: vector<u16>,
    }

    struct RewardConfig has store, key {
        id: 0x2::object::UID,
        tokenAddress: address,
        dailyTotalMaxReward: u64,
        dailyUserMaxReward: u64,
        hourlyTotalMaxReward: u64,
        userMaxReward: u64,
        blockReward: vector<RewardLevel>,
    }

    struct RewardLevel has store, key {
        id: 0x2::object::UID,
        possibility: u32,
        minAmount: u64,
        maxAmount: u64,
    }

    struct GameConfig has store, key {
        id: 0x2::object::UID,
        general: GeneralConfig,
        defog: DefogConfig,
        mining: MiningConfig,
        reward: RewardConfig,
    }

    struct GameState has store, key {
        id: 0x2::object::UID,
        userCount: u32,
        totalMinedBlockCount: u32,
        totalMinedBlockTypeCounts: vector<u32>,
        hashKey: u256,
        currentDay: u64,
        currentHour: u64,
        currentDayTotalReward: u64,
        currentHourTotalReward: u64,
        totalReward: u64,
        remainingReward: u64,
        totalPending: u64,
        totalClaimed: u64,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        paused: bool,
        config: GameConfig,
        state: GameState,
        userStore: 0x2::table::Table<address, address>,
        pool: 0x2::balance::Balance<T0>,
    }

    struct UserState has store, key {
        id: 0x2::object::UID,
        initTime: u64,
        difficulty: u8,
        currentDepth: u32,
        currentDepthMinedBlockCount: u32,
        currentDepthInitBlockHash: u256,
        remainingEnergy: u32,
        minedBlockTypeCounts: vector<u32>,
        lastMineTime: u64,
        powSeed: u256,
        earnedReward: u64,
        currentBalance: u64,
        claimedReward: u64,
        lastEarnedDay: u64,
        currentDayEarnedReward: u64,
    }

    struct User has key {
        id: 0x2::object::UID,
        state: UserState,
        blocks: 0x2::table::Table<u256, bool>,
    }

    struct GameInited has copy, drop {
        gameID: address,
    }

    struct AdminGranted has copy, drop {
        adminAddress: address,
        adminCapID: address,
    }

    struct UserInited has copy, drop {
        userAddress: address,
        initTime: u64,
    }

    struct DepthUnlocked has copy, drop {
        userAddress: address,
        blockHash: u256,
        userDepth: u32,
        unlockTime: u64,
    }

    struct BlockMined has copy, drop {
        userAddress: address,
        blockHash: u256,
        blockType: u8,
        userDepth: u32,
        tokenAddress: address,
        tokenAmount: u64,
    }

    struct DifficultyUpdated has copy, drop {
        userAddress: address,
        newDifficulty: u8,
    }

    struct RewardClaimed has copy, drop {
        userAddress: address,
        tokenAddress: address,
        tokenAmount: u64,
    }

    fun bytes_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun claimReward<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state.earnedReward > 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg0.state.remainingReward + arg0.state.totalPending, 2);
        assert!(arg0.state.totalReward == arg0.state.remainingReward + arg0.state.totalPending + arg0.state.totalClaimed, 2);
        assert!(arg1.state.earnedReward == arg1.state.currentBalance + arg1.state.claimedReward, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pool, arg1.state.currentBalance, arg2), 0x2::tx_context::sender(arg2));
        let v0 = RewardClaimed{
            userAddress  : 0x2::tx_context::sender(arg2),
            tokenAddress : arg0.config.reward.tokenAddress,
            tokenAmount  : arg1.state.currentBalance,
        };
        0x2::event::emit<RewardClaimed>(v0);
        arg0.state.totalPending = arg0.state.totalPending - arg1.state.currentBalance;
        arg0.state.totalClaimed = arg0.state.totalClaimed + arg1.state.currentBalance;
        arg1.state.claimedReward = arg1.state.claimedReward + arg1.state.currentBalance;
        arg1.state.currentBalance = 0;
    }

    fun defogCheck<T0>(arg0: &Game<T0>, arg1: u256, arg2: u64, arg3: u8, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0 && arg3 == 1) {
            return
        };
        assert!(arg2 < (arg0.config.defog.maxRounds as u64), 16);
        let (v0, v1) = if (arg3 == 1) {
            (0 / (100 as u32), *0x1::vector::borrow<u32>(&arg0.config.defog.thresholds, (arg3 as u64) - 2) / (100 as u32) - 1)
        } else if (arg3 == 4) {
            (*0x1::vector::borrow<u32>(&arg0.config.defog.thresholds, (arg3 as u64) - 2) / (100 as u32), arg0.config.defog.maxRounds - 1)
        } else {
            (*0x1::vector::borrow<u32>(&arg0.config.defog.thresholds, (arg3 as u64) - 2) / (100 as u32), *0x1::vector::borrow<u32>(&arg0.config.defog.thresholds, (arg3 as u64) - 1) / (100 as u32) - 1)
        };
        let v2 = 0x2::random::new_generator(arg4, arg5);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, u256_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v3, u256_to_bytes(arg0.state.hashKey));
        0x1::vector::append<u8>(&mut v3, u256_to_bytes(((arg2 + 0x2::random::generate_u64(&mut v2) % (arg0.config.defog.repeatRounds as u64)) as u256)));
        let v4 = ((bytes_to_u256(0x2::hash::keccak256(&v3)) % (arg0.config.defog.maxRounds as u256)) as u32);
        assert!(v4 >= v0 && v4 <= v1, 16);
    }

    public fun depositToRewardPool<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64) {
        assert!(0x2::coin::value<T0>(&arg2) == arg3, 1);
        0x2::coin::put<T0>(&mut arg1.pool, arg2);
        arg1.state.totalReward = arg1.state.totalReward + arg3;
        arg1.state.remainingReward = arg1.state.remainingReward + arg3;
    }

    public fun emergencyWithdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun getBlockDifficulty<T0>(arg0: &Game<T0>, arg1: &User, arg2: u8) : u8 {
        if (arg2 >= 1 && arg2 <= 4) {
            return arg1.state.difficulty + *0x1::vector::borrow<u8>(&arg0.config.mining.blockDifficulties, (arg2 as u64) - 1)
        };
        0
    }

    public fun getBlockMineConfig<T0>(arg0: &Game<T0>, arg1: &User, arg2: u256, arg3: u8) : (bool, u256, u8) {
        (getBlockMined(arg1, arg2), arg1.state.powSeed, getBlockDifficulty<T0>(arg0, arg1, arg3))
    }

    public fun getBlockMined(arg0: &User, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.blocks, arg1) && *0x2::table::borrow<u256, bool>(&arg0.blocks, arg1)
    }

    public fun getBlocksMined(arg0: &User, arg1: vector<u256>) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, getBlockMined(arg0, *0x1::vector::borrow<u256>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun getCurrentRewardDay<T0>(arg0: &Game<T0>, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.config.general.startTime) / 86400000
    }

    public fun getCurrentRewardHour<T0>(arg0: &Game<T0>, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.config.general.startTime) / 3600000
    }

    public fun getGameEnded<T0>(arg0: &Game<T0>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.paused) {
            true
        } else if (0x2::clock::timestamp_ms(arg1) > arg0.config.general.startTime + arg0.config.general.gameDuration) {
            true
        } else {
            0x2::clock::timestamp_ms(arg1) < arg0.config.general.startTime
        }
    }

    public fun getGameInfo<T0>(arg0: &Game<T0>) : (0x1::string::String, u16, u16, u64, u64, u64, u32, u32, u32, u256) {
        (arg0.config.general.name, arg0.config.general.sizeX, arg0.config.general.sizeY, arg0.config.general.gameDuration, arg0.config.general.startTime, arg0.config.general.energyResetTime, arg0.config.general.maxEnergy, arg0.state.userCount, arg0.state.totalMinedBlockCount, arg0.state.hashKey)
    }

    public fun getUserObjectID<T0>(arg0: &Game<T0>, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.userStore, arg1)) {
            return *0x2::table::borrow<address, address>(&arg0.userStore, arg1)
        };
        @0x0
    }

    public fun getUserRemainingEnergy<T0>(arg0: &Game<T0>, arg1: &User, arg2: &0x2::clock::Clock) : u32 {
        if ((0x2::clock::timestamp_ms(arg2) - arg0.config.general.startTime) / arg0.config.general.energyResetTime > (arg1.state.lastMineTime - arg0.config.general.startTime) / arg0.config.general.energyResetTime) {
            return arg0.config.general.maxEnergy
        };
        arg1.state.remainingEnergy
    }

    fun get_address_from_public_key(arg0: &vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun grantAdminCap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = AdminGranted{
            adminAddress : arg1,
            adminCapID   : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<AdminGranted>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun grantReward<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: u8, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = getCurrentRewardDay<T0>(arg0, arg4);
        if (v0 > arg0.state.currentDay) {
            arg0.state.currentDay = v0;
            arg0.state.currentDayTotalReward = 0;
        };
        let v1 = getCurrentRewardHour<T0>(arg0, arg4);
        if (v1 > arg0.state.currentHour) {
            arg0.state.currentHour = v1;
            arg0.state.currentHourTotalReward = 0;
        };
        if (v0 > arg1.state.lastEarnedDay) {
            arg1.state.lastEarnedDay = v0;
            arg1.state.currentDayEarnedReward = 0;
        };
        let v2 = 0x2::random::new_generator(arg3, arg5);
        let v3 = 0x2::random::generate_u64(&mut v2);
        let v4 = 0;
        let v5 = 0x1::vector::borrow<RewardLevel>(&arg0.config.reward.blockReward, ((arg2 - 1) as u64));
        if (((v3 % (100000 as u64)) as u32) < v5.possibility) {
            v4 = v5.minAmount + v3 % (v5.maxAmount - v5.minAmount);
        };
        let v6 = arg0.state.remainingReward;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        if (arg0.config.reward.dailyTotalMaxReward > arg0.state.currentDayTotalReward) {
            v7 = arg0.config.reward.dailyTotalMaxReward - arg0.state.currentDayTotalReward;
        };
        if (arg0.config.reward.hourlyTotalMaxReward > arg0.state.currentHourTotalReward) {
            v8 = arg0.config.reward.hourlyTotalMaxReward - arg0.state.currentHourTotalReward;
        };
        if (arg0.config.reward.dailyUserMaxReward > arg1.state.currentDayEarnedReward) {
            v9 = arg0.config.reward.dailyUserMaxReward - arg1.state.currentDayEarnedReward;
        };
        if (arg0.config.reward.userMaxReward > arg1.state.earnedReward) {
            v10 = arg0.config.reward.userMaxReward - arg1.state.earnedReward;
        };
        if (v4 > v6) {
            v4 = v6;
        };
        if (v4 > v7) {
            v4 = v7;
        };
        if (v4 > v8) {
            v4 = v8;
        };
        if (v4 > v9) {
            v4 = v9;
        };
        if (v4 > v10) {
            v4 = v10;
        };
        arg1.state.currentBalance = arg1.state.currentBalance + v4;
        arg1.state.earnedReward = arg1.state.earnedReward + v4;
        arg1.state.currentDayEarnedReward = arg1.state.currentDayEarnedReward + v4;
        arg0.state.currentDayTotalReward = arg0.state.currentDayTotalReward + v4;
        arg0.state.currentHourTotalReward = arg0.state.currentHourTotalReward + v4;
        arg0.state.totalPending = arg0.state.totalPending + v4;
        arg0.state.remainingReward = arg0.state.remainingReward - v4;
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitGameCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitGameCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun initCheck<T0>(arg0: address, arg1: &Game<T0>, arg2: &0x2::clock::Clock) {
        assert!(!getGameEnded<T0>(arg1, arg2), 4);
        assert!(!0x2::table::contains<address, address>(&arg1.userStore, arg0), 5);
    }

    entry fun initGame<T0>(arg0: InitGameCap, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GeneralConfig{
            id              : 0x2::object::new(arg2),
            powMode         : 0,
            name            : 0x1::string::utf8(b""),
            sizeX           : 0,
            sizeY           : 0,
            maxEnergy       : 0,
            energyResetTime : 0,
            startTime       : 0,
            gameDuration    : 0,
            trustedSigner   : @0x0,
        };
        let v1 = DefogConfig{
            id           : 0x2::object::new(arg2),
            maxRounds    : 0,
            repeatRounds : 0,
            thresholds   : vector[0, 0, 0],
        };
        let v2 = MiningConfig{
            id                : 0x2::object::new(arg2),
            blockDifficulties : x"00000000",
            blockMiningTimes  : vector[0, 0, 0, 0],
        };
        let v3 = 0x1::vector::empty<RewardLevel>();
        let v4 = 0;
        while (v4 < 4) {
            let v5 = RewardLevel{
                id          : 0x2::object::new(arg2),
                possibility : 0,
                minAmount   : 0,
                maxAmount   : 0,
            };
            0x1::vector::push_back<RewardLevel>(&mut v3, v5);
            v4 = v4 + 1;
        };
        let v6 = RewardConfig{
            id                   : 0x2::object::new(arg2),
            tokenAddress         : @0x0,
            dailyTotalMaxReward  : 0,
            dailyUserMaxReward   : 0,
            hourlyTotalMaxReward : 0,
            userMaxReward        : 0,
            blockReward          : v3,
        };
        let v7 = GameConfig{
            id      : 0x2::object::new(arg2),
            general : v0,
            defog   : v1,
            mining  : v2,
            reward  : v6,
        };
        let v8 = GameState{
            id                        : 0x2::object::new(arg2),
            userCount                 : 0,
            totalMinedBlockCount      : 0,
            totalMinedBlockTypeCounts : vector[0, 0, 0, 0],
            hashKey                   : 0,
            currentDay                : 0,
            currentHour               : 0,
            currentDayTotalReward     : 0,
            currentHourTotalReward    : 0,
            totalReward               : 0,
            remainingReward           : 0,
            totalPending              : 0,
            totalClaimed              : 0,
        };
        let v9 = 0x2::random::new_generator(arg1, arg2);
        v8.hashKey = 0x2::random::generate_u256(&mut v9);
        let v10 = Game<T0>{
            id        : 0x2::object::new(arg2),
            paused    : true,
            config    : v7,
            state     : v8,
            userStore : 0x2::table::new<address, address>(arg2),
            pool      : 0x2::balance::zero<T0>(),
        };
        let v11 = GameInited{gameID: 0x2::object::uid_to_address(&v10.id)};
        0x2::event::emit<GameInited>(v11);
        0x2::transfer::share_object<Game<T0>>(v10);
        let v12 = AdminCap{id: 0x2::object::new(arg2)};
        let v13 = AdminGranted{
            adminAddress : 0x2::tx_context::sender(arg2),
            adminCapID   : 0x2::object::uid_to_address(&v12.id),
        };
        0x2::event::emit<AdminGranted>(v13);
        0x2::transfer::transfer<AdminCap>(v12, 0x2::tx_context::sender(arg2));
        let InitGameCap { id: v14 } = arg0;
        0x2::object::delete(v14);
    }

    entry fun initUser<T0>(arg0: &mut Game<T0>, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        initCheck<T0>(0x2::tx_context::sender(arg7), arg0, arg5);
        signatureCheck<T0>(arg0, arg2, arg3, arg4, arg7);
        let v0 = safeInit<T0>(arg0, arg5, arg7);
        let v1 = &mut v0;
        unlockDepth(v1, arg1, 0, arg5, arg6, arg7);
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg7));
    }

    fun mineBlock<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: u256, arg3: u256, arg4: u8, arg5: u64, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 1 && arg4 <= 4, 10);
        assert!(getBlockMined(arg1, arg3), 13);
        assert!(!getBlockMined(arg1, arg2), 12);
        defogCheck<T0>(arg0, arg2, arg5, arg4, arg7, arg9);
        if (arg0.config.general.powMode != 0) {
            powCheck(arg1.state.powSeed, arg2, arg6, getBlockDifficulty<T0>(arg0, arg1, arg4));
        };
        safeMineBlock<T0>(arg0, arg1, arg2, arg4, arg7, arg8, arg9);
    }

    fun mineBlocks<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: vector<u256>, arg3: vector<u256>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        mineCheck<T0>(0x2::tx_context::sender(arg9), arg0, arg8);
        let v0 = vector[0, 0, 0, 0];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg2)) {
            neighbourCheck<T0>(arg0, *0x1::vector::borrow<u256>(&arg2, v1), *0x1::vector::borrow<u256>(&arg3, v1));
            *0x1::vector::borrow_mut<u32>(&mut v0, ((*0x1::vector::borrow<u8>(&arg4, v1) - 1) as u64)) = *0x1::vector::borrow<u32>(&v0, ((*0x1::vector::borrow<u8>(&arg4, v1) - 1) as u64)) + 1;
            mineBlock<T0>(arg0, arg1, *0x1::vector::borrow<u256>(&arg2, v1), *0x1::vector::borrow<u256>(&arg3, v1), *0x1::vector::borrow<u8>(&arg4, v1), *0x1::vector::borrow<u64>(&arg5, v1), *0x1::vector::borrow<u64>(&arg6, v1), arg7, arg8, arg9);
            v1 = v1 + 1;
        };
        safeMineBlocksUpdate<T0>(arg1, arg0, v0, (0x1::vector::length<u256>(&arg2) as u32), arg7, arg8, arg9);
    }

    entry fun mineBlocksAndUnlockDepth<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: vector<u256>, arg3: vector<u256>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: u256, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(shouldUnlockDepth<T0>(arg0, arg1, 0x1::vector::length<u256>(&arg2)), 19);
        mineBlocks<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
        let v0 = arg1.state.currentDepth + 1;
        unlockDepth(arg1, arg7, v0, arg9, arg8, arg10);
    }

    entry fun mineBlocksOnly<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: vector<u256>, arg3: vector<u256>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!shouldUnlockDepth<T0>(arg0, arg1, 0x1::vector::length<u256>(&arg2)), 18);
        mineBlocks<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun mineCheck<T0>(arg0: address, arg1: &Game<T0>, arg2: &0x2::clock::Clock) {
        assert!(!getGameEnded<T0>(arg1, arg2), 4);
        assert!(0x2::table::contains<address, address>(&arg1.userStore, arg0), 6);
    }

    fun neighbourCheck<T0>(arg0: &Game<T0>, arg1: u256, arg2: u256) {
        let v0 = arg1 - arg0.state.hashKey;
        let v1 = arg2 - arg0.state.hashKey;
        let v2 = ((v0 & 65535) as u16);
        let v3 = ((v0 >> 16 & 65535) as u16);
        let v4 = ((v1 & 65535) as u16);
        let v5 = ((v1 >> 16 & 65535) as u16);
        assert!(v2 >= 0 && v2 < arg0.config.general.sizeX, 9);
        assert!(v3 >= 0 && v3 < arg0.config.general.sizeY, 9);
        assert!(v4 >= 0 && v4 < arg0.config.general.sizeX, 9);
        assert!(v5 >= 0 && v5 < arg0.config.general.sizeY, 9);
        assert!(((v0 >> 32) as u32) == ((v1 >> 32) as u32), 11);
        assert!(v2 == v4 && (v3 == v5 + 1 || v3 == v5 - 1) || v3 == v5 && (v2 == v4 + 1 || v2 == v4 - 1), 14);
    }

    fun powCheck(arg0: u256, arg1: u256, arg2: u64, arg3: u8) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, u256_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes((arg2 as u256)));
        assert!(bytes_to_u256(0x2::hash::keccak256(&v0)) & (1 << arg3) - 1 == 0, 15);
    }

    fun safeInit<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : User {
        let v0 = UserState{
            id                          : 0x2::object::new(arg2),
            initTime                    : 0,
            difficulty                  : 0,
            currentDepth                : 0,
            currentDepthMinedBlockCount : 0,
            currentDepthInitBlockHash   : 0,
            remainingEnergy             : arg0.config.general.maxEnergy,
            minedBlockTypeCounts        : vector[0, 0, 0, 0],
            lastMineTime                : 0,
            powSeed                     : 0,
            earnedReward                : 0,
            currentBalance              : 0,
            claimedReward               : 0,
            lastEarnedDay               : 0,
            currentDayEarnedReward      : 0,
        };
        let v1 = User{
            id     : 0x2::object::new(arg2),
            state  : v0,
            blocks : 0x2::table::new<u256, bool>(arg2),
        };
        let v2 = &mut v1;
        updateUserLastMineTime(v2, arg1);
        let v3 = &mut v1;
        updateUserEnergy<T0>(v3, arg0, arg1);
        v1.state.initTime = 0x2::clock::timestamp_ms(arg1);
        arg0.state.userCount = arg0.state.userCount + 1;
        0x2::table::add<address, address>(&mut arg0.userStore, 0x2::tx_context::sender(arg2), 0x2::object::uid_to_address(&v1.id));
        let v4 = UserInited{
            userAddress : 0x2::tx_context::sender(arg2),
            initTime    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UserInited>(v4);
        v1
    }

    fun safeMineBlock<T0>(arg0: &mut Game<T0>, arg1: &mut User, arg2: u256, arg3: u8, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<u256, bool>(&arg1.blocks, arg2)) {
            *0x2::table::borrow_mut<u256, bool>(&mut arg1.blocks, arg2) = true;
        } else {
            0x2::table::add<u256, bool>(&mut arg1.blocks, arg2, true);
        };
        let v0 = grantReward<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
        let v1 = @0x0;
        if (v0 > 0) {
            v1 = arg0.config.reward.tokenAddress;
        };
        let v2 = BlockMined{
            userAddress  : 0x2::tx_context::sender(arg6),
            blockHash    : arg2,
            blockType    : arg3,
            userDepth    : arg1.state.currentDepth,
            tokenAddress : v1,
            tokenAmount  : v0,
        };
        0x2::event::emit<BlockMined>(v2);
    }

    fun safeMineBlocksUpdate<T0>(arg0: &mut User, arg1: &mut Game<T0>, arg2: vector<u32>, arg3: u32, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg2)) {
            *0x1::vector::borrow_mut<u32>(&mut arg0.state.minedBlockTypeCounts, v1) = *0x1::vector::borrow<u32>(&arg0.state.minedBlockTypeCounts, v1) + *0x1::vector::borrow<u32>(&arg2, v1);
            *0x1::vector::borrow_mut<u32>(&mut arg1.state.totalMinedBlockTypeCounts, v1) = *0x1::vector::borrow<u32>(&arg1.state.totalMinedBlockTypeCounts, v1) + *0x1::vector::borrow<u32>(&arg2, v1);
            v0 = v0 + ((*0x1::vector::borrow<u32>(&arg2, v1) * (*0x1::vector::borrow<u16>(&arg1.config.mining.blockMiningTimes, v1) as u32)) as u64);
            v1 = v1 + 1;
        };
        arg0.state.currentDepthMinedBlockCount = arg0.state.currentDepthMinedBlockCount + arg3;
        arg1.state.totalMinedBlockCount = arg1.state.totalMinedBlockCount + arg3;
        updateUserEnergy<T0>(arg0, arg1, arg5);
        useUserEnergy(arg0, arg3);
        updateUserDifficulty(arg0, v0, arg5, arg6);
        updateUserLastMineTime(arg0, arg5);
        updateUserPoWSeed(arg0, arg4, arg6);
    }

    public fun setGamePaused<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun shouldUnlockDepth<T0>(arg0: &Game<T0>, arg1: &User, arg2: u64) : bool {
        (arg1.state.currentDepthMinedBlockCount as u64) + arg2 >= ((arg0.config.general.sizeX * arg0.config.general.sizeY) as u64)
    }

    public fun signatureCheck<T0>(arg0: &Game<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(get_address_from_public_key(&arg2) == arg0.config.general.trustedSigner, 7);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes((arg3 as u256)));
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v1), 8);
    }

    fun u256_to_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> (31 - v1) * 8 & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun unlockDepth(arg0: &mut User, arg1: u256, arg2: u32, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!getBlockMined(arg0, arg1), 12);
        if (0x2::table::contains<u256, bool>(&arg0.blocks, arg1)) {
            *0x2::table::borrow_mut<u256, bool>(&mut arg0.blocks, arg1) = true;
        } else {
            0x2::table::add<u256, bool>(&mut arg0.blocks, arg1, true);
        };
        arg0.state.currentDepth = arg2;
        arg0.state.currentDepthInitBlockHash = arg1;
        arg0.state.currentDepthMinedBlockCount = 1;
        updateUserPoWSeed(arg0, arg4, arg5);
        let v0 = DepthUnlocked{
            userAddress : 0x2::tx_context::sender(arg5),
            blockHash   : arg1,
            userDepth   : arg2,
            unlockTime  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepthUnlocked>(v0);
    }

    public fun updateConfig<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x1::string::String, arg3: u8, arg4: u16, arg5: u16, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: u32, arg12: u32, arg13: vector<u32>, arg14: vector<u8>, arg15: vector<u16>, arg16: address, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: vector<u32>, arg22: vector<u64>, arg23: vector<u64>) {
        arg1.config.general.name = arg2;
        arg1.config.general.powMode = arg3;
        arg1.config.general.sizeX = arg4;
        arg1.config.general.sizeY = arg5;
        arg1.config.general.maxEnergy = arg6;
        arg1.config.general.energyResetTime = arg7;
        arg1.config.general.startTime = arg8;
        arg1.config.general.gameDuration = arg9;
        arg1.config.general.trustedSigner = arg10;
        arg1.config.defog.maxRounds = arg11;
        arg1.config.defog.repeatRounds = arg12;
        arg1.config.defog.thresholds = arg13;
        arg1.config.mining.blockDifficulties = arg14;
        arg1.config.mining.blockMiningTimes = arg15;
        arg1.config.reward.tokenAddress = arg16;
        arg1.config.reward.dailyTotalMaxReward = arg17;
        arg1.config.reward.dailyUserMaxReward = arg18;
        arg1.config.reward.hourlyTotalMaxReward = arg19;
        arg1.config.reward.userMaxReward = arg20;
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardLevel>(&arg1.config.reward.blockReward)) {
            0x1::vector::borrow_mut<RewardLevel>(&mut arg1.config.reward.blockReward, v0).possibility = *0x1::vector::borrow<u32>(&arg21, v0);
            0x1::vector::borrow_mut<RewardLevel>(&mut arg1.config.reward.blockReward, v0).minAmount = *0x1::vector::borrow<u64>(&arg22, v0);
            0x1::vector::borrow_mut<RewardLevel>(&mut arg1.config.reward.blockReward, v0).maxAmount = *0x1::vector::borrow<u64>(&arg23, v0);
            v0 = v0 + 1;
        };
    }

    fun updateUserDifficulty(arg0: &mut User, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg2) - arg0.state.lastMineTime < arg1) {
            arg0.state.difficulty = arg0.state.difficulty + 1;
            let v0 = DifficultyUpdated{
                userAddress   : 0x2::tx_context::sender(arg3),
                newDifficulty : arg0.state.difficulty,
            };
            0x2::event::emit<DifficultyUpdated>(v0);
        } else if (arg0.state.difficulty > 0) {
            arg0.state.difficulty = arg0.state.difficulty - 1;
            let v1 = DifficultyUpdated{
                userAddress   : 0x2::tx_context::sender(arg3),
                newDifficulty : arg0.state.difficulty,
            };
            0x2::event::emit<DifficultyUpdated>(v1);
        };
    }

    fun updateUserEnergy<T0>(arg0: &mut User, arg1: &Game<T0>, arg2: &0x2::clock::Clock) {
        arg0.state.remainingEnergy = getUserRemainingEnergy<T0>(arg1, arg0, arg2);
    }

    fun updateUserLastMineTime(arg0: &mut User, arg1: &0x2::clock::Clock) {
        arg0.state.lastMineTime = 0x2::clock::timestamp_ms(arg1);
    }

    fun updateUserPoWSeed(arg0: &mut User, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        arg0.state.powSeed = 0x2::random::generate_u256(&mut v0);
    }

    fun useUserEnergy(arg0: &mut User, arg1: u32) {
        assert!(arg0.state.remainingEnergy >= arg1, 17);
        arg0.state.remainingEnergy = arg0.state.remainingEnergy - arg1;
    }

    public fun withdrawFromRewardPool<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state.remainingReward >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool, arg2, arg3), 0x2::tx_context::sender(arg3));
        arg1.state.remainingReward = arg1.state.remainingReward - arg2;
        arg1.state.totalClaimed = arg1.state.totalClaimed + arg2;
    }

    // decompiled from Move bytecode v6
}

