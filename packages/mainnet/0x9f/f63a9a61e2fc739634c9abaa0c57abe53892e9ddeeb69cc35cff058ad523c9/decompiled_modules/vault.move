module 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        total_fee_a: u64,
        total_fee_b: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        admin_public_key: vector<u8>,
        admin_key_id: address,
        claims: 0x2::table::Table<address, 0x2::table::Table<u64, u64>>,
        epoch_totals: 0x2::table::Table<u64, u64>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
    }

    struct LpVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        curator: address,
        unlock_at: u64,
        fee_vault: Vault<T0, T1>,
    }

    public fun id<T0, T1>(arg0: &LpVault<T0, T1>) : 0x2::object::ID {
        0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg0.id)
    }

    public fun id_to_address(arg0: &0x2::object::ID) : address {
        0x2::object::id_to_address(arg0)
    }

    public fun claim<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.fee_vault.signatures, arg4), 4);
        let v1 = &mut arg0.fee_vault;
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &v1.admin_public_key, &arg3), 1);
        0x2::table::add<vector<u8>, bool>(&mut v1.signatures, arg4, true);
        let v2 = 0x2::address::to_string(0x2::object::uid_to_address(&arg0.id));
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut v2, 0x2::address::to_string(v0));
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg2));
        assert!(0x1::string::utf8(arg3) == v2, 2);
        assert!(0x2::table::contains<u64, u64>(&v1.epoch_totals, arg1), 2);
        let v3 = 0x2::table::borrow<u64, u64>(&v1.epoch_totals, arg1);
        let v4 = if (!0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&v1.claims, v0)) {
            0x2::table::add<address, 0x2::table::Table<u64, u64>>(&mut v1.claims, v0, 0x2::table::new<u64, u64>(arg5));
            0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut v1.claims, v0)
        } else {
            0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut v1.claims, v0)
        };
        assert!(!0x2::table::contains<u64, u64>(v4, arg1), 3);
        0x2::table::add<u64, u64>(v4, arg1, arg2);
        0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_fee_claimed<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg0.id), v0, 0, arg2, arg2, *v3, arg1);
        0x2::coin::take<T1>(&mut v1.balance_b, arg2, arg5)
    }

    public fun collect_lp_fee<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.fee_vault.admin_key_id == v0, 1);
        assert!(!0x2::table::contains<u64, u64>(&arg0.fee_vault.epoch_totals, arg4), 5);
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            arg0.fee_vault.epoch = arg4;
            0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_fee_collected<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg0.id), 0, 0, arg4, v0, arg3);
            return
        };
        let v1 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v1, true);
        let v4 = v3;
        let v5 = v2;
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        0x2::balance::join<T0>(&mut arg0.fee_vault.balance_a, v5);
        0x2::balance::join<T1>(&mut arg0.fee_vault.balance_b, v4);
        arg0.fee_vault.total_fee_a = arg0.fee_vault.total_fee_a + v6;
        arg0.fee_vault.total_fee_b = arg0.fee_vault.total_fee_b + v7;
        if (!0x2::table::contains<u64, u64>(&arg0.fee_vault.epoch_totals, arg4)) {
            0x2::table::add<u64, u64>(&mut arg0.fee_vault.epoch_totals, arg4, v7);
        } else {
            let v8 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.fee_vault.epoch_totals, arg4);
            *v8 = *v8 + v7;
        };
        arg0.fee_vault.epoch = arg4;
        0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_fee_collected<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg0.id), v6, v7, arg4, v0, arg3);
    }

    public fun get_fee_vault<T0, T1>(arg0: &LpVault<T0, T1>) : &Vault<T0, T1> {
        &arg0.fee_vault
    }

    public fun get_position_info<T0, T1>(arg0: &LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionManager) : 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo> {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            return 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo>()
        };
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position));
        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_position_exist(arg1, v0)) {
            return 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo>()
        };
        0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::PositionInfo>(*0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::borrow_position_info(arg1, v0))
    }

    public fun new_lp_vault<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: u64, arg2: address, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Vault<T0, T1>{
            id               : 0x2::object::new(arg5),
            epoch            : 0,
            total_fee_a      : 0,
            total_fee_b      : 0,
            balance_a        : 0x2::balance::zero<T0>(),
            balance_b        : 0x2::balance::zero<T1>(),
            admin_public_key : arg3,
            admin_key_id     : arg4,
            claims           : 0x2::table::new<address, 0x2::table::Table<u64, u64>>(arg5),
            epoch_totals     : 0x2::table::new<u64, u64>(arg5),
            signatures       : 0x2::table::new<vector<u8>, bool>(arg5),
        };
        0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_vault_created<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&v0.id), arg2, arg3, v0.epoch);
        let v1 = LpVault<T0, T1>{
            id        : 0x2::object::new(arg5),
            position  : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            curator   : arg2,
            unlock_at : arg1,
            fee_vault : v0,
        };
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v1.position, arg0);
        0x2::transfer::share_object<LpVault<T0, T1>>(v1);
        id<T0, T1>(&v1)
    }

    public fun unlock<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(arg0.curator == 0x2::tx_context::sender(arg2), 7);
        assert!(arg0.unlock_at <= 0x2::clock::timestamp_ms(arg1), 6);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 6);
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position)
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

