module 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::blub_ambassador {
    struct AmbassadorRewards has store, key {
        id: 0x2::object::UID,
        balance_bag: 0x2::bag::Bag,
        factor: u64,
    }

    struct PaymentHistoryItem has copy, drop, store {
        timestamp: u64,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        usd_amount: u64,
        calculated_pool_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    struct DepositEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct BlubAmbassador has store, key {
        id: 0x2::object::UID,
        medias: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        payment_history: 0x2::table::Table<u64, PaymentHistoryItem>,
        wait_claimed_rewards: u64,
        payment_every_week: u64,
        owner: address,
    }

    struct CreateAmbassadorEvent has copy, drop {
        ambassador_id: 0x2::object::ID,
        creator: address,
    }

    struct ClaimRewardsEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        claimed_amount: u64,
        owner: address,
    }

    struct BLUB_AMBASSADOR has drop {
        dummy_field: bool,
    }

    public fun activate_ambassador(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: &mut BlubAmbassador, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::check_staff(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<BlubAmbassador>(arg1);
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_pause(arg0, v0, false, arg4);
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_requested_time(arg0, v0, 0x2::clock::timestamp_ms(arg3), arg4);
        arg1.payment_every_week = arg2;
    }

    fun add_claimed_rewards_history<T0>(arg0: &mut BlubAmbassador, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PaymentHistoryItem{
            timestamp          : arg4,
            amount             : arg3,
            coin_type          : 0x1::type_name::get<T0>(),
            usd_amount         : arg2,
            calculated_pool_id : arg1,
        };
        0x2::table::add<u64, PaymentHistoryItem>(&mut arg0.payment_history, arg4, v0);
    }

    public fun add_rewards<T0>(arg0: &mut AmbassadorRewards, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance_bag, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, v1, 0x2::balance::zero<T0>());
        };
        let v2 = DepositEvent{
            coin_type      : v1,
            deposit_amount : 0x2::balance::value<T0>(&v0),
            after_amount   : 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, v1), v0),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public entry fun add_staff(arg0: &0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AdminCap, arg1: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg2: address) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_staff(arg0, arg1, arg2);
    }

    fun claim_rewards<T0>(arg0: &mut AmbassadorRewards, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance_bag, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3);
        let v2 = WithdrawEvent{
            coin_type       : v0,
            withdraw_amount : arg1,
            after_amount    : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public fun collect_salary<T0, T1, T2>(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: &mut BlubAmbassador, arg2: &mut AmbassadorRewards, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg1.owner == v0, 1);
        assert!(!0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::get_ambassador_pause(arg0, 0x2::object::id<BlubAmbassador>(arg1)), 2);
        let v1 = 0x2::object::id<BlubAmbassador>(arg1);
        let v2 = 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::get_ambassador_requested_time(arg0, v1);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = (v3 - v2) / 604800000;
        let v5 = arg1.wait_claimed_rewards + v4 * arg1.payment_every_week;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, true, true, v5);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6) * arg2.factor / 1000;
        if (arg5) {
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T1>(arg4, false, true, v7);
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v8);
            let v10 = claim_rewards<T2>(arg2, v9, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v10, v0);
            add_claimed_rewards_history<T2>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4), v5, v9, v3);
            let v11 = ClaimRewardsEvent{
                coin_type      : 0x1::type_name::get<T2>(),
                claimed_amount : v9,
                owner          : v0,
            };
            0x2::event::emit<ClaimRewardsEvent>(v11);
        } else {
            let v12 = claim_rewards<T2>(arg2, v7, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v12, v0);
            add_claimed_rewards_history<T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), v5, v7, v3);
            let v13 = ClaimRewardsEvent{
                coin_type      : 0x1::type_name::get<T1>(),
                claimed_amount : v7,
                owner          : v0,
            };
            0x2::event::emit<ClaimRewardsEvent>(v13);
        };
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_requested_time(arg0, v1, v2 + v4 * 604800000, arg7);
        arg1.wait_claimed_rewards = 0;
    }

    public fun create_ambassador(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 != @0x0) {
            arg3
        } else {
            0x2::tx_context::sender(arg4)
        };
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg2), 0);
        let v2 = BlubAmbassador{
            id                   : 0x2::object::new(arg4),
            medias               : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg4),
            payment_history      : 0x2::table::new<u64, PaymentHistoryItem>(arg4),
            wait_claimed_rewards : 0,
            payment_every_week   : 0,
            owner                : v0,
        };
        let v3 = 0;
        while (v3 < v1) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2.medias, *0x1::vector::borrow<0x1::string::String>(&arg1, v3), *0x1::vector::borrow<0x1::string::String>(&arg2, v3));
            v3 = v3 + 1;
            if (v3 == v1) {
                break
            };
        };
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_owner(arg0, 0x2::object::id<BlubAmbassador>(&v2), v0);
        let v4 = CreateAmbassadorEvent{
            ambassador_id : 0x2::object::id<BlubAmbassador>(&v2),
            creator       : v0,
        };
        0x2::event::emit<CreateAmbassadorEvent>(v4);
        0x2::transfer::share_object<BlubAmbassador>(v2);
    }

    public entry fun deactivate_ambassador(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: &BlubAmbassador, arg2: &mut 0x2::tx_context::TxContext) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::check_staff(arg0, 0x2::tx_context::sender(arg2));
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_pause(arg0, 0x2::object::id<BlubAmbassador>(arg1), true, arg2);
    }

    fun init(arg0: BLUB_AMBASSADOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLUB_AMBASSADOR>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AmbassadorRewards{
            id          : 0x2::object::new(arg1),
            balance_bag : 0x2::bag::new(arg1),
            factor      : 1000,
        };
        0x2::transfer::public_share_object<AmbassadorRewards>(v0);
    }

    public entry fun remove_staff(arg0: &0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AdminCap, arg1: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg2: address) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::remove_staff(arg0, arg1, arg2);
    }

    public fun update_ambassador_medias(arg0: &mut BlubAmbassador, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.medias, arg1)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.medias, arg1);
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.medias, arg1, arg2);
    }

    public entry fun update_ambassador_payment_every_week(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: &mut BlubAmbassador, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::check_staff(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<BlubAmbassador>(arg1);
        let v1 = 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::get_ambassador_requested_time(arg0, v0);
        let v2 = (0x2::clock::timestamp_ms(arg3) - v1) / 604800000;
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::set_ambassador_requested_time(arg0, v0, v1 + v2 * 604800000, arg4);
        arg1.payment_every_week = arg2;
        arg1.wait_claimed_rewards = arg1.wait_claimed_rewards + v2 * arg2;
    }

    public entry fun update_factor(arg0: &mut 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: &mut AmbassadorRewards, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::check_staff(arg0, 0x2::tx_context::sender(arg3));
        arg1.factor = arg2;
    }

    public entry fun withdraw_rewards<T0, T1>(arg0: &0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AdminCap, arg1: &mut AmbassadorRewards, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg2 > 0) {
            let v1 = claim_rewards<T0>(arg1, arg2, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(claim_rewards<T1>(arg1, arg3, arg4), v0);
        };
    }

    // decompiled from Move bytecode v6
}

