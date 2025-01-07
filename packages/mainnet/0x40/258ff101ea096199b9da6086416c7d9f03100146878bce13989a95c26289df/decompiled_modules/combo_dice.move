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

    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u64,
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
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg5);
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = get_first_game_index_for_player(arg0, arg1, arg2);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = 0x1::vector::borrow<Game>(&v0.opened_games, v2);
        let v4 = v3.player;
        assert!(0x1::option::is_some<u64>(&v3.guess_1), 12);
        assert!(0x1::option::is_some<bool>(&v3.larger_than_1), 12);
        assert!(0x1::option::is_some<u64>(&v3.guess_2), 12);
        assert!(0x1::option::is_some<bool>(&v3.larger_than_2), 12);
        assert!(0x1::option::is_some<vector<u8>>(&v3.vrf_input_1), 12);
        assert!(0x1::option::is_some<vector<u8>>(&v3.vrf_input_2), 12);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v3.vrf_input_1)), 14);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v3.vrf_input_2)), 14);
        let (v5, v6) = draw_with_bls_sig<T0>(arg0, arg1, v2, arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v4);
        } else {
            0x2::coin::destroy_zero<T0>(v8);
        };
        if (0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(v7, v4);
        } else {
            0x2::coin::destroy_zero<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(v7);
        };
    }

    public entry fun draw_game_id<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_or_playground_whitelist_check(arg0, arg1, arg5);
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = get_game_index_for_game_id(arg0, arg1, arg2);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = 0x1::vector::borrow<Game>(&v0.opened_games, v2);
        let v4 = v3.player;
        assert!(0x1::option::is_some<u64>(&v3.guess_1), 12);
        assert!(0x1::option::is_some<bool>(&v3.larger_than_1), 12);
        assert!(0x1::option::is_some<u64>(&v3.guess_2), 12);
        assert!(0x1::option::is_some<bool>(&v3.larger_than_2), 12);
        assert!(0x1::option::is_some<vector<u8>>(&v3.vrf_input_1), 12);
        assert!(0x1::option::is_some<vector<u8>>(&v3.vrf_input_2), 12);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v3.vrf_input_1)), 14);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v3.vrf_input_2)), 14);
        let (v5, v6) = draw_with_bls_sig<T0>(arg0, arg1, v2, arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v4);
        } else {
            0x2::coin::destroy_zero<T0>(v8);
        };
        if (0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(v7, v4);
        } else {
            0x2::coin::destroy_zero<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(v7);
        };
    }

    fun draw_with_bls_sig<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>) {
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let v2 = 0x2::hash::blake2b256(&arg3);
        let v3 = 0x2::hash::blake2b256(&arg4);
        let Game {
            id            : v4,
            game_id       : v5,
            player        : v6,
            stake_amount  : v7,
            guess_1       : v8,
            larger_than_1 : v9,
            vrf_input_1   : _,
            guess_2       : v11,
            larger_than_2 : v12,
            vrf_input_2   : _,
            u64_padding   : _,
        } = 0x1::vector::remove<Game>(&mut v1.opened_games, arg2);
        let v15 = v12;
        let v16 = v11;
        let v17 = v9;
        let v18 = v8;
        let v19 = v4;
        let v20 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v19, 0x1::type_name::get<T0>());
        let v21 = 0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(&mut v19, b"tails_exp_coin");
        let v22 = *0x1::option::borrow<u64>(&v18);
        let v23 = *0x1::option::borrow<bool>(&v17);
        let v24 = *0x1::option::borrow<u64>(&v16);
        let v25 = *0x1::option::borrow<bool>(&v15);
        let v26 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9);
        let v27 = generate_answer(10000, &v2);
        let v28 = generate_answer(10000, &v3);
        let v29 = if (v23) {
            if (v27 > v22) {
                0
            } else if (v27 < v22) {
                1
            } else {
                2
            }
        } else if (v27 < v22) {
            0
        } else if (v27 > v22) {
            1
        } else {
            2
        };
        let v30 = if (v25) {
            if (v28 > v24) {
                0
            } else if (v28 < v24) {
                1
            } else {
                2
            }
        } else if (v28 < v24) {
            0
        } else if (v28 > v24) {
            1
        } else {
            2
        };
        let v31 = if (v29 == 0) {
            odds(v22, v23, v1.game_config.critical_hits_multiplier_bp, v1.game_config.banker_edge_bp)
        } else if (v29 == 1) {
            0
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v26 as u128) / 10000) as u64)
        };
        let v32 = if (v30 == 0) {
            odds(v24, v25, v1.game_config.critical_hits_multiplier_bp, v1.game_config.banker_edge_bp)
        } else if (v30 == 1) {
            0
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v26 as u128) / 10000) as u64)
        };
        let v33 = (((v7 as u128) * (v31 as u128) / (v26 as u128) * (v32 as u128) / (v26 as u128)) as u64);
        let v34 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::get_u64_padding_value(&v1.game_config.u64_padding, 0);
        let v35 = if (v33 > v34) {
            v34
        } else {
            v33
        };
        let v36 = 0x2::balance::zero<T0>();
        let v37 = 0x2::balance::value<T0>(&v20);
        if (v35 > v37) {
            let v38 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
            if (v35 - v37 > 0x2::balance::value<T0>(v38)) {
                abort 19
            };
            0x2::balance::join<T0>(&mut v36, 0x2::balance::split<T0>(v38, v35 - v37));
            0x2::balance::join<T0>(&mut v36, 0x2::balance::split<T0>(&mut v20, v37));
        } else if (v35 > 0) {
            0x2::balance::join<T0>(&mut v36, 0x2::balance::split<T0>(&mut v20, v35));
        };
        if (0x2::balance::value<T0>(&v20) > 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), v20);
        } else {
            0x2::balance::destroy_zero<T0>(v20);
        };
        0x2::object::delete(v19);
        let v39 = Draw{
            signer        : 0x2::tx_context::sender(arg5),
            index         : arg1,
            game_id       : v5,
            public_key    : v1.public_key,
            signature_1   : arg3,
            signature_2   : arg4,
            player        : v6,
            guess_1       : v22,
            larger_than_1 : v23,
            answer_1      : v27,
            result_1      : v29,
            guess_2       : v24,
            larger_than_2 : v25,
            answer_2      : v28,
            result_2      : v30,
            stake_amount  : v7,
            reward        : v35,
            exp_amount    : 0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(&v21),
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<Draw>(v39);
        (0x2::coin::from_balance<T0>(v36, arg5), v21)
    }

    fun draw_with_random<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>) {
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 0x2::random::generate_bytes(&mut v2, 32);
        let v4 = 0x2::random::generate_bytes(&mut v2, 32);
        let Game {
            id            : v5,
            game_id       : v6,
            player        : v7,
            stake_amount  : v8,
            guess_1       : v9,
            larger_than_1 : v10,
            vrf_input_1   : _,
            guess_2       : v12,
            larger_than_2 : v13,
            vrf_input_2   : _,
            u64_padding   : _,
        } = 0x1::vector::remove<Game>(&mut v1.opened_games, arg2);
        let v16 = v13;
        let v17 = v12;
        let v18 = v10;
        let v19 = v9;
        let v20 = v5;
        let v21 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v20, 0x1::type_name::get<T0>());
        let v22 = 0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(&mut v20, b"tails_exp_coin");
        let v23 = *0x1::option::borrow<u64>(&v19);
        let v24 = *0x1::option::borrow<bool>(&v18);
        let v25 = *0x1::option::borrow<u64>(&v17);
        let v26 = *0x1::option::borrow<bool>(&v16);
        let v27 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9);
        let v28 = generate_answer(10000, &v3);
        let v29 = generate_answer(10000, &v4);
        let v30 = if (v24) {
            if (v28 > v23) {
                0
            } else if (v28 < v23) {
                1
            } else {
                2
            }
        } else if (v28 < v23) {
            0
        } else if (v28 > v23) {
            1
        } else {
            2
        };
        let v31 = if (v26) {
            if (v29 > v25) {
                0
            } else if (v29 < v25) {
                1
            } else {
                2
            }
        } else if (v29 < v25) {
            0
        } else if (v29 > v25) {
            1
        } else {
            2
        };
        let v32 = if (v30 == 0) {
            odds(v23, v24, v1.game_config.critical_hits_multiplier_bp, v1.game_config.banker_edge_bp)
        } else if (v30 == 1) {
            0
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v27 as u128) / 10000) as u64)
        };
        let v33 = if (v31 == 0) {
            odds(v25, v26, v1.game_config.critical_hits_multiplier_bp, v1.game_config.banker_edge_bp)
        } else if (v31 == 1) {
            0
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v27 as u128) / 10000) as u64)
        };
        let v34 = (((v8 as u128) * (v32 as u128) / (v27 as u128) * (v33 as u128) / (v27 as u128)) as u64);
        let v35 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::get_u64_padding_value(&v1.game_config.u64_padding, 0);
        let v36 = if (v34 > v35) {
            v35
        } else {
            v34
        };
        let v37 = 0x2::balance::zero<T0>();
        let v38 = 0x2::balance::value<T0>(&v21);
        if (v36 > v38) {
            let v39 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
            if (v36 - v38 > 0x2::balance::value<T0>(v39)) {
                abort 19
            };
            0x2::balance::join<T0>(&mut v37, 0x2::balance::split<T0>(v39, v36 - v38));
            0x2::balance::join<T0>(&mut v37, 0x2::balance::split<T0>(&mut v21, v38));
        } else if (v36 > 0) {
            0x2::balance::join<T0>(&mut v37, 0x2::balance::split<T0>(&mut v21, v36));
        };
        if (0x2::balance::value<T0>(&v21) > 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), v21);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
        0x2::object::delete(v20);
        let v40 = Draw{
            signer        : 0x2::tx_context::sender(arg4),
            index         : arg1,
            game_id       : v6,
            public_key    : v1.public_key,
            signature_1   : v3,
            signature_2   : v4,
            player        : v7,
            guess_1       : v23,
            larger_than_1 : v24,
            answer_1      : v28,
            result_1      : v30,
            guess_2       : v25,
            larger_than_2 : v26,
            answer_2      : v29,
            result_2      : v31,
            stake_amount  : v8,
            reward        : v36,
            exp_amount    : 0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(&v22),
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<Draw>(v40);
        (0x2::coin::from_balance<T0>(v37, arg4), v22)
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

    fun get_counter(arg0: &0x2::object::UID, arg1: vector<u8>) : &Counter {
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(arg0, arg1), 18);
        0x2::dynamic_object_field::borrow<vector<u8>, Counter>(arg0, arg1)
    }

    public(friend) fun get_draw_result(arg0: &Registry, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = get_latest_game_index_for_player(arg0, arg1, arg2);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let v2 = 0x1::vector::borrow<Game>(&v0.opened_games, 0x1::option::extract<u64>(&mut v1));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v2.vrf_input_1)), 14);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v2.vrf_input_2)), 14);
        let v3 = simulate_game(arg0, arg1, v2.stake_amount, *0x1::option::borrow<u64>(&v2.guess_1), *0x1::option::borrow<bool>(&v2.larger_than_1), *0x1::option::borrow<u64>(&v2.guess_2), *0x1::option::borrow<bool>(&v2.larger_than_2), *0x1::option::borrow<vector<u8>>(&v2.vrf_input_1), *0x1::option::borrow<vector<u8>>(&v2.vrf_input_2), arg3, arg4, arg5);
        0x1::vector::pop_back<u64>(&mut v3);
        0x1::vector::push_back<u64>(&mut v3, 0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(&v2.id, b"tails_exp_coin")));
        v3
    }

    public fun get_first_game_index_for_player(arg0: &Registry, arg1: u64, arg2: address) : 0x1::option::Option<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<Game>(&v0.opened_games)) {
            if (0x1::vector::borrow<Game>(&v0.opened_games, v1).player == arg2) {
                0x1::vector::push_back<u64>(&mut v2, v1);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u64>(&v2) > 0) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&v2, 0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_game_index_for_game_id(arg0: &Registry, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Game>(&v0.opened_games)) {
            if (0x1::vector::borrow<Game>(&v0.opened_games, v1).game_id == arg2) {
                return 0x1::option::some<u64>(v1)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_latest_game_index_for_player(arg0: &Registry, arg1: u64, arg2: address) : 0x1::option::Option<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<Game>(&v0.opened_games)) {
            if (0x1::vector::borrow<Game>(&v0.opened_games, v1).player == arg2) {
                0x1::vector::push_back<u64>(&mut v2, v1);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u64>(&v2) > 0) {
            0x1::option::some<u64>(0x1::vector::pop_back<u64>(&mut v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    fun get_mut_counter(arg0: &mut 0x2::object::UID, arg1: vector<u8>) : &mut Counter {
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(arg0, arg1), 18);
        0x2::dynamic_object_field::borrow_mut<vector<u8>, Counter>(arg0, arg1)
    }

    fun get_mut_playground(arg0: &mut 0x2::object::UID, arg1: u64) : &mut Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow_mut<u64, Playground>(arg0, arg1)
    }

    fun get_playground(arg0: &0x2::object::UID, arg1: u64) : &Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow<u64, Playground>(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_registry_(arg0);
    }

    public entry fun new_game<T0>(arg0: &mut Registry, arg1: &mut 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::tails_exp::Registry, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        validate_amount(arg0, arg2, arg4);
        let v0 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::extract_balance<T0>(arg3, arg4, arg5);
        let v1 = &mut arg0.id;
        let v2 = get_mut_playground(v1, arg2);
        assert!(v2.stake_token == 0x1::type_name::get<T0>(), 16);
        assert!(v2.is_active, 20);
        let v3 = v2.num_of_games;
        let v4 = Game{
            id            : 0x2::object::new(arg5),
            game_id       : v3,
            player        : 0x2::tx_context::sender(arg5),
            stake_amount  : arg4,
            guess_1       : 0x1::option::none<u64>(),
            larger_than_1 : 0x1::option::none<bool>(),
            vrf_input_1   : 0x1::option::none<vector<u8>>(),
            guess_2       : 0x1::option::none<u64>(),
            larger_than_2 : 0x1::option::none<bool>(),
            vrf_input_2   : 0x1::option::none<vector<u8>>(),
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v4.id, 0x1::type_name::get<T0>(), v0);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(&mut v4.id, b"tails_exp_coin", 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::tails_exp::friend_mint_exp_token(arg1, arg4 / v2.exp_config.base_exp_divisor, arg5));
        v2.num_of_games = v2.num_of_games + 1;
        0x1::vector::push_back<Game>(&mut v2.opened_games, v4);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, v2.exp_config.base_exp_divisor);
        let v6 = NewGame<T0>{
            signer              : 0x2::tx_context::sender(arg5),
            index               : arg2,
            game_id             : v3,
            player_stake_amount : arg4,
            banker_stake_amount : (((arg4 as u128) * (v2.game_config.critical_hits_multiplier_bp as u128) / 10000 * (v2.game_config.critical_hits_multiplier_bp as u128) / 10000 - (0x2::balance::value<T0>(&v0) as u128)) as u64),
            u64_padding         : v5,
        };
        0x2::event::emit<NewGame<T0>>(v6);
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
        let v4 = Counter{
            id    : 0x2::object::new(arg9),
            count : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, Counter>(&mut v3.id, b"counter_1", v4);
        let v5 = Counter{
            id    : 0x2::object::new(arg9),
            count : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, Counter>(&mut v3.id, b"counter_2", v5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.id, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        0x2::dynamic_object_field::add<u64, Playground>(&mut arg0.id, v0, v3);
        arg0.num_of_playgrounds = arg0.num_of_playgrounds + 1;
        let v6 = NewPlayground<T0>{
            signer               : 0x2::tx_context::sender(arg9),
            playground_object_id : 0x2::object::id_address<Playground>(&v3),
            index                : v0,
            game_config          : v1,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewPlayground<T0>>(v6);
    }

    fun new_registry_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg0),
            whitelist          : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
            num_of_playgrounds : 0,
            version            : 2,
        };
        0x2::transfer::share_object<Registry>(v0);
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

    public(friend) entry fun play_guess(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_latest_game_index_for_player(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert!(0x1::option::is_some<u64>(&v0), 7);
        let (v1, v2) = vrf_input(arg0, arg1);
        let v3 = &mut arg0.id;
        let v4 = get_mut_playground(v3, arg1);
        let v5 = &mut v4.id;
        let v6 = get_mut_counter(v5, b"counter_1");
        v6.count = v6.count + 1;
        let v7 = &mut v4.id;
        let v8 = get_mut_counter(v7, b"counter_2");
        v8.count = v8.count + 1;
        let v9 = 0x1::vector::borrow_mut<Game>(&mut v4.opened_games, 0x1::option::extract<u64>(&mut v0));
        assert!(0x2::tx_context::sender(arg6) == v9.player, 10);
        assert!(0x1::option::is_none<u64>(&v9.guess_1), 11);
        assert!(0x1::option::is_none<bool>(&v9.larger_than_1), 11);
        assert!(0x1::option::is_none<vector<u8>>(&v9.vrf_input_1), 11);
        assert!(0x1::option::is_none<u64>(&v9.guess_2), 11);
        assert!(0x1::option::is_none<bool>(&v9.larger_than_2), 11);
        assert!(0x1::option::is_none<vector<u8>>(&v9.vrf_input_2), 11);
        0x1::option::fill<u64>(&mut v9.guess_1, arg2);
        0x1::option::fill<bool>(&mut v9.larger_than_1, arg3);
        0x1::option::fill<vector<u8>>(&mut v9.vrf_input_1, v1);
        0x1::option::fill<u64>(&mut v9.guess_2, arg4);
        0x1::option::fill<bool>(&mut v9.larger_than_2, arg5);
        0x1::option::fill<vector<u8>>(&mut v9.vrf_input_2, v2);
        let v10 = PlayGuess{
            signer        : 0x2::tx_context::sender(arg6),
            index         : arg1,
            game_id       : v9.game_id,
            guess_1       : arg2,
            larger_than_1 : arg3,
            guess_2       : arg4,
            larger_than_2 : arg5,
            vrf_input_1   : v1,
            vrf_input_2   : v2,
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<PlayGuess>(v10);
    }

    public(friend) entry fun play_guess_with_random<T0>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = get_latest_game_index_for_player(arg0, arg1, v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let (v2, v3) = vrf_input(arg0, arg1);
        let v4 = &mut arg0.id;
        let v5 = get_mut_playground(v4, arg1);
        let v6 = &mut v5.id;
        let v7 = get_mut_counter(v6, b"counter_1");
        v7.count = v7.count + 1;
        let v8 = &mut v5.id;
        let v9 = get_mut_counter(v8, b"counter_2");
        v9.count = v9.count + 1;
        let v10 = 0x1::option::extract<u64>(&mut v1);
        let v11 = 0x1::vector::borrow_mut<Game>(&mut v5.opened_games, v10);
        assert!(0x2::tx_context::sender(arg7) == v11.player, 10);
        assert!(0x1::option::is_none<u64>(&v11.guess_1), 11);
        assert!(0x1::option::is_none<bool>(&v11.larger_than_1), 11);
        assert!(0x1::option::is_none<vector<u8>>(&v11.vrf_input_1), 11);
        assert!(0x1::option::is_none<u64>(&v11.guess_2), 11);
        assert!(0x1::option::is_none<bool>(&v11.larger_than_2), 11);
        assert!(0x1::option::is_none<vector<u8>>(&v11.vrf_input_2), 11);
        0x1::option::fill<u64>(&mut v11.guess_1, arg2);
        0x1::option::fill<bool>(&mut v11.larger_than_1, arg3);
        0x1::option::fill<vector<u8>>(&mut v11.vrf_input_1, v2);
        0x1::option::fill<u64>(&mut v11.guess_2, arg4);
        0x1::option::fill<bool>(&mut v11.larger_than_2, arg5);
        0x1::option::fill<vector<u8>>(&mut v11.vrf_input_2, v3);
        let v12 = PlayGuess{
            signer        : 0x2::tx_context::sender(arg7),
            index         : arg1,
            game_id       : v11.game_id,
            guess_1       : arg2,
            larger_than_1 : arg3,
            guess_2       : arg4,
            larger_than_2 : arg5,
            vrf_input_1   : v2,
            vrf_input_2   : v3,
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<PlayGuess>(v12);
        let (v13, v14) = draw_with_random<T0>(arg0, arg1, v10, arg6, arg7);
        let v15 = v14;
        let v16 = v13;
        if (0x2::coin::value<T0>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v16);
        };
        if (0x2::coin::value<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(&v15) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>>(v15, v0);
        } else {
            0x2::coin::destroy_zero<0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp::TAILS_EXP>(v15);
        };
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

    public(friend) fun simulate_game(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg9, &v0.public_key, &arg7), 14);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg10, &v0.public_key, &arg8), 14);
        let v1 = 0x2::hash::blake2b256(&arg9);
        let v2 = 0x2::hash::blake2b256(&arg10);
        let v3 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::multiplier(9);
        let v4 = generate_answer(10000, &v1);
        let v5 = generate_answer(10000, &v2);
        let v6 = if (arg4) {
            if (v4 > arg3) {
                0
            } else if (v4 < arg3) {
                1
            } else {
                2
            }
        } else if (v4 < arg3) {
            0
        } else if (v4 > arg3) {
            1
        } else {
            2
        };
        let v7 = if (arg6) {
            if (v5 > arg5) {
                0
            } else if (v5 < arg5) {
                1
            } else {
                2
            }
        } else if (v5 < arg5) {
            0
        } else if (v5 > arg5) {
            1
        } else {
            2
        };
        let v8 = if (v6 == 0) {
            odds(arg3, arg4, v0.game_config.critical_hits_multiplier_bp, v0.game_config.banker_edge_bp)
        } else if (v6 == 1) {
            0
        } else {
            (((v0.game_config.critical_hits_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        };
        let v9 = if (v7 == 0) {
            odds(arg5, arg6, v0.game_config.critical_hits_multiplier_bp, v0.game_config.banker_edge_bp)
        } else if (v7 == 1) {
            0
        } else {
            (((v0.game_config.critical_hits_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        };
        let v10 = (((arg2 as u128) * (v8 as u128) / (v3 as u128) * (v9 as u128) / (v3 as u128)) as u64);
        let v11 = 0xc4808fe7296f41f30c3d226966d6303a84ad4c39ffa9301ca08fe5ab09a70a8d::utils::get_u64_padding_value(&v0.game_config.u64_padding, 0);
        let v12 = if (v10 > v11) {
            v11
        } else {
            v10
        };
        let v13 = 0x1::vector::empty<u64>();
        let v14 = &mut v13;
        0x1::vector::push_back<u64>(v14, v4);
        0x1::vector::push_back<u64>(v14, v6);
        0x1::vector::push_back<u64>(v14, v5);
        0x1::vector::push_back<u64>(v14, v7);
        0x1::vector::push_back<u64>(v14, v12);
        0x1::vector::push_back<u64>(v14, arg2 / v0.exp_config.base_exp_divisor);
        v13
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
        arg0.version = 2;
    }

    fun validate_amount(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = get_playground(&arg0.id, arg1);
        assert!(v0.game_config.max_stake >= arg2 && v0.game_config.min_stake <= arg2, 6);
        assert!(arg2 >= v0.game_config.stake_lot_size && arg2 % v0.game_config.stake_lot_size == 0, 6);
    }

    fun version_check(arg0: &Registry) {
        assert!(2 >= arg0.version, 99);
    }

    public fun vrf_input(arg0: &Registry, arg1: u64) : (vector<u8>, vector<u8>) {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = get_counter(&v0.id, b"counter_1");
        let v2 = 0x2::object::id_bytes<Counter>(v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v1.count));
        let v3 = get_counter(&v0.id, b"counter_2");
        let v4 = 0x2::object::id_bytes<Counter>(v3);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v3.count));
        (v2, v4)
    }

    public fun vrf_input_from_player(arg0: &Registry, arg1: u64, arg2: address) : (vector<u8>, vector<u8>) {
        let v0 = get_latest_game_index_for_player(arg0, arg1, arg2);
        let v1 = 0x1::vector::borrow<Game>(&get_playground(&arg0.id, arg1).opened_games, 0x1::option::extract<u64>(&mut v0));
        (*0x1::option::borrow<vector<u8>>(&v1.vrf_input_1), *0x1::option::borrow<vector<u8>>(&v1.vrf_input_2))
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

