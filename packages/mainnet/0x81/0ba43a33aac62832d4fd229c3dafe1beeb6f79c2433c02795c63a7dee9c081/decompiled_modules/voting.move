module 0x810ba43a33aac62832d4fd229c3dafe1beeb6f79c2433c02795c63a7dee9c081::voting {
    struct SettleCap has store, key {
        id: 0x2::object::UID,
    }

    struct BattleRecord has store, key {
        id: 0x2::object::UID,
        version: u64,
        description: 0x1::string::String,
        deadline: u64,
        settled: bool,
        winner: bool,
        burn: bool,
        uncertain: bool,
        a_queue: vector<address>,
        b_queue: vector<address>,
        a_ins_table: 0x2::table::Table<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        b_ins_table: 0x2::table::Table<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        a_amt_table: 0x2::table::Table<address, u64>,
        b_amt_table: 0x2::table::Table<address, u64>,
        reward_ins: vector<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        reward_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        a_sum: u128,
        b_sum: u128,
    }

    struct Voting has copy, drop {
        voter: address,
        amount: u64,
        option: vector<u8>,
    }

    struct Settle has copy, drop {
        option: vector<u8>,
    }

    struct Withdraw has copy, drop {
        voter: address,
        type: vector<u8>,
        amount: u64,
    }

    struct ClaimReward has copy, drop {
        voter: address,
        type: vector<u8>,
        amount: u64,
    }

    public fun a_sum(arg0: &BattleRecord) : u64 {
        (arg0.a_sum as u64)
    }

    public fun b_sum(arg0: &BattleRecord) : u64 {
        (arg0.b_sum as u64)
    }

    public entry fun claim_reward_a(arg0: &mut BattleRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline, 0);
        assert!(arg0.version == 1, 2);
        assert!(arg0.settled, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg0.winner || arg0.uncertain) {
            let v1 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v1, v0);
            if (arg0.uncertain) {
                0x2::table::remove<address, u64>(&mut arg0.a_amt_table, v0);
            };
            let v2 = Withdraw{
                voter  : v0,
                type   : b"MOVE",
                amount : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v1),
            };
            0x2::event::emit<Withdraw>(v2);
        };
        if (arg0.winner && !arg0.uncertain) {
            let v3 = 0x2::table::remove<address, u64>(&mut arg0.a_amt_table, v0);
            if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.reward_ins, 0)) == v3) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins), v0);
            } else {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins, 0), v3, arg2), v0);
            };
            let v4 = ClaimReward{
                voter  : v0,
                type   : b"MOVE",
                amount : v3,
            };
            0x2::event::emit<ClaimReward>(v4);
        };
    }

    public entry fun claim_reward_b(arg0: &mut BattleRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline, 0);
        assert!(arg0.version == 1, 2);
        assert!(arg0.settled, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!arg0.winner || arg0.uncertain) {
            let v1 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v1, v0);
            if (arg0.uncertain) {
                0x2::table::remove<address, u64>(&mut arg0.b_amt_table, v0);
            };
            let v2 = Withdraw{
                voter  : v0,
                type   : b"MOVE",
                amount : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v1),
            };
            0x2::event::emit<Withdraw>(v2);
        };
        if (!arg0.winner && !arg0.uncertain) {
            let v3 = 0x2::table::remove<address, u64>(&mut arg0.b_amt_table, v0);
            if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.reward_ins, 0)) == v3) {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins), v0);
            } else {
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.reward_ins, 0), v3, arg2), v0);
            };
            let v4 = ClaimReward{
                voter  : v0,
                type   : b"MOVE",
                amount : v3,
            };
            0x2::event::emit<ClaimReward>(v4);
        };
    }

    public fun ddl(arg0: &BattleRecord) : u64 {
        arg0.deadline
    }

    public fun description(arg0: &BattleRecord) : 0x1::string::String {
        arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SettleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SettleCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = BattleRecord{
            id          : 0x2::object::new(arg0),
            version     : 1,
            description : 0x1::string::utf8(b""),
            deadline    : 0,
            settled     : false,
            winner      : false,
            burn        : false,
            uncertain   : false,
            a_queue     : 0x1::vector::empty<address>(),
            b_queue     : 0x1::vector::empty<address>(),
            a_ins_table : 0x2::table::new<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
            b_ins_table : 0x2::table::new<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
            a_amt_table : 0x2::table::new<address, u64>(arg0),
            b_amt_table : 0x2::table::new<address, u64>(arg0),
            reward_ins  : 0x1::vector::empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(),
            reward_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
            a_sum       : 0,
            b_sum       : 0,
        };
        0x2::transfer::public_share_object<BattleRecord>(v1);
    }

    public fun set_ddl(arg0: &SettleCap, arg1: &mut BattleRecord, arg2: u64) {
        arg1.deadline = arg2;
    }

    public entry fun set_uncertain(arg0: SettleCap, arg1: &mut BattleRecord, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.deadline, 0);
        assert!(arg1.version == 1, 2);
        let SettleCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::length<address>(&arg1.a_queue);
        while (v1 > 0) {
            0x1::vector::pop_back<address>(&mut arg1.a_queue);
            v1 = v1 - 1;
        };
        let v2 = 0x1::vector::length<address>(&arg1.b_queue);
        while (v2 > 0) {
            0x1::vector::pop_back<address>(&mut arg1.b_queue);
            v2 = v2 - 1;
        };
        let v3 = Settle{option: b"UNCERTAIN"};
        0x2::event::emit<Settle>(v3);
        arg1.settled = true;
        arg1.uncertain = true;
    }

    public entry fun settle_a_as_winner(arg0: SettleCap, arg1: &mut BattleRecord, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.deadline, 0);
        assert!(arg1.version == 1, 2);
        let SettleCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::length<address>(&arg1.b_queue);
        if (v1 > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1.b_queue);
            let v3 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.b_ins_table, v2);
            0x2::table::remove<address, u64>(&mut arg1.b_amt_table, v2);
            let v4 = v1 - 1;
            while (v4 > 0) {
                let v5 = 0x1::vector::pop_back<address>(&mut arg1.b_queue);
                0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(&mut v3, 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.b_ins_table, v5));
                0x2::table::remove<address, u64>(&mut arg1.b_amt_table, v5);
                v4 = v4 - 1;
            };
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.reward_ins, v3);
        };
        if (arg1.b_sum > 0) {
            let v6 = arg1.b_sum >> 7;
            arg1.b_sum = arg1.b_sum - v6;
            let v7 = 0;
            let v8 = 0x1::vector::length<address>(&arg1.a_queue);
            while (v8 > 0) {
                let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg1.a_amt_table, 0x1::vector::pop_back<address>(&mut arg1.a_queue));
                *v9 = (((*v9 as u128) * arg1.b_sum / arg1.a_sum) as u64);
                v7 = v7 + *v9;
                v8 = v8 - 1;
            };
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.reward_ins, 0), (v6 as u64) + (arg1.b_sum as u64) - v7, arg3), 0x2::tx_context::sender(arg3));
        };
        let v10 = Settle{option: b"MOVE"};
        0x2::event::emit<Settle>(v10);
        arg1.settled = true;
        arg1.winner = true;
    }

    public entry fun settle_b_as_winner(arg0: SettleCap, arg1: &mut BattleRecord, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.deadline, 0);
        assert!(arg1.version == 1, 2);
        let SettleCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::length<address>(&arg1.a_queue);
        if (v1 > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1.a_queue);
            let v3 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.a_ins_table, v2);
            0x2::table::remove<address, u64>(&mut arg1.a_amt_table, v2);
            let v4 = v1 - 1;
            while (v4 > 0) {
                let v5 = 0x1::vector::pop_back<address>(&mut arg1.a_queue);
                0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(&mut v3, 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.a_ins_table, v5));
                0x2::table::remove<address, u64>(&mut arg1.a_amt_table, v5);
                v4 = v4 - 1;
            };
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.reward_ins, v3);
        };
        if (arg1.a_sum > 0) {
            let v6 = arg1.a_sum >> 7;
            arg1.a_sum = arg1.a_sum - v6;
            let v7 = 0;
            let v8 = 0x1::vector::length<address>(&arg1.b_queue);
            while (v8 > 0) {
                let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg1.b_amt_table, 0x1::vector::pop_back<address>(&mut arg1.b_queue));
                *v9 = (((*v9 as u128) * arg1.a_sum / arg1.b_sum) as u64);
                v7 = v7 + *v9;
                v8 = v8 - 1;
            };
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.reward_ins, 0), (v6 as u64) + (arg1.a_sum as u64) - v7, arg3), 0x2::tx_context::sender(arg3));
        };
        let v10 = Settle{option: b"MOVE"};
        0x2::event::emit<Settle>(v10);
        arg1.settled = true;
        arg1.winner = false;
    }

    public fun update_description(arg0: &SettleCap, arg1: &mut BattleRecord, arg2: vector<u8>) {
        arg1.description = 0x1::string::utf8(arg2);
    }

    public entry fun vote_a(arg0: &mut BattleRecord, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, b"MOVE"), 1);
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        let v2 = Voting{
            voter  : v0,
            amount : v1,
            option : b"MOVE",
        };
        0x2::event::emit<Voting>(v2);
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.a_ins_table, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0), arg1);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.a_amt_table, v0);
            *v3 = *v3 + v1;
        } else {
            0x1::vector::push_back<address>(&mut arg0.a_queue, v0);
            0x2::table::add<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.a_ins_table, v0, arg1);
            0x2::table::add<address, u64>(&mut arg0.a_amt_table, v0, v1);
        };
        arg0.a_sum = arg0.a_sum + (v1 as u128);
    }

    public entry fun vote_b(arg0: &mut BattleRecord, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, b"MOVE"), 1);
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        let v2 = Voting{
            voter  : v0,
            amount : v1,
            option : b"MOVE",
        };
        0x2::event::emit<Voting>(v2);
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.b_ins_table, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0), arg1);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.b_amt_table, v0);
            *v3 = *v3 + v1;
        } else {
            0x1::vector::push_back<address>(&mut arg0.b_queue, v0);
            0x2::table::add<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.b_ins_table, v0, arg1);
            0x2::table::add<address, u64>(&mut arg0.b_amt_table, v0, v1);
        };
        arg0.b_sum = arg0.b_sum + (v1 as u128);
    }

    // decompiled from Move bytecode v6
}

