module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Game has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        max_round: u64,
        max_steps: u8,
        salary: u64,
        assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        balances: 0x2::bag::Bag,
        player_position: 0x2::vec_map::VecMap<address, u64>,
        cells: 0x2::object_bag::ObjectBag,
        plays: u64,
        skips: 0x2::vec_map::VecMap<address, u8>,
    }

    struct CellAccess has store, key {
        id: 0x2::object::UID,
    }

    struct TurnCap has key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        player: address,
        moved_steps: u8,
        max_steps: u8,
        expired_at: u64,
    }

    struct ActionRequest<T0: copy + drop + store> has key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        player: address,
        pos_index: u64,
        parameters: 0x1::option::Option<T0>,
        settled: bool,
    }

    struct PlayerMoveEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        moved_steps: u8,
        turn_cap_id: 0x2::object::ID,
    }

    struct ActionRequestEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        new_pos_idx: u64,
    }

    public fun new(arg0: &AdminCap, arg1: vector<address>, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Game {
        new_(arg1, arg2, arg3, arg4, arg5)
    }

    public fun balance<T0>(arg0: &Game) : &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0>>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun drop(arg0: Game) {
        let Game {
            id              : v0,
            versions        : _,
            max_round       : _,
            max_steps       : _,
            salary          : _,
            assets          : _,
            balances        : v6,
            player_position : _,
            cells           : v8,
            plays           : _,
            skips           : _,
        } = arg0;
        0x2::bag::destroy_empty(v6);
        0x2::object_bag::destroy_empty(v8);
        0x2::object::delete(v0);
    }

    public fun action_request_add_state<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ActionRequest<T0>, arg1: T1, arg2: T2) {
        0x2::dynamic_field::add<T1, T2>(&mut arg0.id, arg1, arg2);
    }

    public fun action_request_game<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : 0x2::object::ID {
        arg0.game
    }

    public fun action_request_info<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : (0x2::object::ID, address, u64) {
        (arg0.game, arg0.player, arg0.pos_index)
    }

    public fun action_request_parameters<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : &0x1::option::Option<T0> {
        &arg0.parameters
    }

    public fun action_request_parameters_mut<T0: copy + drop + store>(arg0: &mut ActionRequest<T0>) : &mut 0x1::option::Option<T0> {
        &mut arg0.parameters
    }

    public fun action_request_player<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : address {
        arg0.player
    }

    public fun action_request_pos_index<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : u64 {
        arg0.pos_index
    }

    public fun action_request_remove_parameters<T0: copy + drop + store>(arg0: &mut ActionRequest<T0>, arg1: &Game) : T0 {
        0x1::option::extract<T0>(&mut arg0.parameters)
    }

    public fun action_request_remove_state<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ActionRequest<T0>, arg1: T1) : T2 {
        0x2::dynamic_field::remove<T1, T2>(&mut arg0.id, arg1)
    }

    public fun action_request_settled<T0: copy + drop + store>(arg0: &ActionRequest<T0>) : bool {
        arg0.settled
    }

    public fun add_cell<T0: store + key>(arg0: &mut Game, arg1: &AdminCap, arg2: u64, arg3: T0) {
        0x2::object_bag::add<u64, T0>(&mut arg0.cells, arg2, arg3);
    }

    public fun balance_mut<T0>(arg0: &mut Game) : &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun balance_type_contains<T0>(arg0: &Game) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun borrow_cell<T0: store + key>(arg0: &Game, arg1: u64) : &T0 {
        0x2::object_bag::borrow<u64, T0>(&arg0.cells, arg1)
    }

    fun borrow_cell_mut<T0: store + key>(arg0: &mut Game, arg1: u64) : &mut T0 {
        0x2::object_bag::borrow_mut<u64, T0>(&mut arg0.cells, arg1)
    }

    public fun borrow_cell_mut_with_request<T0: store + key, T1: copy + drop + store>(arg0: &mut Game, arg1: &ActionRequest<T1>) : &mut T0 {
        borrow_cell_mut<T0>(arg0, arg1.pos_index)
    }

    public fun borrow_cell_with_request<T0: store + key, T1: copy + drop + store>(arg0: &Game, arg1: &ActionRequest<T1>) : &T0 {
        borrow_cell<T0>(arg0, arg1.pos_index)
    }

    public fun cell_contains_with_type<T0: store + key>(arg0: &Game, arg1: u64) : bool {
        0x2::object_bag::contains_with_type<u64, T0>(&arg0.cells, arg1)
    }

    public fun config_parameter<T0: copy + drop + store>(arg0: &Game, arg1: &mut ActionRequest<T0>, arg2: T0) {
        assert!(0x1::option::is_none<T0>(&arg1.parameters), 110);
        assert!(!arg1.settled, 103);
        0x1::option::fill<T0>(&mut arg1.parameters, arg2);
    }

    public fun current_round(arg0: &Game) : u64 {
        arg0.plays / num_of_players(arg0)
    }

    public fun drop_action_request<T0: copy + drop + store>(arg0: &mut Game, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.settled, 102);
        let ActionRequest {
            id         : v0,
            game       : v1,
            player     : v2,
            pos_index  : _,
            parameters : _,
            settled    : _,
        } = arg1;
        0x2::object::delete(v0);
        roll_game(arg0);
        let v6 = next_player_of(arg0, v2);
        if (0x2::vec_map::contains<address, u8>(&arg0.skips, &v6)) {
            *0x2::vec_map::get_mut<address, u8>(&mut arg0.skips, &v6) = *0x2::vec_map::get<address, u8>(&arg0.skips, &v6) - 1;
            roll_game(arg0);
            if (*0x2::vec_map::get<address, u8>(&arg0.skips, &v6) == 0) {
                let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg0.skips, &v6);
            };
        };
        if (is_gaming_ongoing(arg0)) {
            let v9 = TurnCap{
                id          : 0x2::object::new(arg2),
                game        : v1,
                player      : v6,
                moved_steps : 0,
                max_steps   : arg0.max_steps,
                expired_at  : 0,
            };
            0x2::transfer::transfer<TurnCap>(v9, v6);
        };
    }

    public fun finish_action_by_player<T0: copy + drop + store>(arg0: ActionRequest<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg1), 107);
        assert!(arg0.settled, 102);
        0x2::transfer::transfer<ActionRequest<T0>>(arg0, 0x2::object::id_to_address(&arg0.game));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_gaming_ongoing(arg0: &Game) : bool {
        current_round(arg0) < arg0.max_round
    }

    public fun max_round(arg0: &Game) : u64 {
        arg0.max_round
    }

    public fun max_steps(arg0: &Game) : u8 {
        arg0.max_steps
    }

    fun new_(arg0: vector<address>, arg1: u64, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Game {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        Game{
            id              : 0x2::object::new(arg4),
            versions        : 0x2::vec_set::singleton<u64>(1),
            max_round       : arg1,
            max_steps       : arg2,
            salary          : arg3,
            assets          : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            balances        : 0x2::bag::new(arg4),
            player_position : 0x2::vec_map::from_keys_values<address, u64>(arg0, v0),
            cells           : 0x2::object_bag::new(arg4),
            plays           : 0,
            skips           : 0x2::vec_map::empty<address, u8>(),
        }
    }

    public fun next_player_of(arg0: &Game, arg1: address) : address {
        let v0 = players(arg0);
        let v1 = players(arg0);
        let v2 = &v1;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<address>(v2)) {
            if (0x1::vector::borrow<address>(v2, v3) == &arg1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v4), 101);
                let v5 = 0x1::option::extract<u64>(&mut v4);
                return if (v5 == 0x1::vector::length<address>(&v0) - 1) {
                    *0x1::vector::borrow<address>(&v0, 0)
                } else {
                    *0x1::vector::borrow<address>(&v0, v5 + 1)
                }
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun num_of_cells(arg0: &Game) : u64 {
        0x2::object_bag::length(&arg0.cells)
    }

    public fun num_of_players(arg0: &Game) : u64 {
        let v0 = players(arg0);
        0x1::vector::length<address>(&v0)
    }

    public fun player_balance<T0>(arg0: &Game, arg1: address) : &0x2::balance::Balance<T0> {
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::balance_of<T0>(balance<T0>(arg0), arg1)
    }

    fun player_balance_mut<T0>(arg0: &mut Game, arg1: address) : &mut 0x2::balance::Balance<T0> {
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::balance_of_mut<T0>(balance_mut<T0>(arg0), arg1)
    }

    public fun player_balance_mut_with_request<T0, T1: copy + drop + store>(arg0: &mut Game, arg1: &ActionRequest<T1>) : &mut 0x2::balance::Balance<T0> {
        player_balance_mut<T0>(arg0, arg1.player)
    }

    entry fun player_move(arg0: TurnCap, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, arg0.max_steps);
        arg0.moved_steps = v1;
        let v2 = PlayerMoveEvent{
            game        : arg0.game,
            player      : arg0.player,
            moved_steps : v1,
            turn_cap_id : 0x2::object::id<TurnCap>(&arg0),
        };
        0x2::event::emit<PlayerMoveEvent>(v2);
        0x2::transfer::transfer<TurnCap>(arg0, 0x2::object::id_to_address(&arg0.game));
        v1
    }

    fun player_move_position(arg0: &Game, arg1: address, arg2: u8) : u64 {
        let v0 = *0x2::vec_map::get<address, u64>(&arg0.player_position, &arg1) + (arg2 as u64);
        let v1 = num_of_cells(arg0) - 1;
        if (v0 > v1) {
            v0 - v1 - 1
        } else {
            v0
        }
    }

    public fun player_position(arg0: &Game) : &0x2::vec_map::VecMap<address, u64> {
        &arg0.player_position
    }

    public fun player_position_of(arg0: &Game, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(player_position(arg0), &arg1)
    }

    public fun players(arg0: &Game) : vector<address> {
        0x2::vec_map::keys<address, u64>(&arg0.player_position)
    }

    public fun plays(arg0: &Game) : u64 {
        arg0.plays
    }

    public fun receive_action_request<T0: copy + drop + store>(arg0: &mut Game, arg1: 0x2::transfer::Receiving<ActionRequest<T0>>) : ActionRequest<T0> {
        0x2::transfer::receive<ActionRequest<T0>>(&mut arg0.id, arg1)
    }

    public fun remove_balance<T0>(arg0: &mut Game) : (0x2::balance::Supply<T0>, 0x2::vec_map::VecMap<address, u64>) {
        assert!(!is_gaming_ongoing(arg0), 111);
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::drop<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()))
    }

    public fun remove_cell<T0: store + key>(arg0: &mut Game, arg1: u64) : T0 {
        assert!(!is_gaming_ongoing(arg0), 111);
        0x2::object_bag::remove<u64, T0>(&mut arg0.cells, arg1)
    }

    public fun request_player_action<T0: copy + drop + store>(arg0: &Game, arg1: ActionRequest<T0>) {
        assert!(!arg1.settled, 103);
        assert!(0x1::option::is_some<T0>(&arg1.parameters), 109);
        let (v0, v1, v2) = action_request_info<T0>(&arg1);
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::event::emit_action_request<T0>(v0, v1, v2, *0x1::option::borrow<T0>(&arg1.parameters));
        0x2::transfer::transfer<ActionRequest<T0>>(arg1, v1);
    }

    public fun request_player_move<T0, T1: copy + drop + store>(arg0: &mut Game, arg1: 0x2::transfer::Receiving<TurnCap>, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest<T1> {
        let v0 = 0x2::transfer::receive<TurnCap>(&mut arg0.id, arg1);
        request_player_move_<T0, T1>(arg0, v0, arg2)
    }

    fun request_player_move_<T0, T1: copy + drop + store>(arg0: &mut Game, arg1: TurnCap, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest<T1> {
        let TurnCap {
            id          : v0,
            game        : v1,
            player      : v2,
            moved_steps : v3,
            max_steps   : _,
            expired_at  : _,
        } = arg1;
        0x2::object::delete(v0);
        let v6 = player_position_of(arg0, v2);
        let v7 = player_move_position(arg0, v2, v3);
        update_player_position(arg0, v2, v7);
        let v8 = if (v6 != 0) {
            if (v7 != 0) {
                v7 < v6
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            let v9 = arg0.salary;
            0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::add_balance<T0>(balance_mut<T0>(arg0), v2, v9);
        };
        ActionRequest<T1>{
            id         : 0x2::object::new(arg2),
            game       : v1,
            player     : v2,
            pos_index  : v7,
            parameters : 0x1::option::none<T1>(),
            settled    : false,
        }
    }

    fun roll_game(arg0: &mut Game) {
        arg0.plays = arg0.plays + 1;
    }

    public fun settle_action_request<T0: copy + drop + store>(arg0: &mut ActionRequest<T0>) {
        assert!(!arg0.settled, 103);
        arg0.settled = true;
    }

    public fun settle_game_creation(arg0: Game, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::bag::is_empty(&arg0.balances), 104);
        assert!(arg0.max_steps != 0 && num_of_cells(&arg0) != 0, 100);
        assert!((arg0.max_steps as u64) < num_of_cells(&arg0), 108);
        let v0 = players(&arg0);
        let v1 = *0x1::vector::borrow<address>(&v0, 0);
        let v2 = TurnCap{
            id          : 0x2::object::new(arg3),
            game        : 0x2::object::id<Game>(&arg0),
            player      : v1,
            moved_steps : 0,
            max_steps   : arg0.max_steps,
            expired_at  : 0,
        };
        0x2::transfer::transfer<TurnCap>(v2, v1);
        0x2::transfer::transfer<Game>(arg0, arg2);
    }

    public fun setup_balance<T0>(arg0: &mut Game, arg1: &AdminCap, arg2: 0x2::balance::Supply<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::is_empty<address, u64>(&arg0.player_position), 105);
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>()), 106);
        0x2::bag::add<0x1::type_name::TypeName, 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::BalanceManager<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::new<T0>(arg2, arg4));
        let v0 = 0x2::vec_map::keys<address, u64>(&arg0.player_position);
        0x1::vector::reverse<address>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::balance_manager::add_balance<T0>(balance_mut<T0>(arg0), 0x1::vector::pop_back<address>(&mut v0), arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(v0);
    }

    public fun turn_cap_game(arg0: &TurnCap) : 0x2::object::ID {
        arg0.game
    }

    public fun turn_cap_moved_steps(arg0: &TurnCap) : u8 {
        arg0.moved_steps
    }

    public fun turn_cap_player(arg0: &TurnCap) : address {
        arg0.player
    }

    fun update_player_position(arg0: &mut Game, arg1: address, arg2: u64) {
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.player_position, &arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

