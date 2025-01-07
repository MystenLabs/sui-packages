module 0x29ca6182722e48f34c89b0a0f2bc8c373210693f88dbf0943310bd40ed38da7a::suishiba {
    struct SUISHIBA has drop {
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
        treasury_cap: 0x2::coin::TreasuryCap<SUISHIBA>,
        team_distribution: Distribution,
        airdrop_distribution: 0x2::balance::Balance<SUISHIBA>,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        balance: 0x2::balance::Balance<SUISHIBA>,
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

    public entry fun burn(arg0: &mut Global, arg1: 0x2::coin::Coin<SUISHIBA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SUISHIBA>(&arg1) >= arg2, 5);
        0x2::coin::burn<SUISHIBA>(&mut arg0.treasury_cap, 0x2::coin::split<SUISHIBA>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<SUISHIBA>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUISHIBA>(arg1);
        };
    }

    public fun mint(arg0: &mut Global, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut arg0.treasury_cap, arg1, arg2, arg3);
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
            let v2 = 0x29ca6182722e48f34c89b0a0f2bc8c373210693f88dbf0943310bd40ed38da7a::math::mul_div(arg0.vesting.total_amount, v0, 100);
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

    public entry fun convert(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2bf2703b9791fa5bb8b86704403c37dbe223897e710d9373e960959bc3f2aa60::airsuishiba::AIRSUISHIBA>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 1683895800000, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(0x2::coin::take<SUISHIBA>(&mut arg0.airdrop_distribution, 0x2::coin::value<0x2bf2703b9791fa5bb8b86704403c37dbe223897e710d9373e960959bc3f2aa60::airsuishiba::AIRSUISHIBA>(&arg1), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2bf2703b9791fa5bb8b86704403c37dbe223897e710d9373e960959bc3f2aa60::airsuishiba::AIRSUISHIBA>>(arg1);
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1652612936764997633/fHY1LNIz_400x400.jpg"));
        let (v2, v3) = 0x2::coin::create_currency<SUISHIBA>(arg0, 6, b"SuiShib", b"SuiShiba", b"#SuiShiba is a community-driven meme project. Built by a team of believers, Suishiba is ready to take on any challenge and have some fun along the way!", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v4, 10000000000000000, @0x6a3f09872405b69f5165ebbb3d7187678c5a8cc1ae2c35f5ec4d194874007720, arg1);
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v4, 30000000000000000, @0xcb4d4333ef99c986ee2dc70d82b95b8aa462d8cd1d0bdb50b7d873f64a3f1f41, arg1);
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v4, 15000000000000000, @0xd6dc3d6c02e42721388a5009bfd1a250f251fc95de77d805fe08662ea4a31ae1, arg1);
        let v5 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v5, v0);
        let v6 = VestingMap{
            total_amount          : 15000000000000000,
            released_amount       : 0,
            vesting_start         : 2629800000 * 5 + 1683892800000,
            last_completed_period : 2629800000 * 5 + 1683892800000,
            tge_status            : true,
            tge_percent           : 0,
            cycle_amount          : 0x29ca6182722e48f34c89b0a0f2bc8c373210693f88dbf0943310bd40ed38da7a::math::mul_div(15000000000000000, 10, 100),
        };
        let v7 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(b"Team"),
            account : @0x9c209b816261861e8f9e168b69c0a6299a4141ab8353645030996014a147a024,
            vesting : v6,
        };
        let v8 = Global{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v4,
            team_distribution    : v7,
            airdrop_distribution : 0x2::balance::zero<SUISHIBA>(),
        };
        0x2::balance::join<SUISHIBA>(&mut v8.airdrop_distribution, 0x2::coin::into_balance<SUISHIBA>(0x2::coin::mint<SUISHIBA>(&mut v8.treasury_cap, 30000000000000000, arg1)));
        0x2::transfer::public_share_object<Global>(v8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v3);
    }

    public entry fun lock(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<SUISHIBA>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(arg5 > 0, 4);
        assert!(0x2::coin::value<SUISHIBA>(&arg4) >= arg5, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = Lock{
            id             : v1,
            name           : v2,
            owner          : v0,
            amount         : arg5,
            balance        : 0x2::balance::zero<SUISHIBA>(),
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::balance::join<SUISHIBA>(&mut v3.balance, 0x2::coin::into_balance<SUISHIBA>(0x2::coin::split<SUISHIBA>(&mut arg4, arg5, arg6)));
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
        if (0x2::coin::value<SUISHIBA>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<SUISHIBA>(arg4);
        };
    }

    public entry fun multi_burn(arg0: &mut Global, arg1: vector<0x2::coin::Coin<SUISHIBA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUISHIBA>>(&mut arg1);
        0x2::pay::join_vec<SUISHIBA>(&mut v0, arg1);
        0x2::coin::burn<SUISHIBA>(&mut arg0.treasury_cap, 0x2::coin::split<SUISHIBA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUISHIBA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUISHIBA>(v0);
        };
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
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut arg1.treasury_cap, v1, arg1.team_distribution.account, arg3);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public entry fun unlock(arg0: &mut Global, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(0x2::coin::take<SUISHIBA>(&mut arg1.balance, 0x2::balance::value<SUISHIBA>(&arg1.balance), arg3), arg1.owner);
        arg1.is_claimed = true;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&arg1.id)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

