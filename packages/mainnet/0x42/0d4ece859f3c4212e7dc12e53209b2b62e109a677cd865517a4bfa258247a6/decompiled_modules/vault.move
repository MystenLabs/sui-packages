module 0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        total_fee_a: u64,
        total_fee_b: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        admin_public_key: vector<u8>,
        claims: 0x2::table::Table<address, 0x2::table::Table<u64, u64>>,
        epoch_totals: 0x2::table::Table<u64, u64>,
    }

    struct LpVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_bag: 0x2::bag::Bag,
        curator: address,
        fee_vault: Vault<T0, T1>,
    }

    public fun id_to_address(arg0: &0x2::object::ID) : address {
        0x2::object::id_to_address(arg0)
    }

    public fun add_position<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        0x2::bag::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_bag, b"position", arg1);
    }

    public fun claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<u64, u64>(&arg0.epoch_totals, arg1), 2);
        let v1 = 0x2::table::borrow<u64, u64>(&arg0.epoch_totals, arg1);
        let v2 = if (!0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg0.claims, v0)) {
            0x2::table::add<address, 0x2::table::Table<u64, u64>>(&mut arg0.claims, v0, 0x2::table::new<u64, u64>(arg3));
            0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.claims, v0)
        } else {
            0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.claims, v0)
        };
        assert!(!0x2::table::contains<u64, u64>(v2, arg1), 3);
        0x2::table::add<u64, u64>(v2, arg1, arg2);
        0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::emit_fee_claimed<T0, T1>(0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::get_id(&arg0.id), v0, 0, arg2, arg2, *v1);
        0x2::coin::take<T1>(&mut arg0.balance_b, arg2, arg3)
    }

    public fun collect_lp_fee<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.curator == v0, 1);
        let v1 = 0x2::bag::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_bag, b"position");
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v1, true);
        let v4 = v3;
        let v5 = v2;
        0x2::bag::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_bag, b"position", v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        0x2::balance::join<T0>(&mut arg0.fee_vault.balance_a, v5);
        0x2::balance::join<T1>(&mut arg0.fee_vault.balance_b, v4);
        arg0.fee_vault.total_fee_a = arg0.fee_vault.total_fee_a + v6;
        arg0.fee_vault.total_fee_b = arg0.fee_vault.total_fee_b + v7;
        let v8 = arg0.fee_vault.epoch;
        if (!0x2::table::contains<u64, u64>(&arg0.fee_vault.epoch_totals, v8)) {
            0x2::table::add<u64, u64>(&mut arg0.fee_vault.epoch_totals, v8, v7);
        } else {
            let v9 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.fee_vault.epoch_totals, v8);
            *v9 = *v9 + v7;
        };
        arg0.fee_vault.epoch = v8 + 1;
        0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::emit_fee_collected<T0, T1>(0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::get_id(&arg0.id), v6, v7, v0, arg3);
    }

    public fun get_fee_vault<T0, T1>(arg0: &LpVault<T0, T1>) : &Vault<T0, T1> {
        &arg0.fee_vault
    }

    public fun id<T0, T1>(arg0: &LpVault<T0, T1>) : 0x2::object::ID {
        0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::get_id(&arg0.id)
    }

    public fun new_lp_vault<T0, T1>(arg0: 0x2::bag::Bag, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : LpVault<T0, T1> {
        let v0 = Vault<T0, T1>{
            id               : 0x2::object::new(arg3),
            epoch            : 0,
            total_fee_a      : 0,
            total_fee_b      : 0,
            balance_a        : 0x2::balance::zero<T0>(),
            balance_b        : 0x2::balance::zero<T1>(),
            admin_public_key : arg2,
            claims           : 0x2::table::new<address, 0x2::table::Table<u64, u64>>(arg3),
            epoch_totals     : 0x2::table::new<u64, u64>(arg3),
        };
        LpVault<T0, T1>{
            id           : 0x2::object::new(arg3),
            position_bag : arg0,
            curator      : arg1,
            fee_vault    : v0,
        }
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x420d4ece859f3c4212e7dc12e53209b2b62e109a677cd865517a4bfa258247a6::events::get_id(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

