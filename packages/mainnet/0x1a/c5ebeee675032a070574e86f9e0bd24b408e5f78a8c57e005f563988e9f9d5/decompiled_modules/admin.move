module 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::admin {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        fee_pool: FeePool,
        liquidator_fee_pool: FeePool,
        authority: 0x2::vec_set::VecSet<address>,
        u64_padding: vector<u64>,
    }

    struct GovernanceBootstrapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GovernanceMultisigAuthorized has copy, drop {
        multisig: address,
        upgrade_cap: address,
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

    entry fun add_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &arg1), 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::authority_already_existed());
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    public(friend) fun add_competition_leaderboard(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun add_tails_exp_and_leaderboard(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (((arg5 as u128) * (arg6 as u128) / (0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::math::multiplier(0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::math::get_usd_decimal()) as u128)) as u64);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg4, v0);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg3, 0x1::ascii::string(b"exp_leaderboard"), arg4, v0, arg7, arg8);
    }

    fun authorize_governance_once(arg0: &mut Version) {
        let v0 = GovernanceBootstrapKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<GovernanceBootstrapKey>(&arg0.id, v0), 12002);
        let v1 = @0x3485c458652486279187ae82411950b75f164d4983b9aef735a076d17f7d95e4;
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &v1), 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::authority_already_existed());
        let v2 = GovernanceBootstrapKey{dummy_field: false};
        0x2::dynamic_field::add<GovernanceBootstrapKey, bool>(&mut arg0.id, v2, true);
        0x2::vec_set::insert<address>(&mut arg0.authority, v1);
        let v3 = GovernanceMultisigAuthorized{
            multisig    : v1,
            upgrade_cap : @0x4621da82743aedd0b04949cca955483c78508f39ad806ab27834b0cbfe8defa7,
        };
        0x2::event::emit<GovernanceMultisigAuthorized>(v3);
    }

    entry fun authorize_upgrade_multisig_v12(arg0: &0x2::package::UpgradeCap, arg1: &mut Version, arg2: &0x2::tx_context::TxContext) {
        verify_governance_binding(0x2::object::id_address<0x2::package::UpgradeCap>(arg0), 0x2::package::version(arg0), 0x2::object::id_address<Version>(arg1), 0x2::tx_context::sender(arg2));
        version_check(arg1);
        authorize_governance_once(arg1);
    }

    public(friend) fun charge_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v1);
            if (v2.token == 0x1::type_name::with_defining_ids<T0>()) {
                v2.value = v2.value + v0;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>()), arg1);
                let v3 = ProtocolFeeEvent{
                    token  : 0x1::type_name::with_defining_ids<T0>(),
                    amount : v0,
                };
                0x2::event::emit<ProtocolFeeEvent>(v3);
                return
            };
            v1 = v1 + 1;
        };
        let v4 = FeeInfo{
            token : 0x1::type_name::with_defining_ids<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.fee_pool.fee_infos, v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>(), arg1);
        let v5 = ProtocolFeeEvent{
            token  : 0x1::type_name::with_defining_ids<T0>(),
            amount : v0,
        };
        0x2::event::emit<ProtocolFeeEvent>(v5);
    }

    public(friend) fun charge_liquidator_fee<T0>(arg0: &mut Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&arg0.liquidator_fee_pool.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v1);
            if (v2.token == 0x1::type_name::with_defining_ids<T0>()) {
                v2.value = v2.value + v0;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>()), arg1);
                let v3 = PutInsuranceFundEvent{
                    token  : 0x1::type_name::with_defining_ids<T0>(),
                    amount : v0,
                };
                0x2::event::emit<PutInsuranceFundEvent>(v3);
                return
            };
            v1 = v1 + 1;
        };
        let v4 = FeeInfo{
            token : 0x1::type_name::with_defining_ids<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.liquidator_fee_pool.fee_infos, v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>(), arg1);
        let v5 = PutInsuranceFundEvent{
            token  : 0x1::type_name::with_defining_ids<T0>(),
            amount : v0,
        };
        0x2::event::emit<PutInsuranceFundEvent>(v5);
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
            value               : 8,
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
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &arg1), 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::authority_doest_not_exist());
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
        assert!(0x2::vec_set::length<address>(&arg0.authority) > 0, 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::authority_empty());
    }

    entry fun send_fee<T0>(arg0: &mut Version, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_pool.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_pool.fee_infos, v0);
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                if (v1.value > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_pool.id, 0x1::type_name::with_defining_ids<T0>())), arg1), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
                    let v2 = SendFeeEvent{
                        token  : 0x1::type_name::with_defining_ids<T0>(),
                        amount : v1.value,
                    };
                    0x2::event::emit<SendFeeEvent>(v2);
                    v1.value = 0;
                };
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
            if (v1.token == 0x1::type_name::with_defining_ids<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.liquidator_fee_pool.id, 0x1::type_name::with_defining_ids<T0>())), arg1), @0x83fdb2649217b1beb5dccf81f21b6425718579b7902ca5fc0842b71d2cb283eb);
                let v2 = SendFeeEvent{
                    token  : 0x1::type_name::with_defining_ids<T0>(),
                    amount : v1.value,
                };
                0x2::event::emit<SendFeeEvent>(v2);
                v1.value = 0;
                return
            };
            v0 = v0 + 1;
        };
    }

    entry fun upgrade(arg0: &mut Version, arg1: &0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        arg0.value = 8;
    }

    public(friend) fun verify(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::unauthorized());
    }

    fun verify_governance_binding(arg0: address, arg1: u64, arg2: address, arg3: address) {
        let v0 = if (arg0 == @0x4621da82743aedd0b04949cca955483c78508f39ad806ab27834b0cbfe8defa7) {
            if (arg1 == 12) {
                if (arg2 == @0x7c30204bd3f4dc37918281907308e0d7d09a75a6826473aec0caa1712ee149e5) {
                    arg3 == @0x3485c458652486279187ae82411950b75f164d4983b9aef735a076d17f7d95e4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 12001);
    }

    public(friend) fun version_check(arg0: &Version) {
        assert!(8 >= arg0.value, 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::error::invalid_version());
    }

    // decompiled from Move bytecode v7
}

