module 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::activity {
    struct ActivityProfits has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct ActivityConfig has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        max_supply: u64,
        total_supply: u64,
        coin_prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        token_type: u64,
        name: 0x1::string::String,
        type: 0x1::string::String,
        collection: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct WithdrawActivityProfitsRequest has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
    }

    struct BuyEvent has copy, drop {
        config: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        token_type: u64,
        total_supply: u64,
        max_supply: u64,
    }

    struct CreateConfigEvent has copy, drop {
        config: 0x2::object::ID,
        token_type: u64,
        type: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct UpdateConfigEvent has copy, drop {
        config: 0x2::object::ID,
        token_type: u64,
        type: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct ResetSupplyEvent has copy, drop {
        config: 0x2::object::ID,
        total_supply: u64,
    }

    struct SetPriceEvent has copy, drop {
        config: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
    }

    struct RemovePriceEvent has copy, drop {
        config: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    fun assert_coin_type_exist(arg0: bool) {
        assert!(arg0, 2);
    }

    fun assert_current_time_ge_start_time(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 >= arg1, 3);
        };
    }

    fun assert_current_time_lt_end_time(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 < arg1, 4);
        };
    }

    fun assert_payment_amount(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 0);
    }

    fun assert_price_gt_zero(arg0: u64) {
        assert!(arg0 > 0, 5);
    }

    fun assert_time_set(arg0: u64, arg1: u64) {
        if (arg0 > 0 && arg1 > 0) {
            assert!(arg1 >= arg0, 6);
        };
    }

    fun assert_total_supply(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 + arg2 <= arg1, 1);
    }

    public entry fun buy<T0>(arg0: &mut ActivityConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut ActivityProfits, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg4.version, 9);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0;
        let v3 = false;
        let v4 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.coin_prices, &v1);
        if (0x1::option::is_some<u64>(&v4)) {
            v3 = true;
            v2 = *0x1::option::borrow<u64>(&v4);
        };
        assert_coin_type_exist(v3);
        assert_price_gt_zero(v2);
        assert_current_time_ge_start_time(v0, arg0.start_time);
        assert_current_time_lt_end_time(v0, arg0.end_time);
        assert_total_supply(arg0.total_supply, arg0.max_supply, arg2);
        pay<T0>(arg4, v2 * arg2, arg1, arg5);
        let v5 = 0;
        while (v5 < arg2) {
            0x2::transfer::public_transfer<0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::GachaBall>(0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha::mint(arg0.token_type, arg0.collection, arg0.name, arg0.type, arg0.description, arg5), 0x2::tx_context::sender(arg5));
            v5 = v5 + 1;
        };
        arg0.total_supply = arg0.total_supply + arg2;
        let v6 = BuyEvent{
            config       : 0x2::object::id<ActivityConfig>(arg0),
            amount       : arg2,
            coin_type    : v1,
            price        : v2,
            token_type   : arg0.token_type,
            total_supply : arg0.total_supply,
            max_supply   : arg0.max_supply,
        };
        0x2::event::emit<BuyEvent>(v6);
    }

    public entry fun create_config(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg10: &mut 0x2::tx_context::TxContext) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg9);
        assert_time_set(arg1, arg2);
        let v0 = ActivityConfig{
            id           : 0x2::object::new(arg10),
            start_time   : arg1,
            end_time     : arg2,
            max_supply   : arg3,
            total_supply : 0,
            coin_prices  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            token_type   : arg4,
            name         : arg5,
            type         : arg6,
            collection   : arg7,
            description  : arg8,
        };
        let v1 = CreateConfigEvent{
            config     : 0x2::object::id<ActivityConfig>(&v0),
            token_type : arg4,
            type       : arg6,
            name       : arg5,
        };
        0x2::event::emit<CreateConfigEvent>(v1);
        0x2::transfer::public_share_object<ActivityConfig>(v0);
    }

    public fun get_activity_profits<T0>(arg0: &ActivityProfits) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ActivityProfits{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<ActivityProfits>(v0);
    }

    entry fun migrate(arg0: &mut ActivityProfits, arg1: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg2: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(arg0.version < 1, 10);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    fun pay<T0>(arg0: &mut ActivityProfits, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg2));
        assert_payment_amount(arg1, v0);
        let v1 = 0x1::type_name::get<T0>();
        if (arg1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - arg1, arg3), 0x2::tx_context::sender(arg3));
        };
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(arg2));
        };
    }

    public entry fun remove_price<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut ActivityConfig, arg2: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.coin_prices, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.coin_prices, &v0);
            let v3 = RemovePriceEvent{
                config    : 0x2::object::id<ActivityConfig>(arg1),
                coin_type : v0,
            };
            0x2::event::emit<RemovePriceEvent>(v3);
        };
    }

    public entry fun reset_supply(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut ActivityConfig, arg2: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg2);
        let v0 = ResetSupplyEvent{
            config       : 0x2::object::id<ActivityConfig>(arg1),
            total_supply : arg1.total_supply,
        };
        0x2::event::emit<ResetSupplyEvent>(v0);
        arg1.total_supply = 0;
    }

    public entry fun set_price<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut ActivityConfig, arg2: u64, arg3: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg3);
        assert_price_gt_zero(arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.coin_prices, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.coin_prices, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.coin_prices, v0, arg2);
        };
        let v1 = SetPriceEvent{
            config    : 0x2::object::id<ActivityConfig>(arg1),
            coin_type : v0,
            price     : arg2,
        };
        0x2::event::emit<SetPriceEvent>(v1);
    }

    public entry fun update_config(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut ActivityConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg10);
        assert_time_set(arg2, arg3);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        arg1.max_supply = arg4;
        arg1.token_type = arg5;
        arg1.name = arg6;
        arg1.type = arg7;
        arg1.collection = arg8;
        arg1.description = arg9;
        let v0 = UpdateConfigEvent{
            config     : 0x2::object::id<ActivityConfig>(arg1),
            token_type : arg5,
            type       : arg7,
            name       : arg6,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    fun withdraw_activity_profits<T0>(arg0: &mut ActivityProfits, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())), arg2), arg1);
    }

    public entry fun withdraw_activity_profits_execute<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut ActivityProfits, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 9);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawActivityProfitsRequest>(arg1, &arg2, arg5);
                assert!(v2.coin_type == 0x1::type_name::get<T0>(), 7);
                withdraw_activity_profits<T0>(arg4, v2.to, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 8
    }

    public entry fun withdraw_activity_profits_request<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg3);
        let v0 = WithdrawActivityProfitsRequest{
            id        : 0x2::object::new(arg3),
            coin_type : 0x1::type_name::get<T0>(),
            to        : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawActivityProfitsRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawActivityProfitsRequest>(arg1, *0x1::string::bytes(&v1), 5, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

