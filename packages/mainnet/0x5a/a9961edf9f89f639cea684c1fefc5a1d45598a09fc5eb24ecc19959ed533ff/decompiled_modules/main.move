module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::main {
    public entry fun add_boat_for_next_dao(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_liquidity_for_next_dao<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg0, arg1, 0x2::coin::into_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg2), arg3, arg4);
    }

    public entry fun add_sui_for_next_dao(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_liquidity_for_next_dao<0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), arg3, arg4);
    }

    public entry fun buy_amount_of_boat_for_sui(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(0x2::coin::from_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_boat<0x2::sui::SUI>(arg0, 0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun buy_amount_of_boat_for_sui_into_coin(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg3: u64) {
        0x2::balance::join<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x2::coin::balance_mut<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg2), 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_boat<0x2::sui::SUI>(arg0, 0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg3));
    }

    public entry fun buy_boat_for_amount_of_sui(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(0x2::coin::from_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_boat<0x2::sui::SUI>(arg0, 0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_in_boat<0x2::sui::SUI>(arg0, arg2)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun buy_boat_for_amount_of_sui_into_coin(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg3: u64) {
        0x2::balance::join<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x2::coin::balance_mut<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg2), 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_boat<0x2::sui::SUI>(arg0, 0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_in_boat<0x2::sui::SUI>(arg0, arg3)));
    }

    public entry fun buy_max_boat_for_sui(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(0x2::coin::from_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_max_boat<0x2::sui::SUI>(arg0, 0x2::coin::balance_mut<0x2::sui::SUI>(arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::share(new_launchpad_with_default_policies(arg0));
    }

    public entry fun launch_next_dao<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::begin_launch<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, 0x2::sui::SUI>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T1>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T2>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T3>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T4>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T5>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::launch_with_token<T0, T6>(arg0, arg2, &mut v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::finalize_launch<T0>(arg0, arg2, v0, arg5, arg6);
    }

    fun new_launchpad_with_default_policies(arg0: &mut 0x2::tx_context::TxContext) : 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::new_cap(arg0);
        let v1 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::new(arg0);
        let v2 = 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_trade_boat::BuyMaxBOATWitness>();
        let v3 = 0x1::vector::empty<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>();
        0x1::vector::push_back<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>(&mut v3, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::permit_to_touch_any_liquidity());
        let v4 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::new_conf(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_trade_boat::buy_max_boat_description(), v3);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::recommend_policy(&mut v1, &v0, v2, v4);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_default_policy(&mut v1, &v0, v2, v4);
        let v5 = 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_trade_boat::SellBOATWitness>();
        let v6 = 0x1::vector::empty<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>();
        0x1::vector::push_back<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>(&mut v6, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::permit_to_touch_liquidity_for_token<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>());
        let v7 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::new_conf(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_trade_boat::sell_boat_description(), v6);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::recommend_policy(&mut v1, &v0, v5, v7);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_default_policy(&mut v1, &v0, v5, v7);
        let v8 = 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_meta::ListRecommendedPoliciesWitness>();
        let v9 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::new_conf(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_meta::list_recommended_policies_description(), 0x1::vector::empty<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>());
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::recommend_policy(&mut v1, &v0, v8, v9);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_default_policy(&mut v1, &v0, v8, v9);
        let v10 = 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_meta::AddRecommendedPolicyWitness>();
        let v11 = 0x1::vector::empty<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>();
        0x1::vector::push_back<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyPermission>(&mut v11, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::permit_to_add_new_policy());
        let v12 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::new_conf(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_meta::add_recommended_policy_description(), v11);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::recommend_policy(&mut v1, &v0, v10, v12);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::add_default_policy(&mut v1, &v0, v10, v12);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::destroy_cap(v0);
        v1
    }

    public entry fun sell_amount_of_boat_for_sui(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::sell_boat<0x2::sui::SUI>(arg0, 0x2::balance::split<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x2::coin::balance_mut<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg1), arg2)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun sell_amount_of_boat_for_sui_into_coin(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: &mut 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64) {
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::sell_boat<0x2::sui::SUI>(arg0, 0x2::balance::split<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x2::coin::balance_mut<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg1), arg3)));
    }

    public entry fun sell_boat_for_sui(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg1: 0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::sell_boat<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_boat_from_next_dao(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::withdraw_liquidity_from_next_dao<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg0, arg1, arg2);
        if (0x2::balance::value<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(&v0) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(0x2::coin::from_balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(v0, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(v0);
        };
    }

    public entry fun withdraw_sui_from_next_dao(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::withdraw_liquidity_from_next_dao<0x2::sui::SUI>(arg0, arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

