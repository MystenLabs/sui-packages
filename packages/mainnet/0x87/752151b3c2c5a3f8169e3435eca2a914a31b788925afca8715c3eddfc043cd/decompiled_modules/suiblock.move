module 0x87752151b3c2c5a3f8169e3435eca2a914a31b788925afca8715c3eddfc043cd::suiblock {
    struct SUIBLOCK has drop {
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
        treasury_cap: 0x2::coin::TreasuryCap<SUIBLOCK>,
        team_distribution: Distribution,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        balance: 0x2::balance::Balance<SUIBLOCK>,
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

    public entry fun burn(arg0: &mut Global, arg1: 0x2::coin::Coin<SUIBLOCK>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SUIBLOCK>(&arg1) >= arg2, 5);
        0x2::coin::burn<SUIBLOCK>(&mut arg0.treasury_cap, 0x2::coin::split<SUIBLOCK>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<SUIBLOCK>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIBLOCK>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIBLOCK>(arg1);
        };
    }

    fun calculate_total_vesting_time(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            (arg1 - arg0) / 5259600000
        } else {
            0
        }
    }

    fun calculate_vesting_amount(arg0: &mut Distribution, arg1: u64) : u64 {
        assert!(arg0.vesting.released_amount < arg0.vesting.total_amount, 8);
        let v0 = arg0.vesting.tge_percent;
        assert!(arg1 > arg0.vesting.vesting_start, 0);
        if (v0 > 0 && arg0.vesting.tge_status) {
            let v2 = 0x87752151b3c2c5a3f8169e3435eca2a914a31b788925afca8715c3eddfc043cd::math::mul_div(arg0.vesting.total_amount, v0, 100);
            arg0.vesting.released_amount = arg0.vesting.released_amount + v2;
            arg0.vesting.tge_status = false;
            v2
        } else {
            let v3 = calculate_total_vesting_time(arg0.vesting.last_completed_period, arg1);
            assert!(v3 > 0, 1);
            let v4 = arg0.vesting.last_completed_period + v3 * 5259600000;
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

    fun init(arg0: SUIBLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1648585827424030720/x11UMRUD_400x400.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<SUIBLOCK>(arg0, 9, b"SBK", b"SUIBLOCK", b"2k NFT are going to enter in Sui ecosystem with the Utility of $SBK", v0, arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 206000000000000, @0x9a13436a5d2bb25713a362312e77ec9b5419af56737cabb6f74d07a0c177e5bd, arg1);
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 103000000000000, @0x1132b58f5a43e22565741c7e8a54437f77fb71f42074fb93985d84f7c4a096d9, arg1);
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 52000000000000, @0x3dbf6c6b1725a6e41b997bb555b21c30a15b22c6322811704c55956d09fb030c, arg1);
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 155000000000000, @0xdc28eabd92b42af1dec9cdcde3f79846992ac7cce3a79df6f0c5c125d4132bcb, arg1);
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 21000000000000, @0x1101f0cbbb8d151872e9fdc8c43ebe696e970771954f361392fae7a38c2111e2, arg1);
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut v3, 308000000000000, @0x193c1776e72c93a546efff447bd1bcb2287874485a3d2d5452cf4c357319559f, arg1);
        let v4 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<OwnerCap>(v4, @0x3f1c5161e48ec78d5ff6f8dba41927b3c0f09d164e4e31cb6c8e2724e30b2592);
        let v5 = VestingMap{
            total_amount          : 155000000000000,
            released_amount       : 0,
            vesting_start         : 1687651200000,
            last_completed_period : 1687651200000,
            tge_status            : true,
            tge_percent           : 20,
            cycle_amount          : 0x87752151b3c2c5a3f8169e3435eca2a914a31b788925afca8715c3eddfc043cd::math::mul_div(155000000000000, 20, 1000),
        };
        let v6 = Distribution{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(b"Team"),
            account : @0x515c8bff34345b365a3737d24737428551662d897bc249c14cbe24e6c3ca470a,
            vesting : v5,
        };
        let v7 = Global{
            id                : 0x2::object::new(arg1),
            treasury_cap      : v3,
            team_distribution : v6,
        };
        0x2::transfer::public_share_object<Global>(v7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLOCK>>(v2);
    }

    public entry fun lock(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<SUIBLOCK>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(arg5 > 0, 4);
        assert!(0x2::coin::value<SUIBLOCK>(&arg4) >= arg5, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = Lock{
            id             : v1,
            name           : v2,
            owner          : v0,
            amount         : arg5,
            balance        : 0x2::balance::zero<SUIBLOCK>(),
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::balance::join<SUIBLOCK>(&mut v3.balance, 0x2::coin::into_balance<SUIBLOCK>(0x2::coin::split<SUIBLOCK>(&mut arg4, arg5, arg6)));
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
        if (0x2::coin::value<SUIBLOCK>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIBLOCK>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<SUIBLOCK>(arg4);
        };
    }

    public entry fun multi_burn(arg0: &mut Global, arg1: vector<0x2::coin::Coin<SUIBLOCK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIBLOCK>>(&mut arg1);
        0x2::pay::join_vec<SUIBLOCK>(&mut v0, arg1);
        0x2::coin::burn<SUIBLOCK>(&mut arg0.treasury_cap, 0x2::coin::split<SUIBLOCK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIBLOCK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIBLOCK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIBLOCK>(v0);
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
        0x2::coin::mint_and_transfer<SUIBLOCK>(&mut arg1.treasury_cap, v1, arg1.team_distribution.account, arg3);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public entry fun unlock(arg0: &mut Global, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBLOCK>>(0x2::coin::take<SUIBLOCK>(&mut arg1.balance, 0x2::balance::value<SUIBLOCK>(&arg1.balance), arg3), arg1.owner);
        arg1.is_claimed = true;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&arg1.id)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

