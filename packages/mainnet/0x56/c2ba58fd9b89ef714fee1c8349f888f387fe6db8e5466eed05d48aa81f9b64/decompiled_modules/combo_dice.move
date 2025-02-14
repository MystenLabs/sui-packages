module 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::combo_dice {
    struct Registry has key {
        id: 0x2::object::UID,
        whitelist: vector<address>,
        num_of_playgrounds: u64,
        version: u64,
    }

    struct Playground has store, key {
        id: 0x2::object::UID,
        house_whitelist: vector<address>,
        public_key: vector<u8>,
        num_of_games: u64,
        stake_token: 0x1::type_name::TypeName,
        opened_games: vector<Game>,
        game_config: GameConfig,
        exp_config: ExpConfig,
        is_active: bool,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct GameConfig has copy, drop, store {
        max_stake: u64,
        min_stake: u64,
        stake_lot_size: u64,
        critical_hits_multiplier_bp: u64,
        max_single_game_loss_ratio_bp: u64,
        banker_edge_bp: u64,
        u64_padding: vector<u64>,
    }

    struct ExpConfig has copy, drop, store {
        base_exp_divisor: u64,
        u64_padding: vector<u64>,
    }

    struct Game has store {
        id: 0x2::object::UID,
        game_id: u64,
        player: address,
        stake_amount: u64,
        guess_1: 0x1::option::Option<u64>,
        larger_than_1: 0x1::option::Option<bool>,
        vrf_input_1: 0x1::option::Option<vector<u8>>,
        guess_2: 0x1::option::Option<u64>,
        larger_than_2: 0x1::option::Option<bool>,
        vrf_input_2: 0x1::option::Option<vector<u8>>,
        u64_padding: vector<u64>,
    }

    struct Draw has copy, drop {
        signer: address,
        index: u64,
        game_id: u64,
        public_key: vector<u8>,
        signature_1: vector<u8>,
        signature_2: vector<u8>,
        player: address,
        guess_1: u64,
        larger_than_1: bool,
        answer_1: u64,
        result_1: u64,
        guess_2: u64,
        larger_than_2: bool,
        answer_2: u64,
        result_2: u64,
        stake_amount: u64,
        reward: u64,
        exp_amount: u64,
        u64_padding: vector<u64>,
    }

    struct CloseGame has copy, drop {
        signer: address,
        index: u64,
        game_id: u64,
        player: address,
        refund_amount: u64,
    }

    struct NewPlayground<phantom T0> has copy, drop {
        signer: address,
        playground_object_id: address,
        index: u64,
        game_config: GameConfig,
        u64_padding: vector<u64>,
    }

    struct WithdrawStakes has copy, drop {
        signer: address,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        stakes_before: u64,
        stakes_after: u64,
        u64_padding: vector<u64>,
    }

    struct DepositStakes has copy, drop {
        signer: address,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        stakes_before: u64,
        stakes_after: u64,
        u64_padding: vector<u64>,
    }

    struct ClosePlayground has copy, drop {
        signer: address,
        index: u64,
        num_of_existing_games: u64,
        done: bool,
        u64_padding: vector<u64>,
    }

    struct AddRegistryWhitelist has copy, drop {
        signer: address,
        new_whitelist_users: vector<address>,
    }

    struct RemoveRegistryWhitelist has copy, drop {
        signer: address,
        removed_whitelist_users: vector<address>,
    }

    struct UpdateGameConfig has copy, drop {
        signer: address,
        index: u64,
        previous: GameConfig,
        current: GameConfig,
    }

    struct UpdateExpConfig has copy, drop {
        signer: address,
        index: u64,
        previous: ExpConfig,
        current: ExpConfig,
    }

    struct UpdatePublicKey has copy, drop {
        signer: address,
        index: u64,
        previous_public_key: vector<u8>,
        new_public_key: vector<u8>,
    }

    struct SuspendPlayground has copy, drop {
        signer: address,
        index: u64,
    }

    struct ResumePlayground has copy, drop {
        signer: address,
        index: u64,
    }

    struct AddPlaygroundWhitelist has copy, drop {
        signer: address,
        new_whitelist_users: vector<address>,
    }

    struct RemovePlaygroundWhitelist has copy, drop {
        signer: address,
        removed_whitelist_users: vector<address>,
    }

    struct SetMaxSingleGameLoss has copy, drop {
        signer: address,
        index: u64,
        prev_amount: u64,
        amount: u64,
    }

    struct NewGame<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        game_id: u64,
        player_stake_amount: u64,
        banker_stake_amount: u64,
        u64_padding: vector<u64>,
    }

    struct PlayGuess has copy, drop {
        signer: address,
        index: u64,
        game_id: u64,
        guess_1: u64,
        larger_than_1: bool,
        guess_2: u64,
        larger_than_2: bool,
        vrf_input_1: vector<u8>,
        vrf_input_2: vector<u8>,
        u64_padding: vector<u64>,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public(friend) entry fun add_playground_whitelist(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let v2 = 0x1::vector::empty<address>();
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x1::vector::contains<address>(&v1.house_whitelist, &v3)) {
                0x1::vector::push_back<address>(&mut v1.house_whitelist, v3);
                0x1::vector::push_back<address>(&mut v2, v3);
            };
        };
        let v4 = AddPlaygroundWhitelist{
            signer              : 0x2::tx_context::sender(arg3),
            new_whitelist_users : v2,
        };
        0x2::event::emit<AddPlaygroundWhitelist>(v4);
    }

    public(friend) entry fun add_registry_whitelist(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg2);
        let v0 = 0x1::vector::empty<address>();
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x1::vector::contains<address>(&arg0.whitelist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelist, v1);
                0x1::vector::push_back<address>(&mut v0, v1);
            };
        };
        let v2 = AddRegistryWhitelist{
            signer              : 0x2::tx_context::sender(arg2),
            new_whitelist_users : v0,
        };
        0x2::event::emit<AddRegistryWhitelist>(v2);
    }

    public(friend) entry fun close_game<T0>(arg0: &mut Registry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        while (v2 < 0x1::vector::length<Game>(&v1.opened_games)) {
            if (0x1::vector::borrow<Game>(&v1.opened_games, v2).player == arg2) {
                0x1::vector::push_back<u64>(&mut v3, v2);
            };
            v2 = v2 + 1;
        };
        while (0x1::vector::length<u64>(&v3) > 0) {
            let v4 = 0x1::vector::remove<Game>(&mut v1.opened_games, 0x1::vector::pop_back<u64>(&mut v3));
            close_game_<T0>(v1, arg1, v4, arg3);
        };
    }

    fun close_game_<T0>(arg0: &mut Playground, arg1: u64, arg2: Game, arg3: &mut 0x2::tx_context::TxContext) {
        let Game {
            id            : v0,
            game_id       : v1,
            player        : v2,
            stake_amount  : v3,
            guess_1       : _,
            larger_than_1 : _,
            vrf_input_1   : _,
            guess_2       : _,
            larger_than_2 : _,
            vrf_input_2   : _,
            u64_padding   : _,
        } = arg2;
        let v11 = v0;
        let v12 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v11, 0x1::type_name::get<T0>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v3), arg3), v2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), v12);
        0x2::object::delete(v11);
        let v13 = CloseGame{
            signer        : 0x2::tx_context::sender(arg3),
            index         : arg1,
            game_id       : v1,
            player        : v2,
            refund_amount : v3,
        };
        0x2::event::emit<CloseGame>(v13);
    }

    public(friend) entry fun close_playground<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        if (v1.is_active) {
            v1.is_active = false;
        };
        let v2 = &mut arg0.id;
        let v3 = get_mut_playground(v2, arg1);
        let v4 = 0;
        while (0x1::vector::length<Game>(&v3.opened_games) > 0) {
            let v5 = 0x1::vector::remove<Game>(&mut v3.opened_games, 0);
            close_game_<T0>(v3, arg1, v5, arg3);
            v4 = v4 + 1;
            if (v4 >= arg2) {
                break
            };
        };
        let v6 = 0x1::vector::length<Game>(&v3.opened_games);
        if (v6 > 0) {
            let v7 = ClosePlayground{
                signer                : 0x2::tx_context::sender(arg3),
                index                 : arg1,
                num_of_existing_games : v6,
                done                  : false,
                u64_padding           : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<ClosePlayground>(v7);
        } else {
            withdraw_stakes<T0>(arg0, arg1, 0x1::option::none<u64>(), arg3);
            let _ = &mut arg0.id;
            let v9 = ClosePlayground{
                signer                : 0x2::tx_context::sender(arg3),
                index                 : arg1,
                num_of_existing_games : v6,
                done                  : true,
                u64_padding           : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<ClosePlayground>(v9);
        };
    }

    public(friend) entry fun deposit_stakes<T0>(arg0: &mut Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg4);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x1::type_name::get<T0>()), 17);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
        0x2::balance::join<T0>(v2, 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::extract_balance<T0>(arg2, arg3, arg4));
        let v3 = DepositStakes{
            signer        : 0x2::tx_context::sender(arg4),
            index         : arg1,
            token_type    : 0x1::type_name::get<T0>(),
            amount        : arg3,
            stakes_before : 0x2::balance::value<T0>(v2),
            stakes_after  : 0x2::balance::value<T0>(v2),
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DepositStakes>(v3);
    }

    public entry fun draw<T0>(arg0: &mut Registry, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun draw_game_id<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    fun generate_answer(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 15);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public fun get_first_game_index_for_player(arg0: &Registry, arg1: u64, arg2: address) : 0x1::option::Option<u64> {
        abort 999
    }

    public fun get_game_index_for_game_id(arg0: &Registry, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        abort 999
    }

    public fun get_latest_game_index_for_player(arg0: &Registry, arg1: u64, arg2: address) : 0x1::option::Option<u64> {
        abort 999
    }

    fun get_mut_playground(arg0: &mut 0x2::object::UID, arg1: u64) : &mut Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow_mut<u64, Playground>(arg0, arg1)
    }

    fun get_playground(arg0: &0x2::object::UID, arg1: u64) : &Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow<u64, Playground>(arg0, arg1)
    }

    public entry fun new_game<T0>(arg0: &mut Registry, arg1: &mut 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::tails_exp::Registry, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public(friend) entry fun new_playground<T0>(arg0: &mut Registry, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg9);
        assert!(arg2 >= arg3, 2);
        assert!(arg3 >= arg4 && arg3 % arg4 == 0, 4);
        assert!(arg2 >= arg4 && arg2 % arg4 == 0, 3);
        assert!(arg5 > 10000, 5);
        let v0 = arg0.num_of_playgrounds;
        let v1 = GameConfig{
            max_stake                     : arg2,
            min_stake                     : arg3,
            stake_lot_size                : arg4,
            critical_hits_multiplier_bp   : arg5,
            max_single_game_loss_ratio_bp : arg6,
            banker_edge_bp                : arg7,
            u64_padding                   : 0x1::vector::empty<u64>(),
        };
        let v2 = ExpConfig{
            base_exp_divisor : arg8,
            u64_padding      : 0x1::vector::empty<u64>(),
        };
        let v3 = Playground{
            id              : 0x2::object::new(arg9),
            house_whitelist : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg9)),
            public_key      : arg1,
            num_of_games    : 0,
            stake_token     : 0x1::type_name::get<T0>(),
            opened_games    : 0x1::vector::empty<Game>(),
            game_config     : v1,
            exp_config      : v2,
            is_active       : true,
            u64_padding     : 0x1::vector::empty<u64>(),
            bcs_padding     : 0x1::vector::empty<u8>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.id, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        0x2::dynamic_object_field::add<u64, Playground>(&mut arg0.id, v0, v3);
        arg0.num_of_playgrounds = arg0.num_of_playgrounds + 1;
        let v4 = NewPlayground<T0>{
            signer               : 0x2::tx_context::sender(arg9),
            playground_object_id : 0x2::object::id_address<Playground>(&v3),
            index                : v0,
            game_config          : v1,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewPlayground<T0>>(v4);
    }

    public fun odds(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1) {
            9999 - arg0
        } else {
            arg0
        };
        assert!(v0 > 0, 13);
        assert!(v0 < 9999, 13);
        let v1 = (((arg2 as u128) * (0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9) as u128) / 10000) as u64);
        let v2 = (0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9) as u128);
        let v3 = (((v2 - v2 * (arg3 as u128) / 10000 - (v1 as u128) / 10000) * 10000 / (v0 as u128)) as u64);
        if (v3 > v1) {
            v1
        } else {
            v3
        }
    }

    entry fun play<T0>(arg0: &mut Registry, arg1: &mut 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::tails_exp::Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        validate_amount(arg0, arg2, 0x2::coin::value<T0>(&arg3));
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg2);
        assert!(v1.is_active, 20);
        assert!(v1.stake_token == 0x1::type_name::get<T0>(), 16);
        let v2 = &mut arg0.id;
        let v3 = get_mut_playground(v2, arg2);
        let v4 = 0x2::coin::value<T0>(&arg3);
        v3.num_of_games = v3.num_of_games + 1;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.id, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg3));
        let v5 = v4 / v3.exp_config.base_exp_divisor;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::tails_exp::mint_exp_token(arg1, v5, arg9), 0x2::tx_context::sender(arg9));
        let v6 = 0x2::random::new_generator(arg8, arg9);
        let v7 = 0x2::random::generate_bytes(&mut v6, 32);
        let v8 = 0x2::random::generate_bytes(&mut v6, 32);
        let v9 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9);
        let v10 = generate_answer(10000, &v7);
        let v11 = generate_answer(10000, &v8);
        let v12 = if (arg5) {
            if (v10 > arg4) {
                0
            } else if (v10 < arg4) {
                1
            } else {
                2
            }
        } else if (v10 < arg4) {
            0
        } else if (v10 > arg4) {
            1
        } else {
            2
        };
        let v13 = if (arg7) {
            if (v11 > arg6) {
                0
            } else if (v11 < arg6) {
                1
            } else {
                2
            }
        } else if (v11 < arg6) {
            0
        } else if (v11 > arg6) {
            1
        } else {
            2
        };
        let v14 = if (v12 == 0) {
            odds(arg4, arg5, v3.game_config.critical_hits_multiplier_bp, v3.game_config.banker_edge_bp)
        } else if (v12 == 1) {
            0
        } else {
            (((v3.game_config.critical_hits_multiplier_bp as u128) * (v9 as u128) / 10000) as u64)
        };
        let v15 = if (v13 == 0) {
            odds(arg6, arg7, v3.game_config.critical_hits_multiplier_bp, v3.game_config.banker_edge_bp)
        } else if (v13 == 1) {
            0
        } else {
            (((v3.game_config.critical_hits_multiplier_bp as u128) * (v9 as u128) / 10000) as u64)
        };
        let v16 = (((v4 as u128) * (v14 as u128) / (v9 as u128) * (v15 as u128) / (v9 as u128)) as u64);
        let v17 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::get_u64_padding_value(&v3.game_config.u64_padding, 0);
        let v18 = if (v16 > v17) {
            v17
        } else {
            v16
        };
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.id, 0x1::type_name::get<T0>()), v18), arg9), 0x2::tx_context::sender(arg9));
        };
        let v19 = Draw{
            signer        : 0x2::tx_context::sender(arg9),
            index         : arg2,
            game_id       : v3.num_of_games,
            public_key    : v3.public_key,
            signature_1   : v7,
            signature_2   : v8,
            player        : 0x2::tx_context::sender(arg9),
            guess_1       : arg4,
            larger_than_1 : arg5,
            answer_1      : v10,
            result_1      : v12,
            guess_2       : arg6,
            larger_than_2 : arg7,
            answer_2      : v11,
            result_2      : v13,
            stake_amount  : v4,
            reward        : v18,
            exp_amount    : v5,
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<Draw>(v19);
    }

    fun registry_or_playground_whitelist_check(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x1::vector::contains<address>(&arg0.whitelist, &v1)) {
            true
        } else {
            let v3 = 0x2::tx_context::sender(arg2);
            0x1::vector::contains<address>(&v0.house_whitelist, &v3)
        };
        assert!(v2, 1);
    }

    fun registry_whitelist_check(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
    }

    public(friend) entry fun remove_playground_whitelist(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let v2 = 0x1::vector::empty<address>();
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg2);
            let (v4, v5) = 0x1::vector::index_of<address>(&v1.house_whitelist, &v3);
            if (v4) {
                0x1::vector::remove<address>(&mut v1.house_whitelist, v5);
                0x1::vector::push_back<address>(&mut v2, v3);
            };
        };
        let v6 = RemovePlaygroundWhitelist{
            signer                  : 0x2::tx_context::sender(arg3),
            removed_whitelist_users : v2,
        };
        0x2::event::emit<RemovePlaygroundWhitelist>(v6);
    }

    public(friend) entry fun remove_registry_whitelist(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg2);
        let v0 = 0x1::vector::empty<address>();
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg0.whitelist, &v1);
            if (v2) {
                0x1::vector::remove<address>(&mut arg0.whitelist, v3);
                0x1::vector::push_back<address>(&mut v0, v1);
            };
        };
        let v4 = RemoveRegistryWhitelist{
            signer                  : 0x2::tx_context::sender(arg2),
            removed_whitelist_users : v0,
        };
        0x2::event::emit<RemoveRegistryWhitelist>(v4);
    }

    public(friend) entry fun resume_playground(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg2);
        let v0 = &mut arg0.id;
        get_mut_playground(v0, arg1).is_active = true;
        let v1 = ResumePlayground{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<ResumePlayground>(v1);
    }

    public(friend) entry fun set_max_single_game_loss(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::set_u64_padding_value(&mut v1.game_config.u64_padding, 0, arg2);
        let v2 = SetMaxSingleGameLoss{
            signer      : 0x2::tx_context::sender(arg3),
            index       : arg1,
            prev_amount : 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::get_u64_padding_value(&v1.game_config.u64_padding, 0),
            amount      : arg2,
        };
        0x2::event::emit<SetMaxSingleGameLoss>(v2);
    }

    public(friend) entry fun suspend_playground(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg2);
        let v0 = &mut arg0.id;
        get_mut_playground(v0, arg1).is_active = false;
        let v1 = SuspendPlayground{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<SuspendPlayground>(v1);
    }

    public(friend) entry fun update_exp_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg4);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        v1.exp_config.base_exp_divisor = arg2;
        v1.exp_config.u64_padding = arg3;
        let v2 = UpdateExpConfig{
            signer   : 0x2::tx_context::sender(arg4),
            index    : arg1,
            previous : v1.exp_config,
            current  : v1.exp_config,
        };
        0x2::event::emit<UpdateExpConfig>(v2);
    }

    public(friend) entry fun update_game_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg9);
        assert!(arg2 >= arg3, 2);
        assert!(arg3 >= arg4 && arg3 % arg4 == 0, 4);
        assert!(arg2 >= arg4 && arg2 % arg4 == 0, 3);
        assert!(arg5 > 10000, 5);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        v1.game_config.max_stake = arg2;
        v1.game_config.min_stake = arg3;
        v1.game_config.stake_lot_size = arg4;
        v1.game_config.critical_hits_multiplier_bp = arg5;
        v1.game_config.max_single_game_loss_ratio_bp = arg6;
        v1.game_config.banker_edge_bp = arg7;
        v1.game_config.u64_padding = arg8;
        let v2 = UpdateGameConfig{
            signer   : 0x2::tx_context::sender(arg9),
            index    : arg1,
            previous : v1.game_config,
            current  : v1.game_config,
        };
        0x2::event::emit<UpdateGameConfig>(v2);
    }

    public(friend) entry fun update_public_key(arg0: &mut Registry, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        assert!(0x1::vector::length<Game>(&v1.opened_games) == 0, 9);
        v1.public_key = arg2;
        let v2 = UpdatePublicKey{
            signer              : 0x2::tx_context::sender(arg3),
            index               : arg1,
            previous_public_key : v1.public_key,
            new_public_key      : arg2,
        };
        0x2::event::emit<UpdatePublicKey>(v2);
    }

    entry fun upgrade_version(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg1);
        arg0.version = 3;
    }

    fun validate_amount(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = get_playground(&arg0.id, arg1);
        assert!(v0.game_config.max_stake >= arg2 && v0.game_config.min_stake <= arg2, 6);
        assert!(arg2 >= v0.game_config.stake_lot_size && arg2 % v0.game_config.stake_lot_size == 0, 6);
    }

    fun version_check(arg0: &Registry) {
        assert!(3 >= arg0.version, 99);
    }

    public fun vrf_input(arg0: &Registry, arg1: u64) : (vector<u8>, vector<u8>) {
        abort 999
    }

    public fun vrf_input_from_player(arg0: &Registry, arg1: u64, arg2: address) : (vector<u8>, vector<u8>) {
        abort 999
    }

    public(friend) entry fun withdraw_stakes<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x1::type_name::get<T0>())) {
            let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
            let v3 = 0x2::balance::value<T0>(v2);
            let v4 = if (0x1::option::is_none<u64>(&arg2)) {
                v3
            } else if (v3 > *0x1::option::borrow<u64>(&arg2)) {
                *0x1::option::borrow<u64>(&arg2)
            } else {
                v3
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v4), arg3), 0x2::tx_context::sender(arg3));
            let v5 = WithdrawStakes{
                signer        : 0x2::tx_context::sender(arg3),
                index         : arg1,
                token_type    : 0x1::type_name::get<T0>(),
                amount        : v3,
                stakes_before : v3,
                stakes_after  : v3 - v4,
                u64_padding   : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<WithdrawStakes>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

