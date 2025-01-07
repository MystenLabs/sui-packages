module 0xf4be7fe1137969d5933c3c609e2eee088060ee734ebe0ac02f82608d585c4746::foxiverse {
    struct FOXIVERSE has drop {
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
        treasury_cap: 0x2::coin::TreasuryCap<FOXIVERSE>,
        team_distribution: Distribution,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        balance: 0x2::balance::Balance<FOXIVERSE>,
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

    public entry fun burn(arg0: &mut Global, arg1: 0x2::coin::Coin<FOXIVERSE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<FOXIVERSE>(&arg1) >= arg2, 5);
        0x2::coin::burn<FOXIVERSE>(&mut arg0.treasury_cap, 0x2::coin::split<FOXIVERSE>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<FOXIVERSE>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FOXIVERSE>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<FOXIVERSE>(arg1);
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
            let v2 = 0xf4be7fe1137969d5933c3c609e2eee088060ee734ebe0ac02f82608d585c4746::math::mul_div(arg0.vesting.total_amount, v0, 100);
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

    fun init(arg0: FOXIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1614478001181171713/gFTjfcma_400x400.jpg"));
        let (v2, v3) = 0x2::coin::create_currency<FOXIVERSE>(arg0, 9, b"FXV", b"Foxiverse", b"Foxiverse is an NFT collection of 3333 Foxis, coming to the Sui blockchain.", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 25000000000000000, @0xa2c7481a2f14dd8f3c976738ab12ea078c4e342e817cf2b1e483790c05504eb0, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 20000000000000000, @0x36fbc3509e7329976f6b973a509c48b80e4f4607e437b4944fb7ca89362af548, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 5000000000000000, @0x4815cb3f2680bc45e45ab600f4e58feddb61df2f2518b234e78e3126fdcbdb3, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 9000000000000000, @0xce79ce4c4dcdafb6fcd14b3e5793ff9b3682e4e609c8c0da3d4e7381b455305, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 8000000000000000, @0x94633682febfd5caebb84de830822a126b1b59a79dd438fd3701a4b8699b0ed3, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 1000000000000000, @0xe2bde70bcb936b3ef68390946efb9cbf70e4374e8533b1c8ba38cc00aa56418c, arg1);
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut v4, 12000000000000000, @0xc9bb5c8d005503a63cb38667b22ff855593ac126451469e10d702f97bbd99d24, arg1);
        let v5 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v5, v0);
        let v6 = VestingMap{
            total_amount          : 20000000000000000,
            released_amount       : 0,
            vesting_start         : 1683547200000,
            last_completed_period : 1683547200000,
            tge_status            : true,
            tge_percent           : 25,
            cycle_amount          : 0xf4be7fe1137969d5933c3c609e2eee088060ee734ebe0ac02f82608d585c4746::math::mul_div(20000000000000000, 30, 1000),
        };
        let v7 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(b"Team"),
            account : @0x4a64a36bd7c4e1099393c7c98ad970679ff6af64fa669e09c2798640c722abd9,
            vesting : v6,
        };
        let v8 = Global{
            id                : 0x2::object::new(arg1),
            treasury_cap      : v4,
            team_distribution : v7,
        };
        0x2::transfer::public_share_object<Global>(v8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXIVERSE>>(v3);
    }

    public entry fun lock(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<FOXIVERSE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(arg5 > 0, 4);
        assert!(0x2::coin::value<FOXIVERSE>(&arg4) >= arg5, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = Lock{
            id             : v1,
            name           : v2,
            owner          : v0,
            amount         : arg5,
            balance        : 0x2::balance::zero<FOXIVERSE>(),
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::balance::join<FOXIVERSE>(&mut v3.balance, 0x2::coin::into_balance<FOXIVERSE>(0x2::coin::split<FOXIVERSE>(&mut arg4, arg5, arg6)));
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
        if (0x2::coin::value<FOXIVERSE>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FOXIVERSE>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<FOXIVERSE>(arg4);
        };
    }

    public entry fun multi_burn(arg0: &mut Global, arg1: vector<0x2::coin::Coin<FOXIVERSE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<FOXIVERSE>>(&mut arg1);
        0x2::pay::join_vec<FOXIVERSE>(&mut v0, arg1);
        0x2::coin::burn<FOXIVERSE>(&mut arg0.treasury_cap, 0x2::coin::split<FOXIVERSE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<FOXIVERSE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FOXIVERSE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<FOXIVERSE>(v0);
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
        0x2::coin::mint_and_transfer<FOXIVERSE>(&mut arg1.treasury_cap, v1, arg1.team_distribution.account, arg3);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public entry fun unlock(arg0: &mut Global, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<FOXIVERSE>>(0x2::coin::take<FOXIVERSE>(&mut arg1.balance, 0x2::balance::value<FOXIVERSE>(&arg1.balance), arg3), arg1.owner);
        arg1.is_claimed = true;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&arg1.id)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

