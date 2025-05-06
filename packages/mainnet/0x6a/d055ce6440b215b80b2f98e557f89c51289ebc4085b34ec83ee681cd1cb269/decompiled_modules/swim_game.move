module 0x6ad055ce6440b215b80b2f98e557f89c51289ebc4085b34ec83ee681cd1cb269::swim_game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        rounds: 0x2::table::Table<u64, address>,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        token_reserved: 0x2::balance::Balance<T0>,
        enable: bool,
    }

    struct Round has key {
        id: 0x2::object::UID,
    }

    struct Player has copy, drop, store {
        amount: u64,
        swim_id: u8,
        claimed: bool,
        user_address: address,
    }

    struct RoundStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoundState has store {
        index: u64,
        start_time: u64,
        bet_duration: u64,
        last_updated: u64,
        win_id: u8,
        min_bet: u64,
        max_bet: u64,
        multiplier: u64,
        total_bet_amount: u64,
        max_lane: u8,
        predict_index: u64,
        players: 0x2::table::Table<u64, Player>,
    }

    struct InitEvent has copy, drop {
        sender: address,
    }

    struct RoundCreated has copy, drop {
        round_id: 0x2::object::ID,
        index: u64,
        start_time: u64,
        bet_duration: u64,
        last_updated: u64,
        win_id: u8,
        min_bet: u64,
        max_bet: u64,
        max_lane: u8,
        multiplier: u64,
    }

    struct BetCreated has copy, drop {
        round_id: 0x2::object::ID,
        created_time: u64,
        user_address: address,
        bet_value: u64,
        total_bet_value: u64,
        swim_id: u8,
        predict_index: u64,
    }

    struct RoundEnd has copy, drop {
        round_id: 0x2::object::ID,
        end_time: u64,
        win_id: u8,
    }

    struct ClaimReward has copy, drop {
        round_id: 0x2::object::ID,
        user_address: address,
        amount: u64,
        predict_index: u64,
    }

    struct Withdrawal has copy, drop {
        round_id: 0x2::object::ID,
        user_address: address,
        amount: u64,
        predict_index: u64,
    }

    public entry fun bet<T0>(arg0: &mut Vault<T0>, arg1: &mut Round, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = round_state_mut(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.enable, 4040);
        assert!(arg3 > 0, 2102);
        assert!(v0.start_time + v0.bet_duration > v1, 2001);
        let v2 = v0.predict_index + 1;
        v0.predict_index = v2;
        let v3 = 0x2::coin::value<T0>(&arg2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = Player{
            amount       : v3,
            swim_id      : arg3,
            claimed      : false,
            user_address : v4,
        };
        assert!(v5.amount >= v0.min_bet && v5.amount <= v0.max_bet, 2000);
        deposit_coin<T0>(arg0, arg2);
        v0.total_bet_amount = v0.total_bet_amount + v3;
        update_round_player(v0, v2, v5);
        let v6 = BetCreated{
            round_id        : 0x2::object::id<Round>(arg1),
            created_time    : v1,
            user_address    : v4,
            bet_value       : v3,
            total_bet_value : v5.amount,
            swim_id         : arg3,
            predict_index   : v2,
        };
        0x2::event::emit<BetCreated>(v6);
    }

    public entry fun claim_coin<T0>(arg0: &mut Vault<T0>, arg1: &mut Round, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enable, 4040);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<Round>(arg1);
        let v2 = round_state_mut(arg1);
        assert!(v2.win_id > 0, 2200);
        let v3 = 0x2::table::borrow_mut<u64, Player>(&mut v2.players, arg2);
        assert!(v3.user_address == v0, 4004);
        assert!(!v3.claimed, 3400);
        v3.claimed = true;
        if (v3.swim_id == v2.win_id) {
            let v4 = v2.multiplier * v3.amount / 10000;
            assert!(v4 > 0, 2300);
            assert!(0x2::balance::value<T0>(&arg0.token_reserved) >= v4, 2311);
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserved, v4), arg4), arg4);
            let v5 = ClaimReward{
                round_id      : v1,
                user_address  : v0,
                amount        : v4,
                predict_index : arg2,
            };
            0x2::event::emit<ClaimReward>(v5);
        } else {
            assert!(v2.last_updated + 604800000 <= 0x2::clock::timestamp_ms(arg3), 3000);
            assert!(v3.amount > 0, 2300);
            assert!(0x2::balance::value<T0>(&arg0.token_reserved) >= v3.amount, 2311);
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserved, v3.amount), arg4), arg4);
            let v6 = Withdrawal{
                round_id      : v1,
                user_address  : v0,
                amount        : v3.amount,
                predict_index : arg2,
            };
            0x2::event::emit<Withdrawal>(v6);
        };
    }

    public entry fun create_round(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg3 > 0, 1001);
        assert!(arg4 < arg5, 2000);
        assert!(arg6 > 0, 1101);
        assert!(!0x2::table::contains<u64, address>(&arg0.rounds, arg1), 2400);
        let v1 = RoundState{
            index            : arg1,
            start_time       : arg2,
            bet_duration     : arg3,
            last_updated     : v0,
            win_id           : 0,
            min_bet          : arg4,
            max_bet          : arg5,
            multiplier       : arg7,
            total_bet_amount : 0,
            max_lane         : arg6,
            predict_index    : 0,
            players          : 0x2::table::new<u64, Player>(arg9),
        };
        let v2 = Round{id: 0x2::object::new(arg9)};
        let v3 = RoundStateKey{dummy_field: false};
        0x2::dynamic_field::add<RoundStateKey, RoundState>(&mut v2.id, v3, v1);
        0x2::table::add<u64, address>(&mut arg0.rounds, arg1, 0x2::object::uid_to_address(&v2.id));
        let v4 = RoundCreated{
            round_id     : 0x2::object::id<Round>(&v2),
            index        : arg1,
            start_time   : arg2,
            bet_duration : arg3,
            last_updated : v0,
            win_id       : 0,
            min_bet      : arg4,
            max_bet      : arg5,
            max_lane     : arg6,
            multiplier   : arg7,
        };
        0x2::event::emit<RoundCreated>(v4);
        0x2::transfer::share_object<Round>(v2);
    }

    fun deposit_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_reserved, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_coin_to_vault<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit_coin<T0>(arg0, arg1);
    }

    public entry fun enable_system<T0>(arg0: &mut AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.enable = arg2;
    }

    public entry fun end_round(arg0: &mut Registry, arg1: &mut Round, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = round_state_mut(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0.start_time + v0.bet_duration < v1, 2101);
        let v2 = 0x2::random::new_generator(arg2, arg4);
        let v3 = 0x2::random::generate_u8_in_range(&mut v2, 1, v0.max_lane);
        v0.last_updated = v1;
        v0.win_id = v3;
        let v4 = RoundEnd{
            round_id : 0x2::object::id<Round>(arg1),
            end_time : v1,
            win_id   : v3,
        };
        0x2::event::emit<RoundEnd>(v4);
    }

    public fun get_round_address(arg0: &Registry, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.rounds, arg1)
    }

    public fun get_round_detail(arg0: &Round) : &RoundState {
        round_state(arg0)
    }

    public fun get_round_index(arg0: &Round) : u64 {
        round_state(arg0).index
    }

    public fun get_round_total_bet(arg0: &Round) : u64 {
        round_state(arg0).total_bet_amount
    }

    public fun get_round_win_id(arg0: &Round) : u8 {
        round_state(arg0).win_id
    }

    public fun get_system_enable<T0>(arg0: &Vault<T0>) : bool {
        arg0.enable
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id     : 0x2::object::new(arg0),
            rounds : 0x2::table::new<u64, address>(arg0),
        };
        0x2::transfer::transfer<Registry>(v1, 0x2::tx_context::sender(arg0));
        let v2 = InitEvent{sender: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<InitEvent>(v2);
    }

    fun round_state(arg0: &Round) : &RoundState {
        let v0 = RoundStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<RoundStateKey, RoundState>(&arg0.id, v0)
    }

    fun round_state_mut(arg0: &mut Round) : &mut RoundState {
        let v0 = RoundStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RoundStateKey, RoundState>(&mut arg0.id, v0)
    }

    public entry fun setupVault<T0>(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id             : 0x2::object::new(arg1),
            token_reserved : 0x2::balance::zero<T0>(),
            enable         : true,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun transfer_registry(arg0: Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Registry>(arg0, arg1);
    }

    fun update_round_player(arg0: &mut RoundState, arg1: u64, arg2: Player) {
        if (0x2::table::contains<u64, Player>(&arg0.players, arg1)) {
            0x2::table::remove<u64, Player>(&mut arg0.players, arg1);
            0x2::table::add<u64, Player>(&mut arg0.players, arg1, arg2);
        } else {
            0x2::table::add<u64, Player>(&mut arg0.players, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

