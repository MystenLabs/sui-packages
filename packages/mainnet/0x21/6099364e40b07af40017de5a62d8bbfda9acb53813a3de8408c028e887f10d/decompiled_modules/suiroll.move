module 0x216099364e40b07af40017de5a62d8bbfda9acb53813a3de8408c028e887f10d::suiroll {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        used_seeds: 0x2::table::Table<vector<u8>, bool>,
        vrf_pubkey: vector<u8>,
    }

    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        treasury: address,
        fee_bp: u64,
        min_stake: u64,
        max_stake: u64,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        player: address,
        stake: 0x2::balance::Balance<T0>,
        seeds: vector<vector<u8>>,
        user_selection: u8,
        start_ts: u64,
        result_submitted: bool,
        random_1: u8,
        random_2: u8,
    }

    struct ConfigUpdated has copy, drop {
        vrf_pubkey: vector<u8>,
    }

    struct HouseDataUpdated has copy, drop {
        treasury: address,
        fee_bp: u64,
        min_stake: u64,
        max_stake: u64,
    }

    struct GameCreated has copy, drop {
        id: 0x2::object::ID,
        stake: u64,
        player: address,
        seeds: vector<vector<u8>>,
        user_selection: u8,
        start_ts: u64,
    }

    fun check_seeds(arg0: &mut Config, arg1: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(arg1, v0);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_seeds, v1), 5);
            0x2::table::add<vector<u8>, bool>(&mut arg0.used_seeds, v1, true);
            v0 = v0 + 1;
        };
    }

    public entry fun fund_house<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun house_fees<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_config(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg2),
            used_seeds : 0x2::table::new<vector<u8>, bool>(arg2),
            vrf_pubkey : 0x2::hex::decode(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun init_house<T0>(arg0: &AdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = House<T0>{
            id        : 0x2::object::new(arg6),
            balance   : 0x2::coin::into_balance<T0>(arg2),
            fees      : 0x2::balance::zero<T0>(),
            treasury  : arg1,
            fee_bp    : arg3,
            min_stake : arg4,
            max_stake : arg5,
        };
        0x2::transfer::share_object<House<T0>>(v0);
    }

    public entry fun play<T0>(arg0: &mut Config, arg1: &mut House<T0>, arg2: vector<vector<u8>>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_seeds(arg0, &arg2);
        assert!(arg3 <= 1, 0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 >= arg1.min_stake && v0 <= arg1.max_stake, 1);
        assert!(house_balance<T0>(arg1) >= v0, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg1.balance, v0));
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = Game<T0>{
            id               : 0x2::object::new(arg6),
            player           : 0x2::tx_context::sender(arg6),
            stake            : v1,
            seeds            : arg2,
            user_selection   : arg3,
            start_ts         : v2,
            result_submitted : false,
            random_1         : 0,
            random_2         : 0,
        };
        let v4 = GameCreated{
            id             : 0x2::object::uid_to_inner(&v3.id),
            stake          : 0x2::balance::value<T0>(&v3.stake),
            player         : 0x2::tx_context::sender(arg6),
            seeds          : arg2,
            user_selection : arg3,
            start_ts       : v2,
        };
        0x2::event::emit<GameCreated>(v4);
        0x2::transfer::share_object<Game<T0>>(v3);
    }

    public entry fun refund<T0>(arg0: &mut Game<T0>, arg1: &mut House<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.start_ts >= 86400000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.stake, stake<T0>(arg0) / 2, arg3), arg0.player);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::withdraw_all<T0>(&mut arg0.stake));
    }

    public entry fun reveal_result<T0>(arg0: &Config, arg1: &mut House<T0>, arg2: &mut Game<T0>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.result_submitted, 6);
        arg2.result_submitted = true;
        let v0 = verify_and_get_random_number(arg0, *0x1::vector::borrow<vector<u8>>(&arg2.seeds, 0), *0x1::vector::borrow<vector<u8>>(&arg3, 0), *0x1::vector::borrow<vector<u8>>(&arg4, 0));
        let v1 = verify_and_get_random_number(arg0, *0x1::vector::borrow<vector<u8>>(&arg2.seeds, 1), *0x1::vector::borrow<vector<u8>>(&arg3, 1), *0x1::vector::borrow<vector<u8>>(&arg4, 1));
        arg2.random_1 = v0;
        arg2.random_2 = v1;
        if (arg2.user_selection == (v0 + v1) % 2) {
            0x2::balance::join<T0>(&mut arg1.fees, 0x2::balance::split<T0>(&mut arg2.stake, 0x2::balance::value<T0>(&arg2.stake) * arg1.fee_bp / 10000));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.stake, stake<T0>(arg2), arg5), arg2.player);
        } else {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::withdraw_all<T0>(&mut arg2.stake));
        };
    }

    public fun stake<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    public entry fun update_config<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        let v0 = 0x2::hex::decode(arg2);
        arg1.vrf_pubkey = v0;
        let v1 = ConfigUpdated{vrf_pubkey: v0};
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public entry fun update_house_data<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        arg1.treasury = arg2;
        arg1.fee_bp = arg3;
        arg1.min_stake = arg4;
        arg1.max_stake = arg5;
        let v0 = HouseDataUpdated{
            treasury  : arg2,
            fee_bp    : arg3,
            min_stake : arg4,
            max_stake : arg5,
        };
        0x2::event::emit<HouseDataUpdated>(v0);
    }

    fun verify_and_get_random_number(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : u8 {
        assert!(0x2::ecvrf::ecvrf_verify(&arg2, &arg1, &arg0.vrf_pubkey, &arg3), 4);
        let v0 = 0x2::hash::blake2b256(&arg2);
        *0x1::vector::borrow<u8>(&v0, 0) % 6 + 1
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.fees, house_fees<T0>(arg1), arg2), arg1.treasury);
    }

    public entry fun withdraw_funds<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3), arg1.treasury);
    }

    // decompiled from Move bytecode v6
}

