module 0x6cc2e3f1089e6f6cc26f43a7e3d7b5c654010e817099337a47c9ac5dae6ea08e::stake_sui_contract {
    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct StakingInfo has store {
        stake_amount: 0x2::coin::Coin<0x2::sui::SUI>,
        stake_time: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        user_stake_info: 0x2::vec_map::VecMap<address, StakingInfo>,
        lock_period: u64,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct STAKE_SUI_CONTRACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE_SUI_CONTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        0x2::transfer::public_transfer<Owner>(v1, v0);
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v2);
        let v3 = StakingPool{
            id              : 0x2::object::new(arg1),
            user_stake_info : 0x2::vec_map::empty<address, StakingInfo>(),
            lock_period     : 0,
        };
        0x2::transfer::share_object<StakingPool>(v3);
    }

    public entry fun stake(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 0, 1);
        assert!(arg2 != 0, 2);
        assert!(arg2 <= 0x2::coin::value<0x2::sui::SUI>(arg0), 3);
        let v0 = StakingInfo{
            stake_amount : 0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg5),
            stake_time   : time_in_secs(arg3),
        };
        0x2::vec_map::insert<address, StakingInfo>(&mut arg1.user_stake_info, 0x2::tx_context::sender(arg5), v0);
    }

    public entry fun stake_more(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4.version == 0, 1);
        assert!(arg2 != 0, 2);
        assert!(arg2 <= 0x2::coin::value<0x2::sui::SUI>(arg0), 3);
        assert!(0x2::vec_map::contains<address, StakingInfo>(&arg1.user_stake_info, &v0), 4);
        let v1 = 0x2::vec_map::get_mut<address, StakingInfo>(&mut arg1.user_stake_info, &v0);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.stake_amount, 0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg5));
        v1.stake_time = time_in_secs(arg3);
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

