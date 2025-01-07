module 0x8a33e676237ccbcdf43ac4f3965bfdda47501edc46599828b01785cd129444e7::sustatetoken {
    struct SUSTATETOKEN has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct VestingMap has store {
        total_amount: u64,
        released_amount: u64,
        vesting_start: u64,
        last_completed_period: u64,
        tge_status: bool,
        tge_percent: u64,
        cycle_amount: u64,
    }

    struct Distribution has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        account: address,
        vesting: VestingMap,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUSTATETOKEN>,
        team_distribution: Distribution,
        community_reserve_distribution: Distribution,
        ecosystem_distribution: Distribution,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        balance: 0x2::balance::Balance<SUSTATETOKEN>,
        unlock_time_ms: u64,
        is_claimed: bool,
    }

    struct LockInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        unlock_time_ms: u64,
        is_claimed: bool,
    }

    public entry fun burn(arg0: &mut Global, arg1: 0x2::coin::Coin<SUSTATETOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SUSTATETOKEN>(&arg1) >= arg2, 5);
        0x2::coin::burn<SUSTATETOKEN>(&mut arg0.treasury_cap, 0x2::coin::split<SUSTATETOKEN>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<SUSTATETOKEN>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUSTATETOKEN>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUSTATETOKEN>(arg1);
        };
    }

    fun calculate_total_vesting_time(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            (arg1 - arg0) / 2629800000
        } else {
            0
        }
    }

    fun calculate_vesting_amount(arg0: &mut Distribution, arg1: u64) : u64 {
        assert!(arg0.vesting.released_amount < arg0.vesting.total_amount, 8);
        let v0 = arg0.vesting.tge_percent;
        assert!(arg1 > arg0.vesting.vesting_start, 0);
        if (v0 > 0 && arg0.vesting.tge_status) {
            let v2 = 0x8a33e676237ccbcdf43ac4f3965bfdda47501edc46599828b01785cd129444e7::math::mul_div(arg0.vesting.total_amount, v0, 100);
            arg0.vesting.released_amount = arg0.vesting.released_amount + v2;
            arg0.vesting.tge_status = false;
            v2
        } else {
            let v3 = calculate_total_vesting_time(arg0.vesting.last_completed_period, arg1);
            assert!(v3 > 0, 1);
            let v4 = arg0.vesting.last_completed_period + v3 * 2629800000;
            assert!(arg1 > v4, 0);
            let v5 = arg0.vesting.cycle_amount * v3;
            let v6 = arg0.vesting.total_amount - arg0.vesting.released_amount;
            let v7 = if (v5 >= v6) {
                v6
            } else {
                v5
            };
            arg0.vesting.released_amount = arg0.vesting.released_amount + v7;
            arg0.vesting.last_completed_period = v4;
            v7
        }
    }

    public entry fun community_reserve_vesting(arg0: &OwnerCap, arg1: &mut Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.community_reserve_distribution;
        let v1 = calculate_vesting_amount(v0, 0x2::clock::timestamp_ms(arg2));
        assert!(v1 > 0, 2);
        0x2::coin::mint_and_transfer<SUSTATETOKEN>(&mut arg1.treasury_cap, v1, arg1.community_reserve_distribution.account, arg3);
    }

    public entry fun ecosystem_vesting(arg0: &OwnerCap, arg1: &mut Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.ecosystem_distribution;
        let v1 = calculate_vesting_amount(v0, 0x2::clock::timestamp_ms(arg2));
        assert!(v1 > 0, 2);
        0x2::coin::mint_and_transfer<SUSTATETOKEN>(&mut arg1.treasury_cap, v1, arg1.ecosystem_distribution.account, arg3);
    }

    fun init(arg0: SUSTATETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunch.infura-ipfs.io/ipfs/QmRGfDH3Rn9qmKXsjMA79QCDvKLYv5ZbeALoCZxHGLi8fP"));
        let (v2, v3) = 0x2::coin::create_currency<SUSTATETOKEN>(arg0, 9, b"ST", b"SUSTATETOKEN", b"Sustate Token (ST) is the project's primary token that will be used to interact with synthetic real estate assets.", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUSTATETOKEN>(&mut v4, 10000000000000000, @0x191de908c1fe4fc6a286e65f5abcbfbe30f4d79191a9fafed2c5f6695e358a0a, arg1);
        let v5 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v5, v0);
        let v6 = VestingMap{
            total_amount          : 8000000000000000,
            released_amount       : 0,
            vesting_start         : 2629800000 * 6 + 1683600300000,
            last_completed_period : 2629800000 * 6 + 1683600300000,
            tge_status            : true,
            tge_percent           : 0,
            cycle_amount          : 0x8a33e676237ccbcdf43ac4f3965bfdda47501edc46599828b01785cd129444e7::math::mul_div(8000000000000000, 20, 1000),
        };
        let v7 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : name_generator(b"Team"),
            account : @0x191de908c1fe4fc6a286e65f5abcbfbe30f4d79191a9fafed2c5f6695e358a0a,
            vesting : v6,
        };
        let v8 = VestingMap{
            total_amount          : 62000000000000000,
            released_amount       : 0,
            vesting_start         : 1683600300000,
            last_completed_period : 1683600300000,
            tge_status            : true,
            tge_percent           : 7,
            cycle_amount          : 0x8a33e676237ccbcdf43ac4f3965bfdda47501edc46599828b01785cd129444e7::math::mul_div(62000000000000000, 30, 1000),
        };
        let v9 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : name_generator(b"Community Reserve"),
            account : @0x191de908c1fe4fc6a286e65f5abcbfbe30f4d79191a9fafed2c5f6695e358a0a,
            vesting : v8,
        };
        let v10 = VestingMap{
            total_amount          : 20000000000000000,
            released_amount       : 0,
            vesting_start         : 1683600300000,
            last_completed_period : 1683600300000,
            tge_status            : true,
            tge_percent           : 2,
            cycle_amount          : 0x8a33e676237ccbcdf43ac4f3965bfdda47501edc46599828b01785cd129444e7::math::mul_div(20000000000000000, 35, 1000),
        };
        let v11 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : name_generator(b"Ecosystem"),
            account : @0x191de908c1fe4fc6a286e65f5abcbfbe30f4d79191a9fafed2c5f6695e358a0a,
            vesting : v10,
        };
        let v12 = Global{
            id                             : 0x2::object::new(arg1),
            treasury_cap                   : v4,
            team_distribution              : v7,
            community_reserve_distribution : v9,
            ecosystem_distribution         : v11,
        };
        0x2::transfer::public_share_object<Global>(v12);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSTATETOKEN>>(v3);
    }

    public entry fun lock(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<SUSTATETOKEN>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(arg5 > 0, 4);
        assert!(0x2::coin::value<SUSTATETOKEN>(&arg4) >= arg5, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = Lock{
            id             : v1,
            name           : v2,
            owner          : v0,
            amount         : arg5,
            balance        : 0x2::balance::zero<SUSTATETOKEN>(),
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::balance::join<SUSTATETOKEN>(&mut v3.balance, 0x2::coin::into_balance<SUSTATETOKEN>(0x2::coin::split<SUSTATETOKEN>(&mut arg4, arg5, arg6)));
        0x2::transfer::transfer<Lock>(v3, v0);
        let v4 = LockInfo{
            id             : 0x2::object::new(arg6),
            name           : v2,
            owner          : v0,
            amount         : arg5,
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&v1), v4);
        if (0x2::coin::value<SUSTATETOKEN>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUSTATETOKEN>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<SUSTATETOKEN>(arg4);
        };
    }

    public entry fun multi_burn(arg0: &mut Global, arg1: vector<0x2::coin::Coin<SUSTATETOKEN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUSTATETOKEN>>(&mut arg1);
        0x2::pay::join_vec<SUSTATETOKEN>(&mut v0, arg1);
        0x2::coin::burn<SUSTATETOKEN>(&mut arg0.treasury_cap, 0x2::coin::split<SUSTATETOKEN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUSTATETOKEN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUSTATETOKEN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUSTATETOKEN>(v0);
        };
    }

    fun name_generator(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, arg0);
        v0
    }

    public entry fun renounce_ownership(arg0: OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let OwnerCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::make_immutable(arg0);
    }

    public entry fun team_vesting(arg0: &OwnerCap, arg1: &mut Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.team_distribution;
        let v1 = calculate_vesting_amount(v0, 0x2::clock::timestamp_ms(arg2));
        assert!(v1 > 0, 2);
        0x2::coin::mint_and_transfer<SUSTATETOKEN>(&mut arg1.treasury_cap, v1, arg1.team_distribution.account, arg3);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public entry fun unlock(arg0: &mut Global, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUSTATETOKEN>>(0x2::coin::take<SUSTATETOKEN>(&mut arg1.balance, 0x2::balance::value<SUSTATETOKEN>(&arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        arg1.is_claimed = true;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&arg1.id)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

