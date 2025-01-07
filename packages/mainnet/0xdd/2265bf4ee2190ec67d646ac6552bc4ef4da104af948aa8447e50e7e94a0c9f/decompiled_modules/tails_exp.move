module 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::tails_exp {
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
        opened_games: 0x2::vec_map::VecMap<address, Game>,
        game_config: GameConfig,
        is_active: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct GameConfig has copy, drop, store {
        max_stake: u64,
        min_stake: u64,
        stake_lot_size: u64,
        base_exp_divisor: u64,
        losses_multiplier_bp: u64,
        critical_hits_multiplier_bp: u64,
    }

    struct Game has store {
        game_id: u64,
        player: address,
        stake_amount: u64,
        guess_1: 0x1::option::Option<u64>,
        larger_than_1: 0x1::option::Option<bool>,
        vrf_input_1: 0x1::option::Option<vector<u8>>,
        guess_2: 0x1::option::Option<u64>,
        larger_than_2: 0x1::option::Option<bool>,
        vrf_input_2: 0x1::option::Option<vector<u8>>,
    }

    struct TAILS_EXP has drop {
        dummy_field: bool,
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
        exp: u64,
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
    }

    struct WithdrawStakes has copy, drop {
        signer: address,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DepositStakesEmergency has copy, drop {
        signer: address,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        stakes_before: u64,
        stakes_after: u64,
    }

    struct ClosePlayground has copy, drop {
        signer: address,
        index: u64,
        num_of_existing_games: u64,
        done: bool,
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
        original_max_stake: u64,
        original_min_stake: u64,
        original_stake_lot_size: u64,
        original_base_exp_divisor: u64,
        original_losses_multiplier_bp: u64,
        original_critical_hits_multiplier_bp: u64,
        max_stake: u64,
        min_stake: u64,
        stake_lot_size: u64,
        base_exp_divisor: u64,
        losses_multiplier_bp: u64,
        critical_hits_multiplier_bp: u64,
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

    struct NewGame<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        game_id: u64,
        stake_amount: u64,
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
    }

    public(friend) entry fun add_playground_whitelist(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg3);
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

    public(friend) entry fun add_registry_whitelist(arg0: &mut Registry, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
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
        playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        assert!(0x2::vec_map::contains<address, Game>(&v1.opened_games, &arg2), 6);
        let (_, v3) = 0x2::vec_map::remove<address, Game>(&mut v1.opened_games, &arg2);
        close_game_<T0>(v1, arg1, v3, arg3);
    }

    fun close_game_<T0>(arg0: &mut Playground, arg1: u64, arg2: Game, arg3: &mut 0x2::tx_context::TxContext) {
        let Game {
            game_id       : v0,
            player        : v1,
            stake_amount  : v2,
            guess_1       : _,
            larger_than_1 : _,
            vrf_input_1   : _,
            guess_2       : _,
            larger_than_2 : _,
            vrf_input_2   : _,
        } = arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), v2), arg3), v1);
        let v9 = CloseGame{
            signer        : 0x2::tx_context::sender(arg3),
            index         : arg1,
            game_id       : v0,
            player        : v1,
            refund_amount : v2,
        };
        0x2::event::emit<CloseGame>(v9);
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
        let v5 = 0x2::vec_map::keys<address, Game>(&v3.opened_games);
        while (0x1::vector::length<address>(&v5) > 0) {
            let v6 = 0x1::vector::pop_back<address>(&mut v5);
            let (_, v8) = 0x2::vec_map::remove<address, Game>(&mut v3.opened_games, &v6);
            close_game_<T0>(v3, arg1, v8, arg3);
            v4 = v4 + 1;
            if (v4 >= arg2) {
                break
            };
        };
        let v9 = 0x2::vec_map::size<address, Game>(&v3.opened_games);
        if (v9 > 0) {
            let v10 = ClosePlayground{
                signer                : 0x2::tx_context::sender(arg3),
                index                 : arg1,
                num_of_existing_games : v9,
                done                  : false,
            };
            0x2::event::emit<ClosePlayground>(v10);
        } else {
            withdraw_stakes<T0>(arg0, arg1, arg3);
            let _ = &mut arg0.id;
            let v12 = ClosePlayground{
                signer                : 0x2::tx_context::sender(arg3),
                index                 : arg1,
                num_of_existing_games : v9,
                done                  : true,
            };
            0x2::event::emit<ClosePlayground>(v12);
        };
    }

    public(friend) entry fun deposit_stakes_emergency<T0>(arg0: &mut Registry, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg4);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg3);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x1::type_name::get<T0>()), 17);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
        0x2::balance::join<T0>(v2, 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::extract_balance<T0>(arg1, arg2, arg4));
        let v3 = DepositStakesEmergency{
            signer        : 0x2::tx_context::sender(arg4),
            index         : arg3,
            token_type    : 0x1::type_name::get<T0>(),
            amount        : arg2,
            stakes_before : 0x2::balance::value<T0>(v2),
            stakes_after  : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<DepositStakesEmergency>(v3);
    }

    public(friend) entry fun draw(arg0: &mut Registry, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg5);
        let v0 = get_playground(&arg0.id, arg1);
        assert!(0x2::vec_map::contains<address, Game>(&v0.opened_games, &arg2), 6);
        let v1 = 0x2::vec_map::get<address, Game>(&v0.opened_games, &arg2);
        let v2 = v1.player;
        assert!(0x1::option::is_some<u64>(&v1.guess_1), 11);
        assert!(0x1::option::is_some<bool>(&v1.larger_than_1), 11);
        assert!(0x1::option::is_some<u64>(&v1.guess_2), 11);
        assert!(0x1::option::is_some<bool>(&v1.larger_than_2), 11);
        assert!(0x1::option::is_some<vector<u8>>(&v1.vrf_input_1), 11);
        assert!(0x1::option::is_some<vector<u8>>(&v1.vrf_input_2), 11);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v1.vrf_input_1)), 13);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v1.vrf_input_2)), 13);
        let v3 = draw_(arg0, arg1, v2, arg3, arg4, arg5);
        if (0x2::coin::value<TAILS_EXP>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TAILS_EXP>>(v3, v2);
        } else {
            0x2::coin::destroy_zero<TAILS_EXP>(v3);
        };
    }

    fun draw_(arg0: &mut Registry, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAILS_EXP> {
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        let (_, v3) = 0x2::vec_map::remove<address, Game>(&mut v1.opened_games, &arg2);
        let v4 = 0x2::hash::blake2b256(&arg3);
        let v5 = 0x2::hash::blake2b256(&arg4);
        let Game {
            game_id       : v6,
            player        : v7,
            stake_amount  : v8,
            guess_1       : v9,
            larger_than_1 : v10,
            vrf_input_1   : _,
            guess_2       : v12,
            larger_than_2 : v13,
            vrf_input_2   : _,
        } = v3;
        let v15 = v13;
        let v16 = v12;
        let v17 = v10;
        let v18 = v9;
        let v19 = *0x1::option::borrow<u64>(&v18);
        let v20 = *0x1::option::borrow<bool>(&v17);
        let v21 = *0x1::option::borrow<u64>(&v16);
        let v22 = *0x1::option::borrow<bool>(&v15);
        let v23 = 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::multiplier(9);
        let v24 = generate_answer(10000, &v4);
        let v25 = generate_answer(10000, &v5);
        let v26 = if (v20) {
            if (v24 > v19) {
                0
            } else if (v24 < v19) {
                1
            } else {
                2
            }
        } else if (v24 < v19) {
            0
        } else if (v24 > v19) {
            1
        } else {
            2
        };
        let v27 = if (v22) {
            if (v25 > v21) {
                0
            } else if (v25 < v21) {
                1
            } else {
                2
            }
        } else if (v25 < v21) {
            0
        } else if (v25 > v21) {
            1
        } else {
            2
        };
        let v28 = if (v26 == 0) {
            odds(v19, v20, v1.game_config.losses_multiplier_bp, v1.game_config.critical_hits_multiplier_bp, 0)
        } else if (v26 == 1) {
            (((v1.game_config.losses_multiplier_bp as u128) * (v23 as u128) / 10000) as u64)
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v23 as u128) / 10000) as u64)
        };
        let v29 = if (v27 == 0) {
            odds(v21, v22, v1.game_config.losses_multiplier_bp, v1.game_config.critical_hits_multiplier_bp, 0)
        } else if (v27 == 1) {
            (((v1.game_config.losses_multiplier_bp as u128) * (v23 as u128) / 10000) as u64)
        } else {
            (((v1.game_config.critical_hits_multiplier_bp as u128) * (v23 as u128) / 10000) as u64)
        };
        let v30 = ((((v8 / v1.game_config.base_exp_divisor) as u128) * (v28 as u128) / (v23 as u128) * (v29 as u128) / (v23 as u128)) as u64);
        let v31 = Draw{
            signer        : 0x2::tx_context::sender(arg5),
            index         : arg1,
            game_id       : v6,
            public_key    : v1.public_key,
            signature_1   : arg3,
            signature_2   : arg4,
            player        : v7,
            guess_1       : v19,
            larger_than_1 : v20,
            answer_1      : v24,
            result_1      : v26,
            guess_2       : v21,
            larger_than_2 : v22,
            answer_2      : v25,
            result_2      : v27,
            stake_amount  : v8,
            exp           : v30,
        };
        0x2::event::emit<Draw>(v31);
        let v32 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<TAILS_EXP>>(&mut arg0.id, b"exp_treasury_cap");
        mint_exp_token(v32, v30, arg5)
    }

    public(friend) fun friend_mint_exp_token(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAILS_EXP> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<TAILS_EXP>>(&mut arg0.id, b"exp_treasury_cap");
        assert!(arg1 <= 100000000 - 0x2::coin::total_supply<TAILS_EXP>(v0), 16);
        0x2::coin::mint<TAILS_EXP>(v0, arg1, arg2)
    }

    fun generate_answer(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 14);
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
        let v1 = 0x2::vec_map::get<address, Game>(&v0.opened_games, &arg2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v1.vrf_input_1)), 13);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v0.public_key, 0x1::option::borrow<vector<u8>>(&v1.vrf_input_2)), 13);
        simulate_game(arg0, arg1, v1.stake_amount, *0x1::option::borrow<u64>(&v1.guess_1), *0x1::option::borrow<bool>(&v1.larger_than_1), *0x1::option::borrow<u64>(&v1.guess_2), *0x1::option::borrow<bool>(&v1.larger_than_2), *0x1::option::borrow<vector<u8>>(&v1.vrf_input_1), *0x1::option::borrow<vector<u8>>(&v1.vrf_input_2), arg3, arg4, arg5)
    }

    fun get_mut_counter(arg0: &mut 0x2::object::UID, arg1: vector<u8>) : &mut Counter {
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(arg0, arg1), 18);
        0x2::dynamic_object_field::borrow_mut<vector<u8>, Counter>(arg0, arg1)
    }

    fun get_mut_playground(arg0: &mut 0x2::object::UID, arg1: u64) : &mut Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 7);
        0x2::dynamic_object_field::borrow_mut<u64, Playground>(arg0, arg1)
    }

    fun get_playground(arg0: &0x2::object::UID, arg1: u64) : &Playground {
        assert!(0x2::dynamic_object_field::exists_<u64>(arg0, arg1), 7);
        0x2::dynamic_object_field::borrow<u64, Playground>(arg0, arg1)
    }

    fun init(arg0: TAILS_EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAILS_EXP>(arg0, 0, b"TEXP", b"Tails Exp", b"Tails By Typus Exp Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/TEXP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAILS_EXP>>(v1);
        new_registry_(v0, arg1);
    }

    public(friend) entry fun merge_exp_tokens(arg0: vector<0x2::coin::Coin<TAILS_EXP>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<TAILS_EXP>>(&arg0)) {
            v0 = v0 + 0x2::coin::value<TAILS_EXP>(0x1::vector::borrow<0x2::coin::Coin<TAILS_EXP>>(&arg0, v1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TAILS_EXP>>(0x2::coin::from_balance<TAILS_EXP>(0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::extract_balance<TAILS_EXP>(arg0, v0, arg1), arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint_exp_token(arg0: &mut 0x2::coin::TreasuryCap<TAILS_EXP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAILS_EXP> {
        assert!(arg1 <= 100000000 - 0x2::coin::total_supply<TAILS_EXP>(arg0), 16);
        0x2::coin::mint<TAILS_EXP>(arg0, arg1, arg2)
    }

    public(friend) entry fun new_game<T0>(arg0: &mut Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        validate_amount(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        assert!(v1.is_active, 19);
        assert!(v1.stake_token == 0x1::type_name::get<T0>(), 15);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_map::contains<address, Game>(&v1.opened_games, &v2), 8);
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x1::type_name::get<T0>())) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::extract_balance<T0>(arg2, arg3, arg4));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>(), 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::extract_balance<T0>(arg2, arg3, arg4));
        };
        let v3 = v1.num_of_games;
        let v4 = Game{
            game_id       : v3,
            player        : 0x2::tx_context::sender(arg4),
            stake_amount  : arg3,
            guess_1       : 0x1::option::none<u64>(),
            larger_than_1 : 0x1::option::none<bool>(),
            vrf_input_1   : 0x1::option::none<vector<u8>>(),
            guess_2       : 0x1::option::none<u64>(),
            larger_than_2 : 0x1::option::none<bool>(),
            vrf_input_2   : 0x1::option::none<vector<u8>>(),
        };
        v1.num_of_games = v1.num_of_games + 1;
        0x2::vec_map::insert<address, Game>(&mut v1.opened_games, v2, v4);
        let v5 = NewGame<T0>{
            signer       : 0x2::tx_context::sender(arg4),
            index        : arg1,
            game_id      : v3,
            stake_amount : arg3,
        };
        0x2::event::emit<NewGame<T0>>(v5);
    }

    public(friend) entry fun new_playground<T0>(arg0: &mut Registry, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg8);
        assert!(arg2 >= arg3, 2);
        assert!(arg3 >= arg4 && arg3 % arg4 == 0, 4);
        assert!(arg2 >= arg4 && arg2 % arg4 == 0, 3);
        let v0 = arg0.num_of_playgrounds;
        let v1 = GameConfig{
            max_stake                   : arg2,
            min_stake                   : arg3,
            stake_lot_size              : arg4,
            base_exp_divisor            : arg5,
            losses_multiplier_bp        : arg6,
            critical_hits_multiplier_bp : arg7,
        };
        let v2 = Playground{
            id              : 0x2::object::new(arg8),
            house_whitelist : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg8)),
            public_key      : arg1,
            num_of_games    : 0,
            stake_token     : 0x1::type_name::get<T0>(),
            opened_games    : 0x2::vec_map::empty<address, Game>(),
            game_config     : v1,
            is_active       : true,
        };
        let v3 = Counter{
            id    : 0x2::object::new(arg8),
            count : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, Counter>(&mut v2.id, b"counter_1", v3);
        let v4 = Counter{
            id    : 0x2::object::new(arg8),
            count : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, Counter>(&mut v2.id, b"counter_2", v4);
        0x2::dynamic_object_field::add<u64, Playground>(&mut arg0.id, v0, v2);
        arg0.num_of_playgrounds = arg0.num_of_playgrounds + 1;
        let v5 = NewPlayground<T0>{
            signer               : 0x2::tx_context::sender(arg8),
            playground_object_id : 0x2::object::id_address<Playground>(&v2),
            index                : v0,
            game_config          : v1,
        };
        0x2::event::emit<NewPlayground<T0>>(v5);
    }

    fun new_registry_(arg0: 0x2::coin::TreasuryCap<TAILS_EXP>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg1),
            whitelist          : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg1)),
            num_of_playgrounds : 0,
            version            : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::TreasuryCap<TAILS_EXP>>(&mut v0.id, b"exp_treasury_cap", arg0);
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun odds(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg1) {
            9999 - arg0
        } else {
            arg0
        };
        let v1 = if (arg1) {
            arg0 + 1
        } else {
            9999 - arg0 + 1
        };
        assert!(v0 > 0, 12);
        assert!(v0 < 9999, 12);
        let v2 = (((arg3 as u128) * (0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::multiplier(9) as u128) / 10000) as u64);
        let v3 = (((0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::multiplier(9) as u128) * ((10000 - arg4) as u128) / 10000 * ((10000 - arg2) as u128) / 10000 * ((2 * v0 + v1) as u128) / (v0 as u128)) as u64);
        if (v3 > v2) {
            v2
        } else {
            v3
        }
    }

    public(friend) entry fun play_guess(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1) = vrf_input(arg0, arg1);
        let v2 = &mut arg0.id;
        let v3 = get_mut_playground(v2, arg1);
        assert!(v3.is_active, 19);
        let v4 = &mut v3.id;
        let v5 = get_mut_counter(v4, b"counter_1");
        v5.count = v5.count + 1;
        let v6 = &mut v3.id;
        let v7 = get_mut_counter(v6, b"counter_2");
        v7.count = v7.count + 1;
        let v8 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_map::contains<address, Game>(&v3.opened_games, &v8), 6);
        let v9 = 0x2::vec_map::get_mut<address, Game>(&mut v3.opened_games, &v8);
        assert!(0x2::tx_context::sender(arg6) == v9.player, 9);
        odds(arg2, arg3, v3.game_config.losses_multiplier_bp, v3.game_config.critical_hits_multiplier_bp, 0);
        odds(arg4, arg5, v3.game_config.losses_multiplier_bp, v3.game_config.critical_hits_multiplier_bp, 0);
        assert!(0x1::option::is_none<u64>(&v9.guess_1), 10);
        assert!(0x1::option::is_none<bool>(&v9.larger_than_1), 10);
        assert!(0x1::option::is_none<vector<u8>>(&v9.vrf_input_1), 10);
        assert!(0x1::option::is_none<u64>(&v9.guess_2), 10);
        assert!(0x1::option::is_none<bool>(&v9.larger_than_2), 10);
        assert!(0x1::option::is_none<vector<u8>>(&v9.vrf_input_2), 10);
        0x1::option::fill<u64>(&mut v9.guess_1, arg2);
        0x1::option::fill<bool>(&mut v9.larger_than_1, arg3);
        0x1::option::fill<vector<u8>>(&mut v9.vrf_input_1, v0);
        0x1::option::fill<u64>(&mut v9.guess_2, arg4);
        0x1::option::fill<bool>(&mut v9.larger_than_2, arg5);
        0x1::option::fill<vector<u8>>(&mut v9.vrf_input_2, v1);
        let v10 = PlayGuess{
            signer        : 0x2::tx_context::sender(arg6),
            index         : arg1,
            game_id       : v9.game_id,
            guess_1       : arg2,
            larger_than_1 : arg3,
            guess_2       : arg4,
            larger_than_2 : arg5,
            vrf_input_1   : v0,
            vrf_input_2   : v1,
        };
        0x2::event::emit<PlayGuess>(v10);
    }

    fun playground_whitelist_check(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&get_playground(&arg0.id, arg1).house_whitelist, &v0), 1);
    }

    fun registry_whitelist_check(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
    }

    public(friend) entry fun remove_playground_whitelist(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg3);
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

    public(friend) entry fun remove_registry_whitelist(arg0: &mut Registry, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
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

    public(friend) entry fun resume_playground(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg2);
        let v0 = &mut arg0.id;
        get_mut_playground(v0, arg1).is_active = true;
        let v1 = ResumePlayground{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<ResumePlayground>(v1);
    }

    public(friend) fun simulate_game(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = get_playground(&arg0.id, arg1);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg9, &v0.public_key, &arg7), 13);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg10, &v0.public_key, &arg8), 13);
        let v1 = 0x2::hash::blake2b256(&arg9);
        let v2 = 0x2::hash::blake2b256(&arg10);
        let v3 = 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils::multiplier(9);
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
            odds(arg3, arg4, v0.game_config.losses_multiplier_bp, v0.game_config.critical_hits_multiplier_bp, 0)
        } else if (v6 == 1) {
            (((v0.game_config.losses_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        } else {
            (((v0.game_config.critical_hits_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        };
        let v9 = if (v7 == 0) {
            odds(arg5, arg6, v0.game_config.losses_multiplier_bp, v0.game_config.critical_hits_multiplier_bp, 0)
        } else if (v7 == 1) {
            (((v0.game_config.losses_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        } else {
            (((v0.game_config.critical_hits_multiplier_bp as u128) * (v3 as u128) / 10000) as u64)
        };
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v4);
        0x1::vector::push_back<u64>(v11, v6);
        0x1::vector::push_back<u64>(v11, v5);
        0x1::vector::push_back<u64>(v11, v7);
        0x1::vector::push_back<u64>(v11, ((((arg2 / v0.game_config.base_exp_divisor) as u128) * (v8 as u128) / (v3 as u128) * (v9 as u128) / (v3 as u128)) as u64));
        v10
    }

    public(friend) entry fun suspend_playground(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg2);
        let v0 = &mut arg0.id;
        get_mut_playground(v0, arg1).is_active = false;
        let v1 = SuspendPlayground{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<SuspendPlayground>(v1);
    }

    public(friend) entry fun update_game_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg8);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        v1.game_config.max_stake = arg2;
        v1.game_config.min_stake = arg3;
        v1.game_config.stake_lot_size = arg4;
        v1.game_config.base_exp_divisor = arg5;
        v1.game_config.losses_multiplier_bp = arg6;
        v1.game_config.critical_hits_multiplier_bp = arg7;
        let v2 = UpdateGameConfig{
            signer                               : 0x2::tx_context::sender(arg8),
            index                                : arg1,
            original_max_stake                   : v1.game_config.max_stake,
            original_min_stake                   : v1.game_config.min_stake,
            original_stake_lot_size              : v1.game_config.stake_lot_size,
            original_base_exp_divisor            : v1.game_config.base_exp_divisor,
            original_losses_multiplier_bp        : v1.game_config.losses_multiplier_bp,
            original_critical_hits_multiplier_bp : v1.game_config.critical_hits_multiplier_bp,
            max_stake                            : arg2,
            min_stake                            : arg3,
            stake_lot_size                       : arg4,
            base_exp_divisor                     : arg5,
            losses_multiplier_bp                 : arg6,
            critical_hits_multiplier_bp          : arg7,
        };
        0x2::event::emit<UpdateGameConfig>(v2);
    }

    public(friend) entry fun update_public_key(arg0: &mut Registry, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        playground_whitelist_check(arg0, arg1, arg3);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        assert!(0x2::vec_map::size<address, Game>(&v1.opened_games) == 0, 8);
        v1.public_key = arg2;
        let v2 = UpdatePublicKey{
            signer              : 0x2::tx_context::sender(arg3),
            index               : arg1,
            previous_public_key : v1.public_key,
            new_public_key      : arg2,
        };
        0x2::event::emit<UpdatePublicKey>(v2);
    }

    fun validate_amount(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = get_playground(&arg0.id, arg1);
        assert!(v0.game_config.max_stake >= arg2 && v0.game_config.min_stake <= arg2, 5);
        assert!(arg2 >= v0.game_config.stake_lot_size && arg2 % v0.game_config.stake_lot_size == 0, 5);
    }

    fun version_check(arg0: &Registry) {
        assert!(0 == arg0.version, 99);
    }

    public(friend) fun view_draw_result(arg0: &mut Registry, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>) {
        abort 98
    }

    public(friend) fun vrf_input(arg0: &Registry, arg1: u64) : (vector<u8>, vector<u8>) {
        let v0 = get_playground(&arg0.id, arg1);
        let v1 = get_counter(&v0.id, b"counter_1");
        let v2 = 0x2::object::id_bytes<Counter>(v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v1.count));
        let v3 = get_counter(&v0.id, b"counter_2");
        let v4 = 0x2::object::id_bytes<Counter>(v3);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v3.count));
        (v2, v4)
    }

    public(friend) fun vrf_input_from_player(arg0: &Registry, arg1: u64, arg2: address) : (vector<u8>, vector<u8>) {
        let v0 = 0x2::vec_map::get<address, Game>(&get_playground(&arg0.id, arg1).opened_games, &arg2);
        (*0x1::option::borrow<vector<u8>>(&v0.vrf_input_1), *0x1::option::borrow<vector<u8>>(&v0.vrf_input_2))
    }

    public(friend) entry fun withdraw_stakes<T0>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        registry_whitelist_check(arg0, arg2);
        let v0 = &mut arg0.id;
        let v1 = get_mut_playground(v0, arg1);
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x1::type_name::get<T0>())) {
            let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
            let v3 = 0x2::balance::value<T0>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v3), arg2), 0x2::tx_context::sender(arg2));
            let v4 = WithdrawStakes{
                signer     : 0x2::tx_context::sender(arg2),
                index      : arg1,
                token_type : 0x1::type_name::get<T0>(),
                amount     : v3,
            };
            0x2::event::emit<WithdrawStakes>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

