module 0x231e3815d27378aabde5211ed8ef7d2855d8987bc7f5d9f4e92c819358889738::suiwin {
    struct GameData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        min_bet: u64,
        max_bet: u64,
        admin_address: address,
        fee_bp: u64,
    }

    struct Game21 has store, key {
        id: 0x2::object::UID,
        bet: u64,
        d: vector<u8>,
        p: vector<u8>,
    }

    struct Game21_b has store, key {
        id: 0x2::object::UID,
        b: bool,
        bet: u64,
        d: vector<u8>,
        p: vector<u8>,
    }

    struct WLock has key {
        id: 0x2::object::UID,
        data: u64,
    }

    struct Outcome has copy, drop {
        gamenumber: u8,
        bonus: u64,
        coinvalue: u64,
        result: u8,
    }

    struct Outcome21 has copy, drop {
        bet: u64,
        d: vector<u8>,
        p: vector<u8>,
        gamenum: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun Withdraw_admin(arg0: &AdminCap, arg1: &mut WLock, arg2: u64, arg3: &mut GameData, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg1.data, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, arg2, arg4), arg3.admin_address);
        arg1.data = 9999999;
    }

    fun calculate_hand_value(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = 0x1::vector::borrow<u8>(arg0, v2);
            v0 = v0 + card_value(*v3);
            let v4 = 1;
            if (v3 == &v4) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        while (v0 > 21 && v1 > 0) {
            v0 = v0 - 10;
            v1 = v1 - 1;
        };
        v0
    }

    fun card_value(arg0: u8) : u8 {
        if (arg0 == 1) {
            11
        } else if (arg0 >= 11 && arg0 <= 13) {
            10
        } else {
            arg0
        }
    }

    public entry fun change_WL(arg0: &AdminCap, arg1: &mut WLock, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.data = 0x2::tx_context::epoch(arg2);
    }

    public entry fun change_admin_address(arg0: &AdminCap, arg1: address, arg2: &mut GameData) {
        arg2.admin_address = arg1;
    }

    public entry fun change_fee_bp(arg0: &AdminCap, arg1: u64, arg2: &mut GameData, arg3: &mut WLock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg3.data, 4);
        arg2.fee_bp = arg1;
        if (arg2.fee_bp > 30) {
            arg2.fee_bp = 30;
        };
        arg3.data = 9999999;
    }

    public entry fun change_max_bet(arg0: &AdminCap, arg1: u64, arg2: &mut GameData, arg3: &mut WLock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg3.data, 4);
        arg2.max_bet = arg1;
        arg3.data = 9999999;
    }

    public entry fun change_min_bet(arg0: &AdminCap, arg1: u64, arg2: &mut GameData, arg3: &mut WLock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg3.data, 4);
        arg2.min_bet = arg1;
        arg3.data = 9999999;
    }

    fun compared(arg0: &0x2::random::Random, arg1: &mut vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0;
        let v1 = 0x2::random::new_generator(arg0, arg3);
        let v2 = 1;
        while (v0 < 17 && v2 < 5) {
            0x1::vector::push_back<u8>(arg1, 0x2::random::generate_u8_in_range(&mut v1, 1, 13));
            v0 = calculate_hand_value(arg1);
            v2 = v2 + 1;
        };
        let v3 = 3;
        if (v0 > 21) {
            v3 = 1;
        } else if (0x1::vector::length<u8>(arg1) >= 5) {
            let v4 = 21;
            if (v4 < arg2) {
                v3 = 1;
            } else if (v4 == arg2) {
                v3 = 2;
            };
        } else if (v0 < arg2) {
            v3 = 1;
        } else if (v0 == arg2) {
            v3 = 2;
        };
        v3
    }

    fun count_ones(arg0: u8) : u8 {
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + arg0 % 2;
            arg0 = arg0 / 2;
        };
        v0
    }

    entry fun delete_Game21_b(arg0: 0x2::object::ID, arg1: &mut GameData) {
        let Game21_b {
            id  : v0,
            b   : v1,
            bet : _,
            d   : _,
            p   : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game21_b>(&mut arg1.id, arg0);
        assert!(v1, 3);
        0x2::object::delete(v0);
    }

    entry fun game_stake(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) > v0, 0);
        assert!(v0 >= arg1.min_bet && v0 <= arg1.max_bet, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg3);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 0, 1);
        let v3 = if (arg2 == v2) {
            let v4 = v0 / 1000 * (1000 - arg1.fee_bp) * 2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v4, arg4), 0x2::tx_context::sender(arg4));
            v4
        } else {
            0
        };
        let v5 = Outcome{
            gamenumber : 0,
            bonus      : v3,
            coinvalue  : v0,
            result     : v2,
        };
        0x2::event::emit<Outcome>(v5);
    }

    entry fun game_stake_21_double(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let Game21 {
            id  : v0,
            bet : v1,
            d   : v2,
            p   : v3,
        } = 0x2::dynamic_object_field::remove<address, Game21>(&mut arg1.id, 0x2::tx_context::sender(arg3));
        let v4 = v3;
        let v5 = v2;
        0x2::object::delete(v0);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= v1, 1);
        assert!(0x1::vector::length<u8>(&v4) == 2, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
        let v7 = 0x2::random::new_generator(arg0, arg3);
        0x1::vector::push_back<u8>(&mut v4, 0x2::random::generate_u8_in_range(&mut v7, 1, 13));
        let v8 = calculate_hand_value(&v4);
        if (v8 < 22) {
            let v9 = &mut v5;
            let v10 = compared(arg0, v9, v8, arg3);
            if (v10 == 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, (v6 + v1) * 2, arg3), 0x2::tx_context::sender(arg3));
            } else if (v10 == 2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v6 + v1, arg3), 0x2::tx_context::sender(arg3));
            };
        };
        let v11 = Outcome21{
            bet     : v1,
            d       : v5,
            p       : v4,
            gamenum : 1,
        };
        0x2::event::emit<Outcome21>(v11);
    }

    entry fun game_stake_21_hit(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: &mut 0x2::tx_context::TxContext) {
        let Game21 {
            id  : v0,
            bet : v1,
            d   : v2,
            p   : v3,
        } = 0x2::dynamic_object_field::remove<address, Game21>(&mut arg1.id, 0x2::tx_context::sender(arg2));
        let v4 = v3;
        0x2::object::delete(v0);
        let v5 = 0x2::random::new_generator(arg0, arg2);
        0x1::vector::push_back<u8>(&mut v4, 0x2::random::generate_u8_in_range(&mut v5, 1, 13));
        if (calculate_hand_value(&v4) < 22) {
            let v6 = Game21{
                id  : 0x2::object::new(arg2),
                bet : v1,
                d   : v2,
                p   : v4,
            };
            0x2::dynamic_object_field::add<address, Game21>(&mut arg1.id, 0x2::tx_context::sender(arg2), v6);
        };
        let v7 = Outcome21{
            bet     : v1,
            d       : v2,
            p       : v4,
            gamenum : 2,
        };
        0x2::event::emit<Outcome21>(v7);
    }

    entry fun game_stake_21_join(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) > v0 * 2, 0);
        assert!(v0 >= arg1.min_bet && v0 <= arg1.max_bet, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
        let v1 = 0x2::random::new_generator(arg0, arg3);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v1, 1, 13));
        0x1::vector::push_back<u8>(&mut v3, 0x2::random::generate_u8_in_range(&mut v1, 1, 13));
        0x1::vector::push_back<u8>(&mut v3, 0x2::random::generate_u8_in_range(&mut v1, 1, 13));
        if (calculate_hand_value(&v3) == 21) {
            let v4 = Game21_b{
                id  : 0x2::object::new(arg3),
                b   : true,
                bet : v0,
                d   : v2,
                p   : v3,
            };
            0x2::dynamic_object_field::add<0x2::object::ID, Game21_b>(&mut arg1.id, 0x2::object::id<Game21_b>(&v4), v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0 + v0 * 3 / 2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            let v5 = Game21{
                id  : 0x2::object::new(arg3),
                bet : v0,
                d   : v2,
                p   : v3,
            };
            0x2::dynamic_object_field::add<address, Game21>(&mut arg1.id, 0x2::tx_context::sender(arg3), v5);
        };
        let v6 = Outcome21{
            bet     : v0,
            d       : v2,
            p       : v3,
            gamenum : 0,
        };
        0x2::event::emit<Outcome21>(v6);
    }

    entry fun game_stake_21_stand(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: &mut 0x2::tx_context::TxContext) {
        let Game21 {
            id  : v0,
            bet : v1,
            d   : v2,
            p   : v3,
        } = 0x2::dynamic_object_field::remove<address, Game21>(&mut arg1.id, 0x2::tx_context::sender(arg2));
        let v4 = v3;
        let v5 = v2;
        0x2::object::delete(v0);
        let v6 = calculate_hand_value(&v4);
        if (0x1::vector::length<u8>(&v4) >= 5) {
            v6 = 21;
        };
        let v7 = &mut v5;
        let v8 = compared(arg0, v7, v6, arg2);
        if (v8 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v1 * 2, arg2), 0x2::tx_context::sender(arg2));
        } else if (v8 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v1, arg2), 0x2::tx_context::sender(arg2));
        };
        let v9 = Outcome21{
            bet     : v1,
            d       : v5,
            p       : v4,
            gamenum : 4,
        };
        0x2::event::emit<Outcome21>(v9);
    }

    entry fun game_stake_box(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) > v0 * 10, 0);
        assert!(v0 >= arg1.min_bet && v0 <= arg1.max_bet, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
        let v1 = 0x2::random::new_generator(arg0, arg3);
        let v2 = if (90 > 0x2::random::generate_u16_in_range(&mut v1, 0, 999)) {
            let v3 = v0 * 10;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v3, arg3), 0x2::tx_context::sender(arg3));
            v3
        } else {
            0
        };
        let v4 = Outcome{
            gamenumber : 1,
            bonus      : v2,
            coinvalue  : v0,
            result     : 0,
        };
        0x2::event::emit<Outcome>(v4);
    }

    entry fun game_stake_dice(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) > v0 * 6, 0);
        assert!(v0 >= arg1.min_bet && v0 <= arg1.max_bet, 1);
        assert!(arg2 < 63, 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg3);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 0, 5);
        let v3 = if (arg2 & 0x1::u8::pow(2, v2) > 0) {
            let v4 = v0 / 10000 * (1000 - arg1.fee_bp) * 60 / (count_ones(arg2) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v4, arg4), 0x2::tx_context::sender(arg4));
            v4
        } else {
            0
        };
        let v5 = Outcome{
            gamenumber : 2,
            bonus      : v3,
            coinvalue  : v0,
            result     : v2,
        };
        0x2::event::emit<Outcome>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WLock{
            id   : 0x2::object::new(arg0),
            data : 9999999,
        };
        0x2::transfer::share_object<WLock>(v1);
    }

    public entry fun init_GameData(arg0: &AdminCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id            : 0x2::object::new(arg2),
            balance       : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            min_bet       : 10000000,
            max_bet       : 100000000000,
            admin_address : @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44,
            fee_bp        : 15,
        };
        0x2::transfer::share_object<GameData>(v0);
    }

    entry fun transferAdminCap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun up_sui(arg0: &mut GameData, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    // decompiled from Move bytecode v6
}

