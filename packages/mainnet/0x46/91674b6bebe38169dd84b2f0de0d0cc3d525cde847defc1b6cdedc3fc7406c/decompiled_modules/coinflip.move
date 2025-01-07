module 0x4691674b6bebe38169dd84b2f0de0d0cc3d525cde847defc1b6cdedc3fc7406c::coinflip {
    struct Account has store {
        harvest_round: u64,
        contributed: u64,
        refer: address,
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
        g1: address,
        g2: address,
        g3: address,
        g4: address,
        g5: address,
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
        refer_address: address,
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

    public fun join(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg5);
        0x2::pay::join<0x2::sui::SUI>(&mut v1, arg1);
        let v2 = v0 / 100 * 40;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v2, arg0.static_arrange, arg5);
        let v3 = get_mut_account(arg0, 0x2::tx_context::sender(arg5));
        v3.contributed = v3.contributed + v0;
        if (v3.refer == @0x0) {
            v3.refer = arg3;
        };
        let v4 = v0 / 100 * 5;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v4, arg0.g1, arg5);
        let v5 = v0 / 100 * 4;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v5, arg0.g2, arg5);
        let v6 = v0 / 100 * 3;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v6, arg0.g3, arg5);
        let v7 = v0 / 100 * 2;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v7, arg0.g4, arg5);
        let v8 = v0 / 100 * 1;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v8, arg0.g5, arg5);
        let v9 = v0 / 100 * 3;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v9, arg0.node, arg5);
        let v10 = v0 / 100 * 8;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v10, arg0.fund, arg5);
        let v11 = v0 / 1000 * 15;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v11, arg0.top_refers, arg5);
        let v12 = v0 / 1000 * 15;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v12, arg0.top_order, arg5);
        let v13 = v0 / 1000 * 15;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v13, arg0.week_performance, arg5);
        let v14 = v0 / 1000 * 15;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v14, arg0.daily_award, arg5);
        let v15 = v0 / 100;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v15, arg0.insurance, arg5);
        let v16 = v0 / 100 * 5;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v16, arg0.operation, arg5);
        let v17 = v0 / 100 * 2;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v17, arg0.ecosys, arg5);
        if (arg0.bank == @0x0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        } else {
            0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut v1, v0 - v2 - v4 - v5 - v6 - v7 - v8 - v9 - v10 - v11 - v12 - v13 - v14 - v15 - v16 - v17, arg0.bank, arg5);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg0.round_balance = arg0.round_balance + v0;
        let v18 = get_mut_account(arg0, 0x2::tx_context::sender(arg5));
        v18.contributed = v18.contributed + v0;
        let v19 = JoinGame{
            round         : arg0.round,
            player        : 0x2::tx_context::sender(arg5),
            refer         : arg2,
            refer_address : arg3,
            user_stake    : v0,
            rount_balance : arg0.round_balance,
            total_stake   : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<JoinGame>(v19);
    }

    public fun admin(arg0: &HouseData) : address {
        arg0.admin
    }

    public fun admin_deposit(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
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
                refer         : @0x0,
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
            g1                   : @0x0,
            g2                   : @0x0,
            g3                   : @0x0,
            g4                   : @0x0,
            g5                   : @0x0,
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

    public fun update_addresses(arg0: &mut HouseData, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: address, arg8: address, arg9: address, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: address, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg17) == admin(arg0), 1);
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
        arg0.g1 = arg12;
        arg0.g2 = arg13;
        arg0.g3 = arg14;
        arg0.g4 = arg15;
        arg0.g5 = arg16;
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

