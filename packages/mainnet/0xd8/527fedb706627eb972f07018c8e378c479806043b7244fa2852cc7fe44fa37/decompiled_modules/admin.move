module 0xc427209145715a00a93d7e674a95c556a7147d79fda1bbaeb1a1cac5f9923966::admin {
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

    public(friend) fun add_tails_exp_amount(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: address, arg4: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg3, arg4);
    }

    entry fun add_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &arg1), 0);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    public(friend) fun add_exp_leaderboard(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, 0x1::ascii::string(b"exp_leaderboard"), arg3, arg4, arg5, arg6);
    }

    public(friend) fun charge_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                v1.value = v1.value + 0x2::balance::value<T0>(&arg1);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>()), arg1);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = FeeInfo{
            token : 0x1::type_name::with_defining_ids<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.fee_pool.fee_infos, v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>(), arg1);
    }

    public(friend) fun charge_liquidator_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.liquidator_fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                v1.value = v1.value + 0x2::balance::value<T0>(&arg1);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>()), arg1);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = FeeInfo{
            token : 0x1::type_name::with_defining_ids<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>(), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeePool{
            id        : 0x2::object::new(arg0),
            fee_infos : 0x1::vector::empty<FeeInfo>(),
        };
        let v1 = FeePool{
            id        : 0x2::object::new(arg0),
            fee_infos : 0x1::vector::empty<FeeInfo>(),
        };
        let v2 = Version{
            id                  : 0x2::object::new(arg0),
            value               : 2,
            fee_pool            : v0,
            liquidator_fee_pool : v1,
            authority           : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            u64_padding         : vector[],
        };
        0x2::transfer::share_object<Version>(v2);
    }

    entry fun install_ecosystem_manager_cap_entry(arg0: &mut Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap"), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::issue_manager_cap(arg1, arg2));
    }

    entry fun remove_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &arg1), 1);
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
        assert!(0x2::vec_set::length<address>(&arg0.authority) > 0, 2);
    }

    entry fun send_fee<T0>(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>())), arg1), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
                let v2 = SendFeeEvent{
                    token  : 0x1::type_name::with_defining_ids<T0>(),
                    amount : v1.value,
                };
                0x2::event::emit<SendFeeEvent>(v2);
                v1.value = 0;
            };
            v0 = v0 + 1;
        };
    }

    entry fun send_liquidator_fee<T0>(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.liquidator_fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>())), arg1), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
                let v2 = SendFeeEvent{
                    token  : 0x1::type_name::with_defining_ids<T0>(),
                    amount : v1.value,
                };
                0x2::event::emit<SendFeeEvent>(v2);
                v1.value = 0;
            };
            v0 = v0 + 1;
        };
    }

    entry fun upgrade(arg0: &mut Version) {
        version_check(arg0);
        arg0.value = 2;
    }

    public(friend) fun verify(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 4);
    }

    public(friend) fun version_check(arg0: &Version) {
        assert!(2 >= arg0.value, 3);
    }

    // decompiled from Move bytecode v6
}

