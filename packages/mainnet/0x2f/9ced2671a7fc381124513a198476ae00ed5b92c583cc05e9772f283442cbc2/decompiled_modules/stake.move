module 0x2f9ced2671a7fc381124513a198476ae00ed5b92c583cc05e9772f283442cbc2::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    struct AdminCapability has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct GlobalConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        total_staked: u64,
        total_unstaked: u64,
        total_karma: u64,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        staked_amount: u64,
        karma: u64,
        start_date: u64,
        end_date: u64,
        option: u64,
        hold_balance: 0x2::balance::Balance<T0>,
        is_unstaked: bool,
        rank: u64,
    }

    struct StakeEvent has copy, drop {
        staked_amount: u64,
        karma: u64,
        start_date: u64,
        end_date: u64,
    }

    struct UnstakeEvent has copy, drop {
        staked_amount: u64,
        karma: u64,
        unstake_date: u64,
    }

    public entry fun stake<T0>(arg0: &mut GlobalConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 3, 2);
        let v0 = 0;
        let v1 = 0;
        if (arg2 == 0) {
            v0 = 100;
            v1 = 2592000000;
        } else if (arg2 == 1) {
            v0 = 150;
            v1 = 7776000000;
        } else if (arg2 == 2) {
            v0 = 200;
            v1 = 15552000000;
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 + v1;
        let v4 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        let v5 = v4 * v0 / 100;
        let v6 = if (v5 < 1000000) {
            0
        } else if (v5 >= 1000000 && v5 < 5000000) {
            1
        } else {
            2
        };
        arg0.total_staked = arg0.total_staked + v4;
        arg0.total_karma = arg0.total_karma + v5;
        let v7 = Stake<T0>{
            id            : 0x2::object::new(arg4),
            staked_amount : v4,
            karma         : v5,
            start_date    : v2,
            end_date      : v3,
            option        : arg2,
            hold_balance  : 0x2::coin::into_balance<T0>(arg1),
            is_unstaked   : false,
            rank          : v6,
        };
        0x2::transfer::public_transfer<Stake<T0>>(v7, 0x2::tx_context::sender(arg4));
        let v8 = StakeEvent{
            staked_amount : v4,
            karma         : v5,
            start_date    : v2,
            end_date      : v3,
        };
        0x2::event::emit<StakeEvent>(v8);
    }

    entry fun create_config<T0>(arg0: &AdminCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig<T0>{
            id             : 0x2::object::new(arg1),
            admin          : arg0.admin,
            total_staked   : 0,
            total_unstaked : 0,
            total_karma    : 0,
        };
        0x2::transfer::share_object<GlobalConfig<T0>>(v0);
    }

    public fun get_karma<T0>(arg0: &mut GlobalConfig<T0>, arg1: &vector<Stake<T0>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Stake<T0>>(arg1)) {
            v0 = v0 + 0x1::vector::borrow<Stake<T0>>(arg1, v1).karma;
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun unstake<T0>(arg0: &mut GlobalConfig<T0>, arg1: &mut Stake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_unstaked == false, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.end_date - arg1.start_date < v0 - arg1.start_date, 0);
        let v1 = arg1.staked_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.hold_balance, v1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = UnstakeEvent{
            staked_amount : v1,
            karma         : arg1.karma,
            unstake_date  : v0,
        };
        0x2::event::emit<UnstakeEvent>(v2);
        arg0.total_unstaked = arg0.total_unstaked + v1;
        arg1.is_unstaked = true;
        arg1.karma = 0;
    }

    // decompiled from Move bytecode v6
}

