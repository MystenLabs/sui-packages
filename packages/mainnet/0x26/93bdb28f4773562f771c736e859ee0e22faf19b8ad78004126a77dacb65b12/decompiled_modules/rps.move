module 0x2693bdb28f4773562f771c736e859ee0e22faf19b8ad78004126a77dacb65b12::rps {
    struct History has copy, drop, store {
        sender: address,
        bet: 0x1::string::String,
        bet_amount: u64,
        result: 0x1::string::String,
        profit: u64,
        time: u64,
        winning: 0x1::string::String,
    }

    struct RPS has store, key {
        id: 0x2::object::UID,
        fee: u64,
        treasury: address,
        min_bet: u64,
        max_bet: u64,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
        history: 0x2::table::Table<address, 0x2::table::Table<u64, History>>,
        history_all: 0x2::table::Table<u64, History>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut RPS, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun getWinner(arg0: u64, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (vector<u8>, u64) {
        let v0 = 0x2::object::new(arg4);
        let v1 = pseudoRandomNumGenerator(&v0);
        let v2 = get_hash(0x2::clock::timestamp_ms(arg1) + arg2 + 1 + arg3 + 1);
        let v3 = (safe_selection(999, &v2) + (*0x1::vector::borrow<u8>(&v1, 0) as u64)) % 3 + 1;
        let v4 = if (arg0 == v3) {
            b"draw"
        } else if (arg0 == 1 && v3 == 3 || arg0 == 3 && v3 == 2 || arg0 == 2 && v3 == 1) {
            b"win"
        } else {
            b"lose"
        };
        0x2::object::delete(v0);
        (v4, v3)
    }

    public fun get_hash(arg0: u64) : vector<u8> {
        0x1::hash::sha2_256(get_seed(6, arg0))
    }

    fun get_seed(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::string::utf8(b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0;
        while (v2 < arg0) {
            let v3 = (arg1 + v2) % 0x1::string::length(&v0);
            0x1::string::append(&mut v1, 0x1::string::sub_string(&v0, v3, v3 + 1));
            v2 = v2 + 1;
        };
        *0x1::string::bytes(&v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RPS{
            id          : 0x2::object::new(arg0),
            fee         : 0,
            treasury    : @0x0,
            min_bet     : 0,
            max_bet     : 0,
            bank        : 0x2::balance::zero<0x2::sui::SUI>(),
            history     : 0x2::table::new<address, 0x2::table::Table<u64, History>>(arg0),
            history_all : 0x2::table::new<u64, History>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RPS>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play_game(arg0: &mut RPS, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.bank), 0);
        assert!(arg2 >= 1 && arg2 <= 3, 3);
        if (arg0.min_bet > 0) {
            assert!(v0 >= arg0.min_bet, 2);
        };
        if (arg0.max_bet > 0) {
            assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.bank) * arg0.max_bet / 10000, 1);
        };
        let v1 = 0;
        let v2 = 0x2::table::length<u64, History>(&arg0.history_all);
        let v3 = 0;
        if (0x2::table::contains<address, 0x2::table::Table<u64, History>>(&arg0.history, 0x2::tx_context::sender(arg4))) {
            v3 = 0x2::table::length<u64, History>(0x2::table::borrow<address, 0x2::table::Table<u64, History>>(&mut arg0.history, 0x2::tx_context::sender(arg4)));
        };
        let (v4, v5) = getWinner(arg2, arg3, v2, v3, arg4);
        if (b"win" == v4) {
            let v6 = v0 * 2;
            let v7 = if (arg0.fee > 0) {
                v6 / 10000 * arg0.fee
            } else {
                0
            };
            let v8 = v6 - v7;
            v1 = v8;
            0x2::coin::join<0x2::sui::SUI>(&mut arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.bank, v8 - v0, arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.bank, v7, arg4), arg0.treasury);
        } else if (b"lose" == v4) {
            if (arg0.fee > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 / 10000 * arg0.fee, arg4), arg0.treasury);
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        };
        let v9 = vector[b"Rock", b"Paper", b"Scissors"];
        let v10 = vector[b"Rock", b"Paper", b"Scissors"];
        let v11 = History{
            sender     : 0x2::tx_context::sender(arg4),
            bet        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v9, arg2 - 1)),
            bet_amount : v0,
            result     : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v10, v5 - 1)),
            profit     : v1,
            time       : 0x2::clock::timestamp_ms(arg3),
            winning    : 0x1::string::utf8(v4),
        };
        if (0x2::table::contains<address, 0x2::table::Table<u64, History>>(&arg0.history, 0x2::tx_context::sender(arg4))) {
            0x2::table::add<u64, History>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, History>>(&mut arg0.history, 0x2::tx_context::sender(arg4)), v3 + 1, v11);
        } else {
            let v12 = 0x2::table::new<u64, History>(arg4);
            0x2::table::add<u64, History>(&mut v12, 1, v11);
            0x2::table::add<address, 0x2::table::Table<u64, History>>(&mut arg0.history, 0x2::tx_context::sender(arg4), v12);
        };
        0x2::table::add<u64, History>(&mut arg0.history_all, v2 + 1, v11);
        0x2::event::emit<History>(v11);
    }

    fun pseudoRandomNumGenerator(arg0: &0x2::object::UID) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, (*0x1::vector::borrow<u8>(&v0, 0) as u8) % 2);
        v1
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 3);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut RPS, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee = arg2;
    }

    public entry fun set_max_bet(arg0: &AdminCap, arg1: &mut RPS, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_bet = arg2;
    }

    public entry fun set_min_bet(arg0: &AdminCap, arg1: &mut RPS, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.min_bet = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut RPS, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut RPS, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.bank), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.bank, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

