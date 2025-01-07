module 0xa68b2a59916b72e9d6c323f084825fb9394a888680129d5868d5632730ab8524::staking {
    struct UserData has store {
        stake_amount: u64,
        reserve_bag: 0x2::bag::Bag,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        current_version: u64,
        pool_cap_id: 0x2::object::ID,
        total_staked_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        users: 0x2::table::Table<address, UserData>,
        reserve_bag: 0x2::bag::Bag,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCap{id: 0x2::object::new(arg0)};
        let v1 = Pool{
            id                   : 0x2::object::new(arg0),
            current_version      : 0,
            pool_cap_id          : 0x2::object::uid_to_inner(&v0.id),
            total_staked_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            users                : 0x2::table::new<address, UserData>(arg0),
            reserve_bag          : 0x2::bag::new(arg0),
        };
        0x2::transfer::transfer<PoolCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Pool>(v1);
    }

    fun only_admin(arg0: &Pool, arg1: &PoolCap) {
        assert!(arg0.pool_cap_id == 0x2::object::uid_to_inner(&arg1.id), 1001);
    }

    fun only_allowed_version(arg0: &Pool) {
        assert!(arg0.current_version <= 1, 1000);
    }

    public entry fun set_version(arg0: &mut Pool, arg1: &PoolCap, arg2: u64) {
        only_admin(arg0, arg1);
        arg0.current_version = arg2;
    }

    public entry fun stake(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1005);
        let v1 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, UserData>(&arg0.users, v1)) {
            let v2 = UserData{
                stake_amount : 0,
                reserve_bag  : 0x2::bag::new(arg2),
            };
            0x2::table::add<address, UserData>(&mut arg0.users, v1, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.users, v1);
        v3.stake_amount = v3.stake_amount + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun withdraw(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        assert!(arg1 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 <= 0x2::table::borrow<address, UserData>(&mut arg0.users, v0).stake_amount, 1007);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked_balance, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

