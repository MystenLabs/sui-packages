module 0xe94807dce0f856ba5d31603a20ebb8ce4ac69e8f7b21d4b618e4cab7492aa9a6::vault {
    struct UserPool has store, key {
        id: 0x2::object::UID,
        maximumStakes: u256,
        totalStakes: u256,
        launchTime: u64,
        maturityMs: u64,
        requiredStakeAmount: u64,
        pointsGainCoefPerS: u64,
        pointsGainDecimals: u8,
        suiaiNftRewardCount: u256,
        maxNftsAvailable: u256,
        closingTime: u64,
        poolName: 0x1::string::String,
    }

    struct UserPools has store, key {
        id: 0x2::object::UID,
        pools: 0x2::vec_map::VecMap<0x1::string::String, UserPool>,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        poolUsed: 0x1::string::String,
        stakeTime: u64,
        stakeAmount: u64,
        stakeWithdrawnTime: u64,
    }

    struct UserStakingState has store, key {
        id: 0x2::object::UID,
        pointsGained: u64,
        userStakes: 0x2::vec_map::VecMap<address, UserStake>,
        stakeIds: vector<address>,
    }

    struct UsersStates has key {
        id: 0x2::object::UID,
        usersStates: 0x2::vec_map::VecMap<address, UserStakingState>,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        stakedCoinsTreasury: 0x2::balance::Balance<T0>,
    }

    struct SuiDesciAgentsNFT has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        attributes: vector<NFTAttributes>,
    }

    struct NFTAttributes has store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFTTreasury has store, key {
        id: 0x2::object::UID,
        nextNFTNumber: u64,
        totalMintedNft: u64,
        nftStorage: 0x2::vec_map::VecMap<u64, SuiDesciAgentsNFT>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BridgeState has store, key {
        id: 0x2::object::UID,
        nonce: u64,
    }

    struct StakedInfo has copy, drop {
        user: address,
        amount: u64,
        stakeId: address,
        poolName: 0x1::string::String,
        stakeUntil: u64,
        timeNow: u64,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct NFTClaimed has copy, drop {
        id: 0x2::object::ID,
        claimed_by: address,
        name: 0x1::string::String,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
        stakeId: address,
        poolName: 0x1::string::String,
        stakeUntil: u64,
        timeNow: u64,
    }

    struct Stakeda has copy, drop {
        pool1: u64,
        pool2: u64,
        timeNow: u64,
    }

    struct UnstakeError has copy, drop {
        user: address,
        amount: u64,
        stakeId: address,
        poolName: 0x1::string::String,
        stakeUntil: u64,
        timeNow: u64,
    }

    struct Withdrawn has copy, drop {
        user: address,
        amount: u64,
        pointsGained: u64,
        pointsDecimals: u8,
        timeStakedSeconds: u64,
        stakeId: address,
        poolName: 0x1::string::String,
        stakeUntil: u64,
        timeNow: u64,
    }

    struct BridgeEvent has copy, drop {
        ethWallet: 0x1::string::String,
        suiWallet: address,
        fromSuiToEth: bool,
        amount: u64,
        nonce: u64,
        timeNow: u64,
    }

    public entry fun burn<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut BridgeState, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) == 42, 117);
        arg1.nonce = arg1.nonce + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::address::from_u256(0));
        emitBridgeEvent(arg2, 0x2::tx_context::sender(arg4), true, 0x2::coin::value<T0>(&arg0), arg1.nonce, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun claim_nft(arg0: &mut UsersStates, arg1: &mut NFTTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 250000000000;
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, UserStakingState>(&arg0.usersStates, &v1), 106);
        let v2 = 0x2::vec_map::get_mut<address, UserStakingState>(&mut arg0.usersStates, &v1);
        assert!(v2.pointsGained >= v0, 118);
        assert!(0x2::vec_map::contains<u64, SuiDesciAgentsNFT>(&arg1.nftStorage, &arg1.nextNFTNumber), 119);
        let (_, v4) = 0x2::vec_map::remove<u64, SuiDesciAgentsNFT>(&mut arg1.nftStorage, &arg1.nextNFTNumber);
        let v5 = v4;
        let v6 = NFTClaimed{
            id         : 0x2::object::id<SuiDesciAgentsNFT>(&v5),
            claimed_by : v1,
            name       : v5.name,
        };
        0x2::event::emit<NFTClaimed>(v6);
        0x2::transfer::public_transfer<SuiDesciAgentsNFT>(v5, v1);
        v2.pointsGained = v2.pointsGained - v0;
        arg1.nextNFTNumber = arg1.nextNFTNumber + 1;
    }

    public entry fun createOrUpdateUserPool(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u256, arg5: u256, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u8, arg10: &mut UserPools, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg4;
        if (!0x2::vec_map::contains<0x1::string::String, UserPool>(&arg10.pools, &arg7)) {
            let v1 = UserPool{
                id                  : 0x2::object::new(arg11),
                maximumStakes       : v0,
                totalStakes         : 0,
                launchTime          : arg1,
                maturityMs          : arg2,
                requiredStakeAmount : arg3,
                pointsGainCoefPerS  : arg8,
                pointsGainDecimals  : arg9,
                suiaiNftRewardCount : arg4,
                maxNftsAvailable    : arg5,
                closingTime         : arg6,
                poolName            : arg7,
            };
            0x2::vec_map::insert<0x1::string::String, UserPool>(&mut arg10.pools, arg7, v1);
        } else {
            let v2 = 0x2::vec_map::get_mut<0x1::string::String, UserPool>(&mut arg10.pools, &arg7);
            assert!(v2.totalStakes < v0, 116);
            v2.maximumStakes = v0;
            v2.launchTime = arg1;
            v2.maturityMs = arg2;
            v2.requiredStakeAmount = arg3;
            v2.suiaiNftRewardCount = arg4;
            v2.maxNftsAvailable = arg5;
            v2.closingTime = arg6;
        };
    }

    public entry fun create_nft_treasury(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTreasury{
            id             : 0x2::object::new(arg1),
            nextNFTNumber  : 1,
            totalMintedNft : 0,
            nftStorage     : 0x2::vec_map::empty<u64, SuiDesciAgentsNFT>(),
        };
        0x2::transfer::share_object<NFTTreasury>(v0);
    }

    public entry fun create_treasury_for_coin<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                  : 0x2::object::new(arg1),
            stakedCoinsTreasury : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun emitBridgeEvent(arg0: 0x1::string::String, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BridgeEvent{
            ethWallet    : arg0,
            suiWallet    : arg1,
            fromSuiToEth : arg2,
            amount       : arg3,
            nonce        : arg4,
            timeNow      : arg5,
        };
        0x2::event::emit<BridgeEvent>(v0);
    }

    public entry fun getStakes(arg0: &mut UsersStates, arg1: &mut UserPools, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_map::contains<address, UserStakingState>(&arg0.usersStates, &v0), 106);
        let v1 = 0x2::vec_map::get_mut<address, UserStakingState>(&mut arg0.usersStates, &v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1.stakeIds)) {
            let v3 = *0x1::vector::borrow<address>(&v1.stakeIds, v2);
            let v4 = 0x2::vec_map::get_mut<address, UserStake>(&mut v1.userStakes, &v3);
            let v5 = StakedInfo{
                user       : v0,
                amount     : v4.stakeAmount,
                stakeId    : 0x2::object::uid_to_address(&v4.id),
                poolName   : v4.poolUsed,
                stakeUntil : v4.stakeTime + 0x2::vec_map::get_mut<0x1::string::String, UserPool>(&mut arg1.pools, &v4.poolUsed).maturityMs,
                timeNow    : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StakedInfo>(v5);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id    : 0x2::object::new(arg0),
            nonce : 0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
        let v1 = UserPools{
            id    : 0x2::object::new(arg0),
            pools : 0x2::vec_map::empty<0x1::string::String, UserPool>(),
        };
        0x2::transfer::share_object<UserPools>(v1);
        let v2 = UsersStates{
            id          : 0x2::object::new(arg0),
            usersStates : 0x2::vec_map::empty<address, UserStakingState>(),
        };
        0x2::transfer::share_object<UsersStates>(v2);
        let v3 = NFTTreasury{
            id             : 0x2::object::new(arg0),
            nextNFTNumber  : 1,
            totalMintedNft : 0,
            nftStorage     : 0x2::vec_map::empty<u64, SuiDesciAgentsNFT>(),
        };
        0x2::transfer::share_object<NFTTreasury>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut BridgeState, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg3) == 42, 117);
        arg1.nonce = arg1.nonce + 1;
        0x2::coin::mint_and_transfer<T0>(arg0, arg2, arg4, arg6);
        emitBridgeEvent(arg3, arg4, false, arg2, arg1.nonce, 0x2::clock::timestamp_ms(arg5));
    }

    public entry fun mint_new_nft(arg0: &AdminCap, arg1: &mut NFTTreasury, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<NFTAttributes>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg7)) {
            let v2 = NFTAttributes{
                trait_type : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v1)),
                value      : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v1 + 1)),
            };
            0x1::vector::push_back<NFTAttributes>(&mut v0, v2);
            v1 = v1 + 2;
        };
        let v3 = SuiDesciAgentsNFT{
            id          : 0x2::object::new(arg8),
            url         : 0x2::url::new_unsafe_from_bytes(arg6),
            name        : arg4,
            description : arg3,
            symbol      : arg5,
            attributes  : v0,
        };
        let v4 = NFTMinted{
            id   : 0x2::object::id<SuiDesciAgentsNFT>(&v3),
            name : v3.name,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::vec_map::insert<u64, SuiDesciAgentsNFT>(&mut arg1.nftStorage, arg2, v3);
        arg1.totalMintedNft = arg1.totalMintedNft + 1;
    }

    public entry fun stake<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut UsersStates, arg2: &mut Treasury<T0>, arg3: &mut UserPools, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::vec_map::contains<0x1::string::String, UserPool>(&arg3.pools, &arg4), 108);
        let v2 = 0x2::vec_map::get_mut<0x1::string::String, UserPool>(&mut arg3.pools, &arg4);
        let v3 = 0x2::coin::value<T0>(&arg0);
        assert!(v3 >= v2.requiredStakeAmount, 109);
        assert!(v2.totalStakes + 1 <= v2.maximumStakes, 110);
        assert!(v2.suiaiNftRewardCount * (v2.totalStakes + 1) <= v2.maxNftsAvailable, 111);
        assert!(v1 >= v2.launchTime, 112);
        assert!(v1 <= v2.closingTime, 113);
        0x2::balance::join<T0>(&mut arg2.stakedCoinsTreasury, 0x2::coin::into_balance<T0>(arg0));
        let v4 = UserStake{
            id                 : 0x2::object::new(arg6),
            poolUsed           : v2.poolName,
            stakeTime          : v1,
            stakeAmount        : v3,
            stakeWithdrawnTime : 0,
        };
        if (!0x2::vec_map::contains<address, UserStakingState>(&arg1.usersStates, &v0)) {
            let v5 = UserStakingState{
                id           : 0x2::object::new(arg6),
                pointsGained : 0,
                userStakes   : 0x2::vec_map::empty<address, UserStake>(),
                stakeIds     : 0x1::vector::empty<address>(),
            };
            0x2::vec_map::insert<address, UserStakingState>(&mut arg1.usersStates, v0, v5);
        };
        let v6 = 0x2::object::uid_to_address(&v4.id);
        0x2::vec_map::insert<address, UserStake>(&mut 0x2::vec_map::get_mut<address, UserStakingState>(&mut arg1.usersStates, &v0).userStakes, v6, v4);
        v2.totalStakes = v2.totalStakes + 1;
        let v7 = Staked{
            user       : v0,
            amount     : v3,
            stakeId    : v6,
            poolName   : arg4,
            stakeUntil : v4.stakeTime + v2.maturityMs,
            timeNow    : v1,
        };
        0x2::event::emit<Staked>(v7);
    }

    public entry fun withdraw<T0>(arg0: &mut UsersStates, arg1: &mut Treasury<T0>, arg2: &mut UserPools, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::vec_map::contains<address, UserStakingState>(&arg0.usersStates, &v0), 106);
        let v2 = 0x2::vec_map::get_mut<address, UserStakingState>(&mut arg0.usersStates, &v0);
        assert!(0x2::vec_map::contains<address, UserStake>(&v2.userStakes, &arg3), 107);
        let v3 = 0x2::vec_map::get_mut<address, UserStake>(&mut v2.userStakes, &arg3);
        assert!(v3.stakeWithdrawnTime == 0, 115);
        assert!(0x2::vec_map::contains<0x1::string::String, UserPool>(&arg2.pools, &v3.poolUsed), 108);
        let v4 = 0x2::vec_map::get<0x1::string::String, UserPool>(&arg2.pools, &v3.poolUsed);
        let v5 = v3.stakeTime + v4.maturityMs;
        if (v1 <= v5) {
            let v6 = UnstakeError{
                user       : v0,
                amount     : v3.stakeAmount,
                stakeId    : arg3,
                poolName   : v3.poolUsed,
                stakeUntil : v5,
                timeNow    : v1,
            };
            0x2::event::emit<UnstakeError>(v6);
        } else {
            assert!(v3.stakeAmount <= 0x2::balance::value<T0>(&arg1.stakedCoinsTreasury), 103);
            v3.stakeWithdrawnTime = v1;
            assert!(v3.stakeWithdrawnTime == v1, 114);
            let v7 = (v3.stakeWithdrawnTime - v3.stakeTime) / 1000;
            let v8 = (((v3.stakeAmount as u256) * (v7 as u256) * (v4.pointsGainCoefPerS as u256) / 0x1::u256::pow(10, 9)) as u64);
            v2.pointsGained = v2.pointsGained + v8;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.stakedCoinsTreasury, v3.stakeAmount, arg5), v0);
            let v9 = Withdrawn{
                user              : v0,
                amount            : v3.stakeAmount,
                pointsGained      : v8,
                pointsDecimals    : v4.pointsGainDecimals,
                timeStakedSeconds : v7,
                stakeId           : arg3,
                poolName          : v3.poolUsed,
                stakeUntil        : v5,
                timeNow           : v1,
            };
            0x2::event::emit<Withdrawn>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

