module 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        fee_pool: FeePool,
        liquidator_fee_pool: FeePool,
        authority: 0x2::vec_set::VecSet<address>,
        u64_padding: vector<u64>,
    }

    struct FeePool has store, key {
        id: 0x2::object::UID,
        fee_infos: vector<FeeInfo>,
    }

    struct FeeInfo has copy, drop, store {
        token: 0x1::type_name::TypeName,
        value: u64,
    }

    struct SendFeeEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ProtocolFeeEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PutInsuranceFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun add_competition_leaderboard(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun add_tails_exp_and_leaderboard(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (((arg5 as u128) * (arg6 as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u128)) as u64);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg4, v0);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg3, 0x1::ascii::string(b"exp_leaderboard"), arg4, v0, arg7, arg8);
    }

    public(friend) fun charge_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                v2.value = v2.value + v0;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>()), arg1);
                let v3 = ProtocolFeeEvent{
                    token  : 0x1::type_name::get<T0>(),
                    amount : v0,
                };
                0x2::event::emit<ProtocolFeeEvent>(v3);
                return
            };
            v1 = v1 + 1;
        };
        let v4 = FeeInfo{
            token : 0x1::type_name::get<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.fee_pool.fee_infos, v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>(), arg1);
        let v5 = ProtocolFeeEvent{
            token  : 0x1::type_name::get<T0>(),
            amount : v0,
        };
        0x2::event::emit<ProtocolFeeEvent>(v5);
    }

    public(friend) fun charge_liquidator_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&arg0.liquidator_fee_pool.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                v2.value = v2.value + v0;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::get<T0>()), arg1);
                let v3 = PutInsuranceFundEvent{
                    token  : 0x1::type_name::get<T0>(),
                    amount : v0,
                };
                0x2::event::emit<PutInsuranceFundEvent>(v3);
                return
            };
            v1 = v1 + 1;
        };
        let v4 = FeeInfo{
            token : 0x1::type_name::get<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::get<T0>(), arg1);
        let v5 = PutInsuranceFundEvent{
            token  : 0x1::type_name::get<T0>(),
            amount : v0,
        };
        0x2::event::emit<PutInsuranceFundEvent>(v5);
    }

    entry fun send_fee<T0>(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                if (v1.value > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::get<T0>())), arg1), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
                };
                let v2 = SendFeeEvent{
                    token  : 0x1::type_name::get<T0>(),
                    amount : v1.value,
                };
                0x2::event::emit<SendFeeEvent>(v2);
                v1.value = 0;
                return
            };
            v0 = v0 + 1;
        };
    }

    entry fun send_liquidator_fee<T0>(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.liquidator_fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::get<T0>())), arg1), @0x83fdb2649217b1beb5dccf81f21b6425718579b7902ca5fc0842b71d2cb283eb);
                let v2 = SendFeeEvent{
                    token  : 0x1::type_name::get<T0>(),
                    amount : v1.value,
                };
                0x2::event::emit<SendFeeEvent>(v2);
                v1.value = 0;
                return
            };
            v0 = v0 + 1;
        };
    }

    entry fun upgrade(arg0: &mut Version) {
        version_check(arg0);
        arg0.value = 5;
    }

    public(friend) fun verify(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::unauthorized());
    }

    public(friend) fun version_check(arg0: &Version) {
        assert!(5 >= arg0.value, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::invalid_version());
    }

    // decompiled from Move bytecode v6
}

