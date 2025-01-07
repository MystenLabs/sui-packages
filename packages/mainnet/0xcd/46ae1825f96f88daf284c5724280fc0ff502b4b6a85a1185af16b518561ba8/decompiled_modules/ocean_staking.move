module 0xcd46ae1825f96f88daf284c5724280fc0ff502b4b6a85a1185af16b518561ba8::ocean_staking {
    struct App has key {
        id: 0x2::object::UID,
        pools: 0x2::table_vec::TableVec<Pool>,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct Pool has store {
        required_stake_amount: u64,
        total_staked: u64,
        total_participant: u64,
        start_time: u64,
        end_time: u64,
    }

    struct User has store {
        stake_amount: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
    }

    struct UserStaked has copy, drop, store {
        staker: address,
        pool_id: u64,
        amount: u64,
    }

    struct UserUnstaked has copy, drop, store {
        staker: address,
        pool_id: u64,
        amount: u64,
    }

    struct StakingOwnerCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            pools       : 0x2::table_vec::empty<Pool>(arg0),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = StakingOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakingOwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun stake(arg0: &mut App, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 < 0x2::table_vec::length<Pool>(&arg0.pools), 1);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg0.pools, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1.start_time == 0 || v2 > v1.start_time, 2);
        assert!(v1.end_time == 0 || v2 < v1.end_time, 3);
        let v3 = 0x2::address::to_string(v0);
        0x1::string::append_utf8(&mut v3, b"-");
        0x1::string::append(&mut v3, u64_to_string(arg1));
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3), 8);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v5 = v1.required_stake_amount;
        assert!(v4 >= v1.required_stake_amount, 7);
        let v6 = if (v4 > v5) {
            0x2::pay::keep<0x2::sui::SUI>(arg2, arg4);
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v5, arg4)
        } else {
            arg2
        };
        let v7 = User{
            stake_amount : 0x2::coin::into_balance<0x2::sui::SUI>(v6),
            status       : 1,
        };
        0x2::dynamic_field::add<0x1::string::String, User>(&mut arg0.id, v3, v7);
        v1.total_staked = v1.total_staked + v5;
        v1.total_participant = v1.total_participant + 1;
        let v8 = UserStaked{
            staker  : v0,
            pool_id : arg1,
            amount  : v5,
        };
        0x2::event::emit<UserStaked>(v8);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    entry fun unstake(arg0: &mut App, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 4);
        assert!(arg1 < 0x2::table_vec::length<Pool>(&arg0.pools), 1);
        assert!(0x2::clock::timestamp_ms(arg2) > 0x2::table_vec::borrow_mut<Pool>(&mut arg0.pools, arg1).end_time, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::address::to_string(v0);
        0x1::string::append_utf8(&mut v1, b"-");
        0x1::string::append(&mut v1, u64_to_string(arg1));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1), 5);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, User>(&mut arg0.id, v1);
        assert!(v2.status == 1, 9);
        v2.status = 2;
        let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v2.stake_amount);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), v0);
        let v4 = UserUnstaked{
            staker  : v0,
            pool_id : arg1,
            amount  : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        0x2::event::emit<UserUnstaked>(v4);
    }

    entry fun update_pools(arg0: &StakingOwnerCap, arg1: &mut App, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 == 0x1::vector::length<u64>(&arg4) && v0 == 0x1::vector::length<u64>(&arg5), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<Pool>(&arg1.pools)) {
                let v3 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v2);
                v3.required_stake_amount = *0x1::vector::borrow<u64>(&arg3, v1);
                v3.start_time = *0x1::vector::borrow<u64>(&arg4, v1);
                v3.end_time = *0x1::vector::borrow<u64>(&arg5, v1);
            } else {
                let v4 = Pool{
                    required_stake_amount : *0x1::vector::borrow<u64>(&arg3, v1),
                    total_staked          : 0,
                    total_participant     : 0,
                    start_time            : *0x1::vector::borrow<u64>(&arg4, v1),
                    end_time              : *0x1::vector::borrow<u64>(&arg5, v1),
                };
                0x2::table_vec::push_back<Pool>(&mut arg1.pools, v4);
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

