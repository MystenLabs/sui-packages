module 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::challenge {
    struct Global has key {
        id: 0x2::object::UID,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        rank_20: vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>,
        reward_20: vector<u64>,
        publish_time: u64,
        lock: bool,
    }

    fun check_lineup_equal(arg0: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp, arg1: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp) : bool {
        0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_hash(arg0) == 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_hash(arg1) && 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_name(arg0) == 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_name(arg1) && 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_creator(arg0) == 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_creator(arg1)
    }

    public fun find_rank(arg0: &Global, arg1: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp) : u64 {
        let v0 = 0;
        while (v0 < 20) {
            if (check_lineup_equal(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, v0), arg1)) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        21
    }

    fun get_base_weight_by_rank(arg0: u64) : u64 {
        20 - arg0 / 2
    }

    public(friend) fun get_lineup_by_rank(arg0: &Global, arg1: u8) : &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp {
        0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, (arg1 as u64))
    }

    public fun get_pool_value(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    public(friend) fun get_reward_amount_by_rank(arg0: &Global, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg1 * 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_price(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, arg3)) * get_base_weight_by_rank(arg3) / arg2 - 1000000000
    }

    public(friend) fun get_total_virtual_scores(arg0: &Global) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 20) {
            v1 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_price(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, v0)) * get_base_weight_by_rank(v0) + v1;
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun get_virtual_scores_by_rank(arg0: &Global, arg1: u64) : u64 {
        0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_price(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, arg1 - 1)) * get_base_weight_by_rank(arg1 - 1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id           : 0x2::object::new(arg0),
            balance_SUI  : 0x2::balance::zero<0x2::sui::SUI>(),
            rank_20      : 0x1::vector::empty<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(),
            reward_20    : 0x1::vector::empty<u64>(),
            publish_time : 0,
            lock         : false,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun init_rank_20(arg0: &mut Global, arg1: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 40;
        let v2 = 1;
        arg0.publish_time = 0x2::clock::timestamp_ms(arg2);
        assert!(0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20) == 0, 4);
        while (v0 < 20) {
            0x1::vector::push_back<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&mut arg0.rank_20, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::generate_lineup_by_power(arg1, v1, v2, arg3));
            v1 = v1 + 2;
            v2 = v2 + 1;
            v0 = v0 + 1;
        };
    }

    public(friend) fun lock_pool(arg0: &mut Global) {
        arg0.lock = true;
    }

    fun numbers_to_ascii_vector(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public(friend) fun push_reward_amount(arg0: &mut Global, arg1: u64) {
        assert!(!arg0.lock, 3);
        0x1::vector::push_back<u64>(&mut arg0.reward_20, arg1);
    }

    public entry fun query_left_challenge_time(arg0: &Global, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 86400000 * 7;
        if (v0 - arg0.publish_time >= v1) {
            0
        } else {
            v1 - v0 - arg0.publish_time
        }
    }

    public entry fun query_rank_20(arg0: &Global) : 0x1::string::String {
        let v0 = 0x1::ascii::byte(0x1::ascii::char(44));
        let v1 = 0;
        let v2 = 0x1::vector::empty<u8>();
        while (v1 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20)) {
            let v3 = 0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&arg0.rank_20, v1);
            let v4 = 0x2::address::to_string(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_creator(v3));
            let v5 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_name(v3);
            let v6 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_roles(v3);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v5));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(v1 + 1));
            0x1::vector::push_back<u8>(&mut v2, v0);
            let v7 = 0;
            while (v7 < 6) {
                let v8 = 0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(v6, v7);
                let v9 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v8);
                0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v9));
                0x1::vector::push_back<u8>(&mut v2, 0x1::ascii::byte(0x1::ascii::char(95)));
                0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector((0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_level(v8) as u64)));
                0x1::vector::push_back<u8>(&mut v2, v0);
                v7 = v7 + 1;
            };
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(get_virtual_scores_by_rank(arg0, v1 + 1)));
            0x1::vector::push_back<u8>(&mut v2, 0x1::ascii::byte(0x1::ascii::char(59)));
            v1 = v1 + 1;
        };
        0x1::string::utf8(v2)
    }

    public(friend) fun rank_forward(arg0: &mut Global, arg1: 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp) {
        assert!(!arg0.lock, 3);
        let v0 = find_rank(arg0, &arg1);
        if (v0 == 21) {
            0x1::vector::pop_back<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&mut arg0.rank_20);
            0x1::vector::insert<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&mut arg0.rank_20, arg1, 19);
        } else if (v0 == 1) {
        } else {
            let v1 = v0 - 1;
            0x1::vector::remove<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&mut arg0.rank_20, v1);
            0x1::vector::insert<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp>(&mut arg0.rank_20, arg1, v1 - 1);
        };
    }

    public(friend) fun send_reward_by_rank(arg0: &mut Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, *0x1::vector::borrow<u64>(&arg0.reward_20, (arg1 as u64))), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun top_up_challenge_pool(arg0: &mut Global, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1);
    }

    public fun withdraw_left_amount(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 2);
        assert!(query_left_challenge_time(arg0, arg1) == 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

