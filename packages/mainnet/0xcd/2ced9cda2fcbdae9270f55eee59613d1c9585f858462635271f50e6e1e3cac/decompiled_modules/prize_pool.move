module 0xcd2ced9cda2fcbdae9270f55eee59613d1c9585f858462635271f50e6e1e3cac::prize_pool {
    struct DrawExecuted has copy, drop {
        draw_id: vector<u8>,
        winning_ticket: u64,
        total_tickets: u64,
    }

    struct WinnerRegistered has copy, drop {
        draw_id: vector<u8>,
        winner: address,
        amount: u64,
        token_type: vector<u8>,
    }

    struct PrizeClaimed has copy, drop {
        draw_id: vector<u8>,
        winner: address,
        amount: u64,
        token_type: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WinnerRecord has drop, store {
        winner: address,
        amount: u64,
        token_type: vector<u8>,
        claimed: bool,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::bag::Bag,
        draw_ids: vector<vector<u8>>,
        winner_records: vector<WinnerRecord>,
    }

    struct PrizeDeposited has copy, drop {
        amount: u64,
        token_type: vector<u8>,
    }

    public fun admin(arg0: &PrizePool) : address {
        arg0.admin
    }

    fun balance_key<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun claim<T0>(arg0: &mut PrizePool, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = balance_key<T0>();
        let (v2, v3) = find_draw_index(arg0, &arg1);
        assert!(v2, 1);
        let v4 = 0x1::vector::borrow_mut<WinnerRecord>(&mut arg0.winner_records, v3);
        assert!(v4.winner == v0, 2);
        assert!(!v4.claimed, 3);
        assert!(v4.token_type == v1, 2);
        v4.claimed = true;
        let v5 = v4.amount;
        let v6 = PrizeClaimed{
            draw_id    : arg1,
            winner     : v0,
            amount     : v5,
            token_type : v1,
        };
        0x2::event::emit<PrizeClaimed>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), v5), arg2)
    }

    public fun deposit<T0>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        let v0 = balance_key<T0>();
        if (0x2::bag::contains<vector<u8>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg2));
        };
        let v1 = PrizeDeposited{
            amount     : 0x2::coin::value<T0>(&arg2),
            token_type : balance_key<T0>(),
        };
        0x2::event::emit<PrizeDeposited>(v1);
    }

    public fun draw_count(arg0: &PrizePool) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.draw_ids)
    }

    entry fun execute_draw(arg0: &PrizePool, arg1: &AdminCap, arg2: &0x2::random::Random, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 6);
        let v0 = 0x2::random::new_generator(arg2, arg5);
        let v1 = DrawExecuted{
            draw_id        : arg3,
            winning_ticket : 0x2::random::generate_u64_in_range(&mut v0, 0, arg4),
            total_tickets  : arg4,
        };
        0x2::event::emit<DrawExecuted>(v1);
    }

    fun find_draw_index(arg0: &PrizePool, arg1: &vector<u8>) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.draw_ids)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.draw_ids, v0) == *arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_balance<T0>(arg0: &PrizePool) : u64 {
        let v0 = balance_key<T0>();
        if (0x2::bag::contains<vector<u8>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PrizePool{
            id             : 0x2::object::new(arg0),
            admin          : v0,
            balances       : 0x2::bag::new(arg0),
            draw_ids       : 0x1::vector::empty<vector<u8>>(),
            winner_records : 0x1::vector::empty<WinnerRecord>(),
        };
        0x2::transfer::share_object<PrizePool>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun register_winner<T0>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: u64) {
        let v0 = balance_key<T0>();
        assert!(0x2::bag::contains<vector<u8>>(&arg0.balances, v0), 7);
        assert!(0x2::balance::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) >= arg4, 4);
        let (v1, _) = find_draw_index(arg0, &arg2);
        assert!(!v1, 5);
        0x1::vector::push_back<vector<u8>>(&mut arg0.draw_ids, arg2);
        let v3 = WinnerRecord{
            winner     : arg3,
            amount     : arg4,
            token_type : v0,
            claimed    : false,
        };
        0x1::vector::push_back<WinnerRecord>(&mut arg0.winner_records, v3);
        let v4 = WinnerRegistered{
            draw_id    : *0x1::vector::borrow<vector<u8>>(&arg0.draw_ids, 0x1::vector::length<vector<u8>>(&arg0.draw_ids) - 1),
            winner     : arg3,
            amount     : arg4,
            token_type : v0,
        };
        0x2::event::emit<WinnerRegistered>(v4);
    }

    public fun set_admin(arg0: &mut PrizePool, arg1: &AdminCap, arg2: address) {
        arg0.admin = arg2;
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw<T0>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = balance_key<T0>();
        assert!(0x2::bag::contains<vector<u8>>(&arg0.balances, v0), 7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

