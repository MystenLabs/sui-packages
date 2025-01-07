module 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::suiGameStake {
    struct SNftPropertys has store, key {
        id: 0x2::object::UID,
        value: u64,
        owner: address,
    }

    struct SOwnNftIDs has store, key {
        id: 0x2::object::UID,
        nftIDs: vector<0x2::object::ID>,
    }

    struct SFeedRewardData has store, key {
        id: 0x2::object::UID,
        sum: u64,
        startTime: u64,
        alreadyReward: u64,
    }

    struct StakePool has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        rewardsToken: 0x2::balance::Balance<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>,
        periodFinish: u64,
        rewardRate: u64,
        rewardsDuration: u64,
        lastUpdateTime: u64,
        rewardPerTokenStored: u64,
        totalReward: u64,
        totalStakeTokens: u64,
        userRewardPerTokenPaid: 0x2::table::Table<address, u64>,
        rewards: 0x2::table::Table<address, u64>,
        totalSupply: u64,
        balancesAll: 0x2::table::Table<address, u64>,
        totalRewardAlready: u64,
        stakingPoolNFTs: 0x2::table::Table<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>,
        stakingNFTs: 0x2::table::Table<0x2::object::ID, SNftPropertys>,
        ownerNFTs: 0x2::table::Table<address, SOwnNftIDs>,
        feedRewardArr: 0x2::table::Table<address, SFeedRewardData>,
        basicDailyReward: u64,
    }

    struct SuiGameManager has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun getHashrateByTokenId(arg0: &0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT) : u64 {
        0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::getHashrateByTokenId(arg0)
    }

    public entry fun addRewardTokens(arg0: &mut StakePool, arg1: vector<0x2::coin::Coin<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(&mut arg0.rewardsToken, 0x2::coin::into_balance<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(get_coin_from_vec<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(arg1, arg2, arg3)));
    }

    fun earned_Stake(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.balancesAll, arg2);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.userRewardPerTokenPaid, arg2);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.rewards, arg2);
        v0 * (rewardPerToken(arg0, arg1) - v1) / 1000000000000000000 + v2
    }

    public entry fun exit(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        updateReward(arg0, msgSender(arg2), arg1);
        0x1::vector::length<0x2::object::ID>(&0x2::table::borrow_mut<address, SOwnNftIDs>(&mut arg0.ownerNFTs, msgSender(arg2)).nftIDs);
        exit(arg0, arg1, arg2);
    }

    public entry fun exits(arg0: &mut StakePool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        updateReward(arg0, msgSender(arg3), arg2);
        exit(arg0, arg2, arg3);
    }

    public entry fun feedFresh(arg0: &mut StakePool, arg1: &mut 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::NFTPool, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&arg0.stakingPoolNFTs, arg2), 0);
        feed_nft(arg0, arg1, arg2, arg3, arg4, arg5);
        stakeFresh(arg0, arg2, arg4, arg5);
    }

    fun feed_nft(arg0: &mut StakePool, arg1: &mut 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::NFTPool, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::feed(arg1, 0x2::table::borrow_mut<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&mut arg0.stakingPoolNFTs, arg2), arg3, arg4, arg5);
    }

    public entry fun getFeedReward_All(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = getFeedReward_dt(arg0, arg2, arg1, arg3);
        0x2::table::borrow_mut<address, SFeedRewardData>(&mut arg0.feedRewardArr, arg2).alreadyReward + v0
    }

    public entry fun getFeedReward_dt(arg0: &mut StakePool, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<address, SFeedRewardData>(&arg0.feedRewardArr, arg1)) {
            let v1 = SFeedRewardData{
                id            : 0x2::object::new(arg3),
                sum           : 0,
                startTime     : 0,
                alreadyReward : 0,
            };
            0x2::table::add<address, SFeedRewardData>(&mut arg0.feedRewardArr, arg1, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, SFeedRewardData>(&mut arg0.feedRewardArr, arg1);
        if (v2.sum == 0 && v2.alreadyReward == 0) {
            return 0
        };
        let v3 = v0;
        if (v0 > v2.startTime + arg0.rewardsDuration) {
            v3 = v2.startTime + arg0.rewardsDuration;
        };
        (v3 - v2.startTime) * v2.sum / arg0.rewardsDuration
    }

    public entry fun getReward(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        updateReward(arg0, msgSender(arg2), arg1);
        let v0 = msgSender(arg2);
        let v1 = getFeedReward_All(arg0, arg1, v0, arg2);
        let v2 = &mut arg0.rewards;
        let v3 = getTableVale(v2, msgSender(arg2)) + v1;
        assert!(v3 > 0, 0);
        if (v3 > 0) {
            let v4 = &mut arg0.rewards;
            setTableVale(v4, msgSender(arg2), 0);
            transferTo(arg0, v3, arg2);
            arg0.totalRewardAlready = arg0.totalRewardAlready + v3;
        };
    }

    fun getTableVale(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(arg0, arg1);
        };
        v0
    }

    fun get_coin_from_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 0);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePool{
            id                     : 0x2::object::new(arg0),
            name                   : 0x1::string::utf8(b"SuiGameStake"),
            description            : 0x1::string::utf8(b"SuiGameStake"),
            rewardsToken           : 0x2::balance::zero<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(),
            periodFinish           : 0,
            rewardRate             : 0,
            rewardsDuration        : 15552000000,
            lastUpdateTime         : 0,
            rewardPerTokenStored   : 0,
            totalReward            : 0,
            totalStakeTokens       : 0,
            userRewardPerTokenPaid : 0x2::table::new<address, u64>(arg0),
            rewards                : 0x2::table::new<address, u64>(arg0),
            totalSupply            : 0,
            balancesAll            : 0x2::table::new<address, u64>(arg0),
            totalRewardAlready     : 0,
            stakingPoolNFTs        : 0x2::table::new<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(arg0),
            stakingNFTs            : 0x2::table::new<0x2::object::ID, SNftPropertys>(arg0),
            ownerNFTs              : 0x2::table::new<address, SOwnNftIDs>(arg0),
            feedRewardArr          : 0x2::table::new<address, SFeedRewardData>(arg0),
            basicDailyReward       : 100000,
        };
        0x2::transfer::share_object<StakePool>(v0);
        let v1 = SuiGameManager{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"SuiGameManager"),
        };
        0x2::transfer::public_transfer<SuiGameManager>(v1, msgSender(arg0));
    }

    public entry fun lastTimeRewardApplicable(arg0: &mut StakePool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0;
        if (v0 >= arg0.periodFinish) {
            v1 = arg0.periodFinish;
        };
        v1
    }

    fun msgSender(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public entry fun notifyRewardAmount(arg0: &SuiGameManager, arg1: &mut StakePool, arg2: u64, arg3: &0x2::clock::Clock) {
        updateReward0(arg1, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 >= arg1.periodFinish) {
            arg1.rewardRate = arg2 / arg1.rewardsDuration;
        } else {
            arg1.rewardRate = (arg2 + (arg1.periodFinish - v0) * arg1.rewardRate) / arg1.rewardsDuration;
        };
        arg1.totalReward = arg1.totalReward + arg2;
        let v1 = 0x2::balance::value<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(&arg1.rewardsToken);
        assert!(0x2::balance::value<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(&arg1.rewardsToken) >= v1, 0);
        assert!(arg1.rewardRate <= v1 / arg1.rewardsDuration, 0);
        arg1.lastUpdateTime = v0;
        arg1.periodFinish = v0 + arg1.rewardsDuration;
    }

    public entry fun rewardPerToken(arg0: &mut StakePool, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.totalSupply == 0) {
            arg0.rewardPerTokenStored
        } else {
            let v1 = arg0.rewardPerTokenStored;
            let v2 = lastTimeRewardApplicable(arg0, arg1);
            v1 + (v2 - arg0.lastUpdateTime) * arg0.rewardRate * 1000000000000000000 / arg0.totalSupply
        }
    }

    public entry fun setBasicDailyReward(arg0: &SuiGameManager, arg1: &mut StakePool, arg2: u64) {
        arg1.basicDailyReward = arg2;
    }

    fun setTableVale(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, 0);
        };
        *0x2::table::borrow_mut<address, u64>(arg0, arg1) = arg2;
    }

    public entry fun setTokens(arg0: &SuiGameManager, arg1: &mut StakePool, arg2: u64) {
        arg1.rewardsDuration = arg2;
    }

    public entry fun stake(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = getHashrateByTokenId(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<0x2::object::ID, SNftPropertys>(&arg0.stakingNFTs, 0x2::object::id<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&arg2))) {
            let v2 = SNftPropertys{
                id    : 0x2::object::new(arg3),
                value : v0,
                owner : msgSender(arg3),
            };
            0x2::table::add<0x2::object::ID, SNftPropertys>(&mut arg0.stakingNFTs, 0x2::object::id<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&arg2), v2);
        };
        if (!0x2::table::contains<address, SOwnNftIDs>(&arg0.ownerNFTs, v1)) {
            let v3 = SOwnNftIDs{
                id     : 0x2::object::new(arg3),
                nftIDs : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, SOwnNftIDs>(&mut arg0.ownerNFTs, v1, v3);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, SOwnNftIDs>(&mut arg0.ownerNFTs, v1).nftIDs, 0x2::object::id<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&arg2));
        let v4 = &mut arg0.balancesAll;
        let v5 = getTableVale(v4, msgSender(arg3));
        let v6 = &mut arg0.balancesAll;
        setTableVale(v6, msgSender(arg3), v5 + v0);
        0x2::transfer::public_transfer<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(arg2, msgSender(arg3));
        arg0.totalSupply = arg0.totalSupply + v0;
        arg0.totalStakeTokens = arg0.totalStakeTokens + 1;
    }

    public entry fun stakeFresh(arg0: &mut StakePool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = msgSender(arg3);
        updateReward(arg0, v0, arg2);
        assert!(0x2::table::contains<0x2::object::ID, SNftPropertys>(&arg0.stakingNFTs, arg1), 0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, SNftPropertys>(&mut arg0.stakingNFTs, arg1);
        assert!(v0 == v1.owner, 0);
        let v2 = getHashrateByTokenId(0x2::table::borrow<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&mut arg0.stakingPoolNFTs, arg1));
        assert!(v2 > v1.value, 2);
        let v3 = &mut arg0.balancesAll;
        let v4 = getTableVale(v3, v0);
        let v5 = &mut arg0.balancesAll;
        setTableVale(v5, v0, v4 + v2 - v1.value);
        arg0.totalSupply = arg0.totalSupply + v2 - v1.value;
        v1.value = v2;
    }

    public entry fun stake_enter(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT, arg3: &mut 0x2::tx_context::TxContext) {
        updateReward0(arg0, arg1);
        stake(arg0, arg1, arg2, arg3);
    }

    public entry fun stakes(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: vector<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        updateReward0(arg0, arg1);
        let v0 = 0x1::vector::length<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&arg2);
        assert!(v0 <= 100, 0);
        assert!(v0 > 0, 1);
        let v1 = 0;
        while (v1 < v0) {
            stake(arg0, arg1, 0x1::vector::pop_back<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&mut arg2), arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(arg2);
    }

    fun transferTo(arg0: &mut StakePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>>(0x2::coin::from_balance<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(0x2::balance::split<0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP::SUIEP>(&mut arg0.rewardsToken, arg1), arg2), msgSender(arg2));
    }

    fun updateReward(arg0: &mut StakePool, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = rewardPerToken(arg0, arg2);
        arg0.rewardPerTokenStored = v0;
        let v1 = lastTimeRewardApplicable(arg0, arg2);
        arg0.lastUpdateTime = v1;
        let v2 = earned_Stake(arg0, arg2, arg1);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.rewards, arg1) = v2;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.userRewardPerTokenPaid, arg1) = arg0.rewardPerTokenStored;
    }

    fun updateReward0(arg0: &mut StakePool, arg1: &0x2::clock::Clock) {
        let v0 = rewardPerToken(arg0, arg1);
        arg0.rewardPerTokenStored = v0;
        let v1 = lastTimeRewardApplicable(arg0, arg1);
        arg0.lastUpdateTime = v1;
    }

    fun withdraw(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, SNftPropertys>(&arg0.stakingNFTs, arg2), 0);
        assert!(msgSender(arg3) == 0x2::table::borrow_mut<0x2::object::ID, SNftPropertys>(&mut arg0.stakingNFTs, arg2).owner, 0);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&mut arg0.stakingPoolNFTs, arg2);
        let v1 = getHashrateByTokenId(&v0);
        let v2 = &mut arg0.balancesAll;
        let v3 = getTableVale(v2, msgSender(arg3));
        let v4 = &mut arg0.balancesAll;
        setTableVale(v4, msgSender(arg3), v3 - v1);
        arg0.totalSupply = arg0.totalSupply - v1;
        0x2::transfer::public_transfer<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(v0, msgSender(arg3));
        0x2::transfer::public_transfer<0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(0x2::table::remove<0x2::object::ID, 0x21427009f60b2c5a5f0955aac2e075c4005dfa5c16dbe5ddd344a9113b18096f::SuiGameNFT::SuiGameNFT>(&mut arg0.stakingPoolNFTs, arg2), msgSender(arg3));
        let SNftPropertys {
            id    : v5,
            value : _,
            owner : _,
        } = 0x2::table::remove<0x2::object::ID, SNftPropertys>(&mut arg0.stakingNFTs, arg2);
        0x2::object::delete(v5);
        arg0.totalStakeTokens = arg0.totalStakeTokens - 1;
    }

    fun withdrawDel(arg0: &mut StakePool, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = msgSender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, SNftPropertys>(&arg0.stakingNFTs, arg1), 0);
        withdraw(arg0, arg3, arg1, arg4);
        let v1 = 0x2::table::borrow_mut<address, SOwnNftIDs>(&mut arg0.ownerNFTs, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1.nftIDs)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v1.nftIDs, v2) == arg1) {
                0x1::vector::remove<0x2::object::ID>(&mut v1.nftIDs, v2);
                break
            };
            v2 = v2 + 1;
        };
    }

    public entry fun withdraw_enter(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        updateReward(arg0, msgSender(arg3), arg1);
        withdrawDel(arg0, arg2, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

