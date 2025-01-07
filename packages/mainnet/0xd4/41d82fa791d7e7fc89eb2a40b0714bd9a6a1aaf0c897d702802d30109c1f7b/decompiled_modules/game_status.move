module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status {
    struct NewEndTime has copy, drop {
        ms: u64,
    }

    struct FinalizeWinner has copy, drop {
        rank: u64,
        winner: address,
        shares: u64,
    }

    struct GameStatus has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        is_ended: bool,
        red_envelope_counter: u64,
        last_buyers: 0x2::linked_table::LinkedTable<u64, address>,
    }

    struct Starter has key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_buyer(arg0: &mut GameStatus, arg1: address) {
        let v0 = &mut arg0.last_buyers;
        0x2::linked_table::push_front<u64, address>(v0, arg0.red_envelope_counter, arg1);
        if (0x2::linked_table::length<u64, address>(v0) > 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::winner_count()) {
            let (_, _) = 0x2::linked_table::pop_back<u64, address>(v0);
        };
        arg0.red_envelope_counter = arg0.red_envelope_counter + 1;
    }

    public fun assert_game_is_ended(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 2);
    }

    public fun assert_game_is_not_ended(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.end_time, 3);
    }

    public fun assert_game_is_started(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 1);
    }

    public fun end(arg0: &mut GameStatus, arg1: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg2: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_ended) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg3) > arg0.end_time, 0);
        arg0.start_time = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::max_u64();
        arg0.end_time = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::max_u64();
        let v0 = &mut arg0.last_buyers;
        let v1 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::winner_share_distribution();
        let v2 = 0;
        while (!0x2::linked_table::is_empty<u64, address>(v0)) {
            let (_, v4) = 0x2::linked_table::pop_front<u64, address>(v0);
            let v5 = (*0x1::vector::borrow<u8>(&v1, v2) as u64);
            0x2::transfer::public_transfer<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::FinalWinner>(0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::mint(v4, v5, arg4), v4);
            let v6 = v2 + 1;
            v2 = v6;
            let v7 = FinalizeWinner{
                rank   : v6,
                winner : v4,
                shares : v5,
            };
            0x2::event::emit<FinalizeWinner>(v7);
        };
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::set_ended(arg1);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::set_ended(arg2);
    }

    public fun end_time(arg0: &GameStatus) : u64 {
        arg0.end_time
    }

    public(friend) fun increase_end_time(arg0: &mut GameStatus, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.end_time + 45000;
        let v2 = v1;
        if (v1 > v0 + 600000) {
            v2 = v0 + 600000;
        };
        if (arg0.end_time < v2) {
            let v3 = NewEndTime{ms: v2};
            0x2::event::emit<NewEndTime>(v3);
            arg0.end_time = v2;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Starter{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Starter>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameStatus{
            id                   : 0x2::object::new(arg0),
            start_time           : 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::max_u64(),
            end_time             : 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::max_u64(),
            is_ended             : false,
            red_envelope_counter : 0,
            last_buyers          : 0x2::linked_table::new<u64, address>(arg0),
        };
        0x2::transfer::share_object<GameStatus>(v1);
    }

    public fun is_ended(arg0: &GameStatus) : bool {
        arg0.is_ended
    }

    public fun pre_start(arg0: &mut GameStatus, arg1: &Starter, arg2: u64) {
        arg0.start_time = arg2;
    }

    public fun start(arg0: &mut GameStatus, arg1: Starter, arg2: u64) {
        let Starter { id: v0 } = arg1;
        0x2::object::delete(v0);
        arg0.start_time = arg2;
        arg0.end_time = arg2 + 86400000;
    }

    // decompiled from Move bytecode v6
}

