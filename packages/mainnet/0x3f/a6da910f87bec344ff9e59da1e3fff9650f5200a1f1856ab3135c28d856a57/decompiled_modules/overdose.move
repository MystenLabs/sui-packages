module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::overdose {
    struct Table<phantom T0> has key {
        id: 0x2::object::UID,
        house: 0x2::object::ID,
        creator: address,
        stake: u64,
        fee_bps: u64,
        seats: u8,
        pills_each: u8,
        turn_ms: u64,
        joinable_until_ms: u64,
        invited: vector<address>,
        players: vector<address>,
        alive: vector<address>,
        turn: u64,
        pills_left: u8,
        deadline_ms: u64,
        pot: 0x2::balance::Balance<T0>,
        status: u8,
    }

    struct TableOpened has copy, drop {
        table: 0x2::object::ID,
        house: 0x2::object::ID,
        creator: address,
        stake: u64,
        seats: u8,
        pills_each: u8,
        turn_ms: u64,
        joinable_until_ms: u64,
        invited: vector<address>,
    }

    struct TableChanged has copy, drop {
        table: 0x2::object::ID,
        players: vector<address>,
        status: u8,
    }

    struct PillPopped has copy, drop {
        table: 0x2::object::ID,
        player: address,
        pills_before: u8,
        bad: bool,
        timed_out: bool,
        alive_after: u8,
    }

    public fun join<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: &mut Table<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.house == 0x2::object::id<0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>>(arg0), 1);
        assert!(arg1.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.joinable_until_ms, 14);
        assert!(0x2::coin::value<T0>(&arg2) == arg1.stake, 3);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_accepting<T0>(arg0, 5, arg1.stake);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x1::vector::contains<address>(&arg1.players, &v0), 4);
        assert!(0x1::vector::is_empty<address>(&arg1.invited) || 0x1::vector::contains<address>(&arg1.invited, &v0), 5);
        0x1::vector::push_back<address>(&mut arg1.players, v0);
        0x2::balance::join<T0>(&mut arg1.pot, 0x2::coin::into_balance<T0>(arg2));
        if (0x1::vector::length<address>(&arg1.players) == (arg1.seats as u64)) {
            arg1.status = 1;
            arg1.alive = arg1.players;
            arg1.turn = 0;
            arg1.pills_left = arg1.seats * arg1.pills_each;
            arg1.deadline_ms = 0x2::clock::timestamp_ms(arg3) + arg1.turn_ms;
        };
        let v1 = TableChanged{
            table   : 0x2::object::id<Table<T0>>(arg1),
            players : arg1.players,
            status  : arg1.status,
        };
        0x2::event::emit<TableChanged>(v1);
    }

    public fun alive<T0>(arg0: &Table<T0>) : &vector<address> {
        &arg0.alive
    }

    public fun call_time<T0>(arg0: &mut Table<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 10);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.deadline_ms, 12);
        take_turn<T0>(arg0, true, true, arg1);
    }

    public fun cancel<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        arg0.status = 4;
        while (!0x1::vector::is_empty<address>(&arg0.players)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, arg0.stake), arg1), 0x1::vector::pop_back<address>(&mut arg0.players));
        };
        let v0 = TableChanged{
            table   : 0x2::object::id<Table<T0>>(arg0),
            players : vector[],
            status  : 4,
        };
        0x2::event::emit<TableChanged>(v0);
    }

    public fun clear<T0>(arg0: Table<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 3 || arg0.status == 4, 9);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        let Table {
            id                : v0,
            house             : _,
            creator           : _,
            stake             : _,
            fee_bps           : _,
            seats             : _,
            pills_each        : _,
            turn_ms           : _,
            joinable_until_ms : _,
            invited           : _,
            players           : _,
            alive             : _,
            turn              : _,
            pills_left        : _,
            deadline_ms       : _,
            pot               : v15,
            status            : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v15);
        0x2::object::delete(v0);
    }

    public fun collect<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: &mut Table<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.house == 0x2::object::id<0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>>(arg0), 1);
        assert!(arg1.status == 2, 13);
        arg1.status = 3;
        let v0 = *0x1::vector::borrow<address>(&arg1.alive, 0);
        let v1 = arg1.players;
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_pvp_fee<T0>(arg0, &mut arg1.pot, &v1, arg1.stake, arg1.fee_bps, arg2);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::record_pvp_result<T0>(arg0, 5, &v1, v0, arg1.stake, 0x2::balance::value<T0>(&arg1.pot));
        let v2 = TableChanged{
            table   : 0x2::object::id<Table<T0>>(arg1),
            players : v1,
            status  : 3,
        };
        0x2::event::emit<TableChanged>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.pot), arg3), v0);
    }

    public fun joinable_until_ms<T0>(arg0: &Table<T0>) : u64 {
        arg0.joinable_until_ms
    }

    public fun keep_open<T0>(arg0: &mut Table<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        arg0.joinable_until_ms = 0x2::clock::timestamp_ms(arg1) + 600000;
    }

    public fun leave<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 != arg0.creator, 8);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.players, &v0);
        assert!(v1, 6);
        0x1::vector::remove<address>(&mut arg0.players, v2);
        let v3 = TableChanged{
            table   : 0x2::object::id<Table<T0>>(arg0),
            players : arg0.players,
            status  : 0,
        };
        0x2::event::emit<TableChanged>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, arg0.stake), arg1)
    }

    public fun on_turn<T0>(arg0: &Table<T0>) : address {
        *0x1::vector::borrow<address>(&arg0.alive, arg0.turn)
    }

    public fun open<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u8, arg4: u64, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 2 && arg2 <= 6, 0);
        assert!(arg3 >= 1 && arg3 <= 3, 0);
        assert!(arg4 >= 30 && arg4 <= 300, 0);
        assert!(0x1::vector::length<address>(&arg5) < (6 as u64), 0);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_accepting<T0>(arg0, 5, 0x2::coin::value<T0>(&arg1));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Table<T0>{
            id                : 0x2::object::new(arg7),
            house             : 0x2::object::id<0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>>(arg0),
            creator           : v0,
            stake             : 0x2::coin::value<T0>(&arg1),
            fee_bps           : 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::fee_bps<T0>(arg0),
            seats             : arg2,
            pills_each        : arg3,
            turn_ms           : arg4 * 1000,
            joinable_until_ms : 0x2::clock::timestamp_ms(arg6) + 600000,
            invited           : arg5,
            players           : v1,
            alive             : vector[],
            turn              : 0,
            pills_left        : 0,
            deadline_ms       : 0,
            pot               : 0x2::coin::into_balance<T0>(arg1),
            status            : 0,
        };
        let v3 = TableOpened{
            table             : 0x2::object::id<Table<T0>>(&v2),
            house             : v2.house,
            creator           : v0,
            stake             : v2.stake,
            seats             : arg2,
            pills_each        : arg3,
            turn_ms           : v2.turn_ms,
            joinable_until_ms : v2.joinable_until_ms,
            invited           : v2.invited,
        };
        0x2::event::emit<TableOpened>(v3);
        0x2::transfer::share_object<Table<T0>>(v2);
    }

    public fun pills_left<T0>(arg0: &Table<T0>) : u8 {
        arg0.pills_left
    }

    public fun players<T0>(arg0: &Table<T0>) : &vector<address> {
        &arg0.players
    }

    entry fun pop<T0>(arg0: &mut Table<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 10);
        assert!(0x2::tx_context::sender(arg3) == *0x1::vector::borrow<address>(&arg0.alive, arg0.turn), 11);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, arg0.pills_left - 1) == 0;
        take_turn<T0>(arg0, v1, false, arg2);
    }

    public fun pot<T0>(arg0: &Table<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun status<T0>(arg0: &Table<T0>) : u8 {
        arg0.status
    }

    fun take_turn<T0>(arg0: &mut Table<T0>, arg1: bool, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = arg0.pills_left;
        let v1 = arg0.turn;
        let v2 = 0x1::vector::remove<address>(&mut arg0.alive, v1);
        let v3 = 0x1::vector::length<address>(&arg0.alive);
        if (arg1) {
            arg0.turn = v1 % v3;
            arg0.pills_left = (v3 as u8) * arg0.pills_each;
            if (v3 == 1) {
                arg0.status = 2;
            };
        } else {
            0x1::vector::insert<address>(&mut arg0.alive, v2, v1);
            arg0.turn = (v1 + 1) % (v3 + 1);
            arg0.pills_left = v0 - 1;
        };
        arg0.deadline_ms = 0x2::clock::timestamp_ms(arg3) + arg0.turn_ms;
        let v4 = PillPopped{
            table        : 0x2::object::id<Table<T0>>(arg0),
            player       : v2,
            pills_before : v0,
            bad          : arg1,
            timed_out    : arg2,
            alive_after  : (0x1::vector::length<address>(&arg0.alive) as u8),
        };
        0x2::event::emit<PillPopped>(v4);
    }

    // decompiled from Move bytecode v7
}

