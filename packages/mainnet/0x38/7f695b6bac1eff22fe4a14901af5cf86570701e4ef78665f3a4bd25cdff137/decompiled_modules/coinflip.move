module 0x387f695b6bac1eff22fe4a14901af5cf86570701e4ef78665f3a4bd25cdff137::coinflip {
    struct Account has store {
        harvest_round: u64,
        contributed: u64,
        released: u64,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        bank: address,
        static_arrange: address,
        node: address,
        fund: address,
        top_refers: address,
        top_order: address,
        week_performance: address,
        daily_award: address,
        insurance: address,
        operation: address,
        ecosys: address,
        max_threshold: u64,
        min_threshold: u64,
        max_stake: u64,
        min_stake: u64,
        stake_capacity: u64,
        increase_step_x10000: u16,
        decrease_step_x10000: u16,
        round: u64,
        round_balance: u64,
        round_begin_date: u64,
        user_harvest: bool,
        sig_pub_key: vector<u8>,
        accounts: 0x2::vec_map::VecMap<address, Account>,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    struct COINFLIP has drop {
        dummy_field: bool,
    }

    struct JoinGame has copy, drop {
        round: u64,
        player: address,
        refer: 0x1::string::String,
        user_stake: u64,
        rount_balance: u64,
        total_stake: u64,
    }

    struct HarvestEvent has copy, drop {
        player: address,
        amount: u64,
        batch: u64,
    }

    struct NewRound has copy, drop {
        round: u64,
        last_round_balance: u64,
        last_round_begin_date: u64,
        new_round_begin_date: u64,
        last_stake_capacity: u64,
        new_stake_capacity: u64,
    }

    public(friend) fun borrow(arg0: &HouseData) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut(arg0: &mut HouseData) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun balance(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 < arg0.max_threshold, 3);
        assert!(v0 >= arg0.min_stake, 9);
        if (arg0.max_stake > 0) {
            assert!(v0 <= arg0.max_stake, 9);
        };
        let v1 = get_mut_account(arg0, 0x2::tx_context::sender(arg4));
        v1.contributed = v1.contributed + v0;
        if (0x2::clock::timestamp_ms(arg3) > arg0.round_begin_date + 86400) {
            if (arg0.round_balance < arg0.stake_capacity) {
                arg0.stake_capacity = arg0.stake_capacity / 10000 * ((10000 - arg0.decrease_step_x10000) as u64);
            } else if (arg0.round_balance >= arg0.stake_capacity) {
                arg0.stake_capacity = arg0.stake_capacity / 10000 * ((10000 + arg0.increase_step_x10000) as u64);
            };
            arg0.round_balance = 0;
            arg0.round = arg0.round + 1;
            arg0.round_begin_date = arg0.round_begin_date + 86400;
            if (arg0.stake_capacity > max_threshold(arg0)) {
                arg0.stake_capacity = max_threshold(arg0);
            };
            if (arg0.stake_capacity < min_threshold(arg0)) {
                arg0.stake_capacity = min_threshold(arg0);
            };
            let v2 = NewRound{
                round                 : arg0.round,
                last_round_balance    : arg0.round_balance,
                last_round_begin_date : arg0.round_begin_date,
                new_round_begin_date  : arg0.round_begin_date,
                last_stake_capacity   : arg0.stake_capacity,
                new_stake_capacity    : arg0.stake_capacity,
            };
            0x2::event::emit<NewRound>(v2);
        };
        let v3 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::pay::join<0x2::sui::SUI>(&mut v3, arg1);
        let v4 = v0 / 100 * 3;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v4, arg0.node, arg4);
        let v5 = v0 / 100 * 40;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v5, arg0.static_arrange, arg4);
        let v6 = v0 / 100 * 8;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v6, arg0.fund, arg4);
        let v7 = v0 / 100;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v7, arg0.top_refers, arg4);
        let v8 = v0 / 100;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v8, arg0.top_order, arg4);
        let v9 = v0 / 100;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v9, arg0.week_performance, arg4);
        let v10 = v0 / 1000 * 15;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v10, arg0.daily_award, arg4);
        let v11 = v0 / 100;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v11, arg0.insurance, arg4);
        let v12 = v0 / 100 * 5;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v12, arg0.operation, arg4);
        let v13 = v0 / 100 * 2;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v13, arg0.ecosys, arg4);
        if (arg0.bank == @0x0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        } else {
            0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v3, v0 - v4 - v5 - v6 - v7 - v8 - v9 - v10 - v11 - v12 - v13, arg0.bank, arg4);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        };
        arg0.round_balance = arg0.round_balance + v0;
        assert!(arg0.round_balance <= arg0.stake_capacity, 3);
        let v14 = get_mut_account(arg0, 0x2::tx_context::sender(arg4));
        v14.contributed = v14.contributed + v0;
        let v15 = JoinGame{
            round         : arg0.round,
            player        : 0x2::tx_context::sender(arg4),
            refer         : arg2,
            user_stake    : v0,
            rount_balance : arg0.round_balance,
            total_stake   : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<JoinGame>(v15);
    }

    public fun admin(arg0: &HouseData) : address {
        arg0.admin
    }

    public fun bank(arg0: &HouseData) : address {
        arg0.bank
    }

    public(friend) fun borrow_balance_mut(arg0: &mut HouseData) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    public fun decrease_step_x10000(arg0: &HouseData) : u16 {
        arg0.decrease_step_x10000
    }

    entry fun do_harvest(arg0: &mut HouseData, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = harvest(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun get_mut_account(arg0: &mut HouseData, arg1: address) : &mut Account {
        if (!0x2::vec_map::contains<address, Account>(&arg0.accounts, &arg1)) {
            let v0 = Account{
                harvest_round : 0,
                contributed   : 0,
                released      : 0,
            };
            0x2::vec_map::insert<address, Account>(&mut arg0.accounts, arg1, v0);
        };
        0x2::vec_map::get_mut<address, Account>(&mut arg0.accounts, &arg1)
    }

    public fun harvest(arg0: &mut HouseData, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.user_harvest, 10);
        assert!(!0x1::vector::is_empty<u8>(&arg0.sig_pub_key), 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg1, &arg0.sig_pub_key, &v1, 1) == true, 5);
        let v2 = get_mut_account(arg0, v0);
        assert!(arg2 > v2.harvest_round, 8);
        v2.harvest_round = arg2;
        v2.released = v2.released + arg3;
        let v3 = HarvestEvent{
            player : v0,
            amount : arg3,
            batch  : arg2,
        };
        0x2::event::emit<HarvestEvent>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg3), arg4)
    }

    public fun increase_step_x10000(arg0: &HouseData) : u16 {
        arg0.increase_step_x10000
    }

    fun init(arg0: COINFLIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COINFLIP>(arg0, arg1);
        let v0 = HouseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_house_data(arg0: HouseCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseData{
            id                   : 0x2::object::new(arg4),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                : 0x2::tx_context::sender(arg4),
            bank                 : @0x0,
            static_arrange       : @0x0,
            node                 : @0x0,
            fund                 : @0x0,
            top_refers           : @0x0,
            top_order            : @0x0,
            week_performance     : @0x0,
            daily_award          : @0x0,
            insurance            : @0x0,
            operation            : @0x0,
            ecosys               : @0x0,
            max_threshold        : arg1,
            min_threshold        : arg2,
            max_stake            : 0,
            min_stake            : 0,
            stake_capacity       : arg2,
            increase_step_x10000 : 1000,
            decrease_step_x10000 : 1000,
            round                : 1,
            round_balance        : 0,
            round_begin_date     : arg3,
            user_harvest         : true,
            sig_pub_key          : 0x1::vector::empty<u8>(),
            accounts             : 0x2::vec_map::empty<address, Account>(),
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    public fun max_stake(arg0: &HouseData) : u64 {
        arg0.max_stake
    }

    public fun max_threshold(arg0: &HouseData) : u64 {
        arg0.max_threshold
    }

    public fun min_stake(arg0: &HouseData) : u64 {
        arg0.min_stake
    }

    public fun min_threshold(arg0: &HouseData) : u64 {
        arg0.min_threshold
    }

    public fun read_account_released(arg0: &HouseData, arg1: address) : u64 {
        if (!0x2::vec_map::contains<address, Account>(&arg0.accounts, &arg1)) {
            return 0
        };
        0x2::vec_map::get<address, Account>(&arg0.accounts, &arg1).released
    }

    public fun round(arg0: &HouseData) : u64 {
        arg0.round
    }

    public fun round_balance(arg0: &HouseData) : u64 {
        arg0.round_balance
    }

    public fun round_begin_date(arg0: &HouseData) : u64 {
        arg0.round_begin_date
    }

    public fun stake_capacity(arg0: &HouseData) : u64 {
        arg0.stake_capacity
    }

    public fun transfer_admin(arg0: &mut HouseData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.admin = arg1;
    }

    public fun update_addresses(arg0: &mut HouseData, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: address, arg8: address, arg9: address, arg10: address, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == admin(arg0), 1);
        arg0.bank = arg1;
        arg0.static_arrange = arg2;
        arg0.node = arg3;
        arg0.fund = arg4;
        arg0.top_refers = arg5;
        arg0.top_order = arg6;
        arg0.week_performance = arg7;
        arg0.daily_award = arg8;
        arg0.insurance = arg9;
        arg0.operation = arg10;
        arg0.ecosys = arg11;
    }

    public fun update_decrease_step_x10000(arg0: &mut HouseData, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.decrease_step_x10000 = arg1;
    }

    public fun update_increase_step_x10000(arg0: &mut HouseData, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.increase_step_x10000 = arg1;
    }

    public fun update_max_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.max_stake = arg1;
    }

    public fun update_max_threshold(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.max_threshold = arg1;
    }

    public fun update_min_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.min_stake = arg1;
    }

    public fun update_min_threshold(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.min_threshold = arg1;
    }

    public fun update_sig_pub_key(arg0: &mut HouseData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.sig_pub_key = arg1;
    }

    public fun update_user_harvest(arg0: &mut HouseData, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == admin(arg0), 1);
        arg0.user_harvest = arg1;
    }

    public fun user_harvest(arg0: &HouseData) : bool {
        arg0.user_harvest
    }

    public fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == admin(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, balance(arg0), arg1), admin(arg0));
    }

    // decompiled from Move bytecode v6
}

