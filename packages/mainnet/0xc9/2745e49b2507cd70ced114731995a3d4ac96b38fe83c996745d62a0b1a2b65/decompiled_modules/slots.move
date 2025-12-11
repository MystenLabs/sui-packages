module 0xc92745e49b2507cd70ced114731995a3d4ac96b38fe83c996745d62a0b1a2b65::slots {
    struct SpinResult has copy, drop {
        player: address,
        bet_per_line: u64,
        num_lines: u8,
        total_bet: u64,
        grid: vector<u8>,
        winning_lines: vector<WinningLine>,
        scatter_count: u8,
        scatter_payout: u64,
        free_spins_awarded: u8,
        is_free_spin: bool,
        multiplier: u64,
        total_payout: u64,
        fee_amount: u64,
    }

    struct WinningLine has copy, drop, store {
        line_id: u8,
        symbol: u8,
        match_count: u8,
        payout: u64,
    }

    struct FreeSpinsTriggered has copy, drop {
        player: address,
        scatter_count: u8,
        free_spins: u8,
    }

    struct FreeSpinsCompleted has copy, drop {
        player: address,
        total_spins: u8,
        total_winnings: u64,
    }

    struct HouseFunded has copy, drop {
        funder: address,
        amount: u64,
        new_balance: u64,
    }

    struct HouseWithdrawal has copy, drop {
        amount: u64,
        remaining_balance: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct SlotsHouse has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        total_spins: u64,
        total_wagered: u64,
        total_paid: u64,
        biggest_win: u64,
        total_fees_collected: u64,
        fee_bps: u64,
    }

    struct SlotsAdminCap has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
    }

    struct FreeSpinsState has store, key {
        id: 0x2::object::UID,
        player: address,
        spins_remaining: u8,
        original_bet_per_line: u64,
        original_num_lines: u8,
        total_winnings: u64,
    }

    public fun admin_cap_house_id(arg0: &SlotsAdminCap) : 0x2::object::ID {
        arg0.house_id
    }

    fun check_line_match(arg0: u8, arg1: u8, arg2: u8) : (bool, u8, u8) {
        let v0 = if (arg0 == 8) {
            true
        } else if (arg1 == 8) {
            true
        } else {
            arg2 == 8
        };
        if (v0) {
            return (false, 0, 0)
        };
        let v1 = if (arg0 == 7) {
            255
        } else {
            arg0
        };
        let v2 = if (arg1 == 7) {
            255
        } else {
            arg1
        };
        let v3 = if (arg2 == 7) {
            255
        } else {
            arg2
        };
        let v4 = 255;
        if (v1 != 255) {
            v4 = v1;
        };
        if (v2 != 255 && v4 == 255) {
            v4 = v2;
        };
        let v5 = if (v2 != 255) {
            if (v4 != 255) {
                v2 != v4
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            return (false, 0, 0)
        };
        if (v3 != 255 && v4 == 255) {
            v4 = v3;
        };
        let v6 = if (v3 != 255) {
            if (v4 != 255) {
                v3 != v4
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            return (false, 0, 0)
        };
        if (v4 == 255) {
            return (true, 7, 3)
        };
        let v7 = arg0 == v4 || arg0 == 7;
        let v8 = arg1 == v4 || arg1 == 7;
        let v9 = arg2 == v4 || arg2 == 7;
        let v10 = if (v7) {
            if (v8) {
                v9
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            return (true, v4, 3)
        };
        if (v7 && v8) {
            return (true, v4, 2)
        };
        (false, 0, 0)
    }

    fun check_paylines(arg0: &vector<u8>, arg1: u8, arg2: u64) : (vector<WinningLine>, u64) {
        let v0 = 0x1::vector::empty<WinningLine>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = get_payline(v2);
            let (v4, v5, v6) = check_line_match(*0x1::vector::borrow<u8>(arg0, (*0x1::vector::borrow<u8>(&v3, 0) as u64)), *0x1::vector::borrow<u8>(arg0, (*0x1::vector::borrow<u8>(&v3, 1) as u64)), *0x1::vector::borrow<u8>(arg0, (*0x1::vector::borrow<u8>(&v3, 2) as u64)));
            if (v4 && v5 != 8) {
                let v7 = if (v6 == 3) {
                    get_payout_3_match(v5) * arg2
                } else if (v6 == 2) {
                    get_payout_2_match(v5) * arg2
                } else {
                    0
                };
                if (v7 > 0) {
                    let v8 = WinningLine{
                        line_id     : v2,
                        symbol      : v5,
                        match_count : v6,
                        payout      : v7,
                    };
                    0x1::vector::push_back<WinningLine>(&mut v0, v8);
                    v1 = v1 + v7;
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun count_symbol(arg0: &vector<u8>, arg1: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 9) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun execute_spin(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u64, arg3: u64, arg4: u64) : (vector<u8>, vector<WinningLine>, u8, u64, u8) {
        let v0 = generate_grid(arg0);
        let v1 = count_symbol(&v0, 8);
        let (v2, v3) = check_paylines(&v0, arg1, arg2);
        (v0, v2, v1, (v3 + get_scatter_payout(v1) * arg3) * arg4, get_free_spins_award(v1))
    }

    public fun fee_bps(arg0: &SlotsHouse) : u64 {
        arg0.fee_bps
    }

    entry fun free_spin(arg0: &mut SlotsHouse, arg1: FreeSpinsState, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.player == v0, 4);
        assert!(arg1.spins_remaining > 0, 5);
        arg1.spins_remaining = arg1.spins_remaining - 1;
        arg0.total_spins = arg0.total_spins + 1;
        let v1 = arg1.original_bet_per_line;
        let v2 = arg1.original_num_lines;
        let v3 = 0x2::random::new_generator(arg2, arg3);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9) = execute_spin(v4, v2, v1, v1 * (v2 as u64), 3);
        if (v8 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v8) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v8, arg3), v0);
            arg0.total_paid = arg0.total_paid + v8;
            arg1.total_winnings = arg1.total_winnings + v8;
            if (v8 > arg0.biggest_win) {
                arg0.biggest_win = v8;
            };
        };
        if (v9 > 0) {
            arg1.spins_remaining = arg1.spins_remaining + v9;
            let v10 = FreeSpinsTriggered{
                player        : v0,
                scatter_count : v7,
                free_spins    : v9,
            };
            0x2::event::emit<FreeSpinsTriggered>(v10);
        };
        let v11 = SpinResult{
            player             : v0,
            bet_per_line       : v1,
            num_lines          : v2,
            total_bet          : 0,
            grid               : v5,
            winning_lines      : v6,
            scatter_count      : v7,
            scatter_payout     : 0,
            free_spins_awarded : v9,
            is_free_spin       : true,
            multiplier         : 3,
            total_payout       : v8,
            fee_amount         : 0,
        };
        0x2::event::emit<SpinResult>(v11);
        if (arg1.spins_remaining == 0) {
            let v12 = FreeSpinsCompleted{
                player         : v0,
                total_spins    : 10,
                total_winnings : arg1.total_winnings,
            };
            0x2::event::emit<FreeSpinsCompleted>(v12);
            let FreeSpinsState {
                id                    : v13,
                player                : _,
                spins_remaining       : _,
                original_bet_per_line : _,
                original_num_lines    : _,
                total_winnings        : _,
            } = arg1;
            0x2::object::delete(v13);
        } else {
            0x2::transfer::transfer<FreeSpinsState>(arg1, v0);
        };
    }

    public fun free_spins_award() : u8 {
        10
    }

    public fun free_spins_multiplier() : u64 {
        3
    }

    public fun fund_house(arg0: &mut SlotsHouse, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = HouseFunded{
            funder      : 0x2::tx_context::sender(arg2),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    fun generate_grid(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = get_reel_1();
        let v1 = get_reel_2();
        let v2 = get_reel_3();
        let v3 = 0x2::random::generate_u64_in_range(arg0, 0, 32);
        let v4 = 0x2::random::generate_u64_in_range(arg0, 0, 32);
        let v5 = 0x2::random::generate_u64_in_range(arg0, 0, 32);
        let v6 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v0, v3 % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v1, v4 % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v2, v5 % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v0, (v3 + 1) % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v1, (v4 + 1) % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v2, (v5 + 1) % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v0, (v3 + 2) % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v1, (v4 + 2) % 32));
        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v2, (v5 + 2) % 32));
        v6
    }

    fun get_free_spins_award(arg0: u8) : u8 {
        if (arg0 >= 3) {
            10
        } else {
            0
        }
    }

    fun get_payline(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            x"030405"
        } else if (arg0 == 1) {
            x"000102"
        } else if (arg0 == 2) {
            x"060708"
        } else if (arg0 == 3) {
            x"000408"
        } else if (arg0 == 4) {
            x"060402"
        } else {
            x"030405"
        }
    }

    fun get_payout_2_match(arg0: u8) : u64 {
        if (arg0 == 6) {
            10
        } else if (arg0 == 5) {
            5
        } else if (arg0 == 7) {
            10
        } else {
            0
        }
    }

    fun get_payout_3_match(arg0: u8) : u64 {
        if (arg0 == 6) {
            100
        } else if (arg0 == 5) {
            50
        } else if (arg0 == 4) {
            25
        } else if (arg0 == 3) {
            15
        } else if (arg0 == 2) {
            10
        } else if (arg0 == 1) {
            5
        } else if (arg0 == 0) {
            2
        } else if (arg0 == 7) {
            100
        } else {
            0
        }
    }

    fun get_reel_1() : vector<u8> {
        x"0000000000000000010101010101020202020203030303040404050506070808"
    }

    fun get_reel_2() : vector<u8> {
        x"0000000000000000000101010101010202020202030303030404040505060708"
    }

    fun get_reel_3() : vector<u8> {
        x"0000000000000000000001010101010102020202030303030404050506070808"
    }

    fun get_scatter_payout(arg0: u8) : u64 {
        if (arg0 >= 3) {
            5
        } else if (arg0 == 2) {
            2
        } else {
            0
        }
    }

    public fun house_balance(arg0: &SlotsHouse) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun house_owner(arg0: &SlotsHouse) : address {
        arg0.owner
    }

    public fun house_stats(arg0: &SlotsHouse) : (u64, u64, u64, u64) {
        (arg0.total_spins, arg0.total_wagered, arg0.total_paid, arg0.biggest_win)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotsHouse{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                : 0x2::tx_context::sender(arg0),
            total_spins          : 0,
            total_wagered        : 0,
            total_paid           : 0,
            biggest_win          : 0,
            total_fees_collected : 0,
            fee_bps              : 100,
        };
        let v1 = SlotsAdminCap{
            id       : 0x2::object::new(arg0),
            house_id : 0x2::object::id<SlotsHouse>(&v0),
        };
        0x2::transfer::share_object<SlotsHouse>(v0);
        0x2::transfer::transfer<SlotsAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_bet(arg0: &SlotsHouse) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 1 / 100
    }

    public fun max_bet_percent() : u64 {
        1
    }

    public fun min_bet() : u64 {
        1000000
    }

    public fun set_fee(arg0: &mut SlotsHouse, arg1: &SlotsAdminCap, arg2: u64) {
        assert!(arg2 <= 1000, 6);
        arg0.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    entry fun spin(arg0: &mut SlotsHouse, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 3) {
            true
        } else {
            arg2 == 5
        };
        assert!(v0, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = v1 / (arg2 as u64);
        assert!(v2 >= 1000000, 1);
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 1 / 100, 2);
        let v3 = v1 * arg0.fee_bps / 10000;
        let v4 = v1 - v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_wagered = arg0.total_wagered + v1;
        arg0.total_spins = arg0.total_spins + 1;
        arg0.total_fees_collected = arg0.total_fees_collected + v3;
        let v5 = 0x2::random::new_generator(arg3, arg4);
        let v6 = &mut v5;
        let (v7, v8, v9, v10, v11) = execute_spin(v6, arg2, v4 / (arg2 as u64), v4, 1);
        let v12 = 0x2::tx_context::sender(arg4);
        if (v10 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v10) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v10, arg4), v12);
            arg0.total_paid = arg0.total_paid + v10;
            if (v10 > arg0.biggest_win) {
                arg0.biggest_win = v10;
            };
        };
        if (v11 > 0) {
            let v13 = FreeSpinsState{
                id                    : 0x2::object::new(arg4),
                player                : v12,
                spins_remaining       : v11,
                original_bet_per_line : v2,
                original_num_lines    : arg2,
                total_winnings        : 0,
            };
            0x2::transfer::transfer<FreeSpinsState>(v13, v12);
            let v14 = FreeSpinsTriggered{
                player        : v12,
                scatter_count : v9,
                free_spins    : v11,
            };
            0x2::event::emit<FreeSpinsTriggered>(v14);
        };
        let v15 = SpinResult{
            player             : v12,
            bet_per_line       : v2,
            num_lines          : arg2,
            total_bet          : v1,
            grid               : v7,
            winning_lines      : v8,
            scatter_count      : v9,
            scatter_payout     : get_scatter_payout(v9) * v4,
            free_spins_awarded : v11,
            is_free_spin       : false,
            multiplier         : 1,
            total_payout       : v10,
            fee_amount         : v3,
        };
        0x2::event::emit<SpinResult>(v15);
    }

    public fun symbol_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"LEMON"
        } else if (arg0 == 1) {
            b"BELL"
        } else if (arg0 == 2) {
            b"CHERRY"
        } else if (arg0 == 3) {
            b"CLOVER"
        } else if (arg0 == 4) {
            b"STAR"
        } else if (arg0 == 5) {
            b"DIAMOND"
        } else if (arg0 == 6) {
            b"SEVEN"
        } else if (arg0 == 7) {
            b"WILD"
        } else if (arg0 == 8) {
            b"SCATTER"
        } else {
            b"UNKNOWN"
        }
    }

    public fun symbol_payout_2(arg0: u8) : u64 {
        get_payout_2_match(arg0)
    }

    public fun symbol_payout_3(arg0: u8) : u64 {
        get_payout_3_match(arg0)
    }

    public fun total_fees_collected(arg0: &SlotsHouse) : u64 {
        arg0.total_fees_collected
    }

    public fun withdraw(arg0: &mut SlotsHouse, arg1: &SlotsAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        let v0 = HouseWithdrawal{
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseWithdrawal>(v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

