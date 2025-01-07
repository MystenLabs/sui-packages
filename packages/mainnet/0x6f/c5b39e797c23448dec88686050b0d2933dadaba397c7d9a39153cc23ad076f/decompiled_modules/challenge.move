module 0x6fc5b39e797c23448dec88686050b0d2933dadaba397c7d9a39153cc23ad076f::challenge {
    struct Global has key {
        id: 0x2::object::UID,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        rank_20: vector<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>,
        reward_20: vector<u64>,
        publish_time: u64,
        lock: bool,
        version: u64,
        manager: address,
    }

    public fun calculate_score(arg0: &Global, arg1: u64) : u64 {
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) > arg1 - 1, 5);
        0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_gold_cost(0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, arg1 - 1)) * get_base_weight_by_rank(arg1)
    }

    public fun calculate_scores(arg0: &Global) : u64 {
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) == 20, 5);
        let v0 = 1;
        let v1 = 0;
        while (v0 <= 20) {
            v1 = 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_gold_cost(0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, v0 - 1)) * get_base_weight_by_rank(v0) + v1;
            v0 = v0 + 1;
        };
        v1
    }

    public fun change_manager(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.manager = arg1;
    }

    fun check_lineup_equality(arg0: &0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp, arg1: &0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp) : bool {
        0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_hash(arg0) == 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_hash(arg1) && 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_name(arg0) == 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_name(arg1) && 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_creator(arg0) == 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_creator(arg1)
    }

    public fun find_rank(arg0: &Global, arg1: &0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp) : u64 {
        let v0 = 20;
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) == v0, 5);
        let v1 = 0;
        while (v1 < v0) {
            if (check_lineup_equality(0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, v1), arg1)) {
                return v1 + 1
            };
            v1 = v1 + 1;
        };
        21
    }

    public fun generate_rank_20_description(arg0: &Global) : 0x1::string::String {
        let v0 = 0x1::ascii::byte(0x1::ascii::char(44));
        let v1 = 0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20);
        assert!(v1 == 20, 5);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u8>();
        while (v2 < v1) {
            let v4 = 0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, v2);
            let v5 = 0x2::address::to_string(0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_creator(v4));
            let v6 = 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_name(v4);
            let v7 = 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_roles(v4);
            0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&v5));
            0x1::vector::push_back<u8>(&mut v3, v0);
            0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&v6));
            0x1::vector::push_back<u8>(&mut v3, v0);
            0x1::vector::append<u8>(&mut v3, 0xfcb7d5a9a0977ec7baa77058e7984c98eaa1f703ddd0912946b6f7ef01a53ac0::utils::numbers_to_ascii_vector(v2 + 1));
            0x1::vector::push_back<u8>(&mut v3, v0);
            let v8 = 0;
            assert!(0x1::vector::length<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(v7) == 6, 5);
            while (v8 < 6) {
                let v9 = 0x1::vector::borrow<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(v7, v8);
                let v10 = 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::get_class(v9);
                0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&v10));
                0x1::vector::push_back<u8>(&mut v3, 0x1::ascii::byte(0x1::ascii::char(95)));
                0x1::vector::append<u8>(&mut v3, 0xfcb7d5a9a0977ec7baa77058e7984c98eaa1f703ddd0912946b6f7ef01a53ac0::utils::numbers_to_ascii_vector((0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::get_level(v9) as u64)));
                0x1::vector::push_back<u8>(&mut v3, v0);
                v8 = v8 + 1;
            };
            0x1::vector::append<u8>(&mut v3, 0xfcb7d5a9a0977ec7baa77058e7984c98eaa1f703ddd0912946b6f7ef01a53ac0::utils::numbers_to_ascii_vector(calculate_score(arg0, v2 + 1)));
            0x1::vector::push_back<u8>(&mut v3, 0x1::ascii::byte(0x1::ascii::char(59)));
            v2 = v2 + 1;
        };
        0x1::string::utf8(v3)
    }

    fun get_base_weight_by_rank(arg0: u64) : u64 {
        20 - arg0 / 2
    }

    public fun get_lineup_by_rank(arg0: &Global, arg1: u8) : &0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp {
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) >= (arg1 as u64), 5);
        0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, (arg1 as u64) - 1)
    }

    public fun get_reward_amount_by_rank(arg0: &Global, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) >= arg3, 5);
        arg1 * 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::get_gold_cost(0x1::vector::borrow<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20, arg3 - 1)) * get_base_weight_by_rank(arg3) / arg2 - 1000000000
    }

    public fun get_rewards_balance(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id           : 0x2::object::new(arg0),
            balance_SUI  : 0x2::balance::zero<0x2::sui::SUI>(),
            rank_20      : 0x1::vector::empty<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(),
            reward_20    : 0x1::vector::empty<u64>(),
            publish_time : 0,
            lock         : false,
            version      : 1,
            manager      : @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun init_rank_20(arg0: &0x2::random::Random, arg1: &mut Global, arg2: &0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Global, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 60;
        let v2 = 1;
        arg1.publish_time = 0x2::clock::timestamp_ms(arg3);
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg1.rank_20) == 0, 4);
        while (v0 < 20) {
            0x1::vector::push_back<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&mut arg1.rank_20, 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::generate_lineup_by_power(arg2, v1, arg0, arg4));
            v1 = v1 - 2;
            v2 = v2 + 1;
            v0 = v0 + 1;
        };
    }

    public fun lock_pool(arg0: &mut Global) {
        arg0.lock = true;
    }

    public fun push_reward_amount(arg0: &mut Global, arg1: u64) {
        assert!(!arg0.lock, 3);
        0x1::vector::push_back<u64>(&mut arg0.reward_20, arg1);
    }

    public entry fun query_left_challenge_time(arg0: &Global, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 86400000 * 20;
        if (v0 - arg0.publish_time >= v1) {
            0
        } else {
            v1 - v0 - arg0.publish_time
        }
    }

    public fun rank_forward(arg0: &mut Global, arg1: 0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp) {
        assert!(!arg0.lock, 3);
        let v0 = find_rank(arg0, &arg1);
        0x1::debug::print<u64>(&v0);
        if (v0 == 21) {
            0x1::vector::pop_back<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&mut arg0.rank_20);
            0x1::vector::push_back<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&mut arg0.rank_20, arg1);
        } else if (v0 > 1) {
            let v1 = v0 - 1;
            0x1::vector::remove<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&mut arg0.rank_20, v1);
            0x1::vector::insert<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&mut arg0.rank_20, arg1, v1 - 1);
        };
    }

    public fun send_reward_by_rank(arg0: &mut Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0xaf36d4297f1d3b3cc24d80f57b2b063f5e5d2e0ec1715ea35979871804932e59::lineup::LineUp>(&arg0.rank_20) >= (arg1 as u64), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, *0x1::vector::borrow<u64>(&arg0.reward_20, (arg1 as u64) - 1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun split_amount(arg0: &mut Global, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun top_up_challenge_pool(arg0: &mut Global, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1);
    }

    public fun upgradeVersion(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

