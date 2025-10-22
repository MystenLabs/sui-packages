module 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::ledger {
    struct ClientPositionKey has copy, drop, store {
        contract_id: u256,
        client: address,
    }

    struct Ledger<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        client_positions: 0x2::table::Table<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>,
        underlying_multiplier: u64,
        strike_multiplier: u64,
        surplus_wallet: address,
    }

    struct PositionParam has copy, drop {
        contract_id: u256,
        client: address,
        size: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64,
    }

    struct FundMovementParam has copy, drop {
        client: address,
        underlying_amount: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64,
        strike_amount: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64,
    }

    struct PositionsUpdated has copy, drop {
        backend_id: u64,
        ledger_id: 0x2::object::ID,
    }

    struct FundMovementsUpdated has copy, drop {
        backend_id: u64,
        ledger_id: 0x2::object::ID,
    }

    public(friend) fun create<T0, T1>(arg0: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::token_validator::TokenRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (_, v1) = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::token_validator::get_token_details<T0>(arg0);
        let (_, v3) = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::token_validator::get_token_details<T1>(arg0);
        let v4 = Ledger<T0, T1>{
            id                    : 0x2::object::new(arg1),
            client_positions      : 0x2::table::new<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(arg1),
            underlying_multiplier : pow_10(v1),
            strike_multiplier     : pow_10(v3),
            surplus_wallet        : @0x0,
        };
        0x2::transfer::share_object<Ledger<T0, T1>>(v4);
        0x2::object::id<Ledger<T0, T1>>(&v4)
    }

    public fun get_client_position<T0, T1>(arg0: &Ledger<T0, T1>, arg1: u256, arg2: address) : 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64 {
        let v0 = ClientPositionKey{
            contract_id : arg1,
            client      : arg2,
        };
        if (!0x2::table::contains<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&arg0.client_positions, v0)) {
            return 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::zero()
        };
        *0x2::table::borrow<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&arg0.client_positions, v0)
    }

    fun initialize_data<T0, T1>(arg0: &Ledger<T0, T1>, arg1: vector<FundMovementParam>) : (vector<address>, vector<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>, vector<bool>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<FundMovementParam>(&arg1)) {
            let v4 = 0x1::vector::borrow<FundMovementParam>(&arg1, v3);
            let v5 = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::is_zero(v4.underlying_amount);
            let v6 = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::is_zero(v4.strike_amount);
            let v7 = v5 && v6;
            assert!(!v7, 300);
            if (!v6) {
                0x1::vector::push_back<address>(&mut v0, v4.client);
                0x1::vector::push_back<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&mut v1, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::negate(v4.strike_amount));
                0x1::vector::push_back<bool>(&mut v2, false);
            };
            if (!v5) {
                0x1::vector::push_back<address>(&mut v0, v4.client);
                0x1::vector::push_back<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&mut v1, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::negate(v4.underlying_amount));
                0x1::vector::push_back<bool>(&mut v2, true);
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    public fun new_fund_movement_param(arg0: address, arg1: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64, arg2: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64) : FundMovementParam {
        FundMovementParam{
            client            : arg0,
            underlying_amount : arg1,
            strike_amount     : arg2,
        }
    }

    public fun new_position_param(arg0: u256, arg1: address, arg2: 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64) : PositionParam {
        PositionParam{
            contract_id : arg0,
            client      : arg1,
            size        : arg2,
        }
    }

    fun pow_10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun process_fund_movements<T0, T1>(arg0: &Ledger<T0, T1>, arg1: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::UtilityAccountCap, arg2: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::CapabilityRegistry, arg3: &mut 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::FundLock, arg4: vector<FundMovementParam>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = initialize_data<T0, T1>(arg0, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::coin::zero<T0>(arg7);
        let v7 = 0x2::coin::zero<T1>(arg7);
        let v8 = 0x1::vector::length<address>(&v5);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v9 < v8) {
            let v12 = *0x1::vector::borrow<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&v4, v9);
            if (0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::is_negative(v12)) {
                let v13 = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::negate(v12);
                if (*0x1::vector::borrow<bool>(&v3, v9)) {
                    0x2::coin::join<T0>(&mut v6, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_withdraw<T0>(arg1, arg2, arg3, *0x1::vector::borrow<address>(&v5, v9), 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v13), arg5, arg6, arg7));
                } else {
                    0x2::coin::join<T1>(&mut v7, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_withdraw<T1>(arg1, arg2, arg3, *0x1::vector::borrow<address>(&v5, v9), 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v13), arg5, arg6, arg7));
                };
            } else if (0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::is_positive(v12)) {
                if (*0x1::vector::borrow<bool>(&v3, v9)) {
                    v10 = v10 + 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v12);
                } else {
                    v11 = v11 + 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v12);
                };
            };
            v9 = v9 + 1;
        };
        let v14 = 0x2::coin::value<T0>(&v6);
        if (v14 < v10) {
            let v15 = v10 - v14;
            assert!(0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::balance_of<T0>(arg3, arg0.surplus_wallet) >= v15, 301);
            0x2::coin::join<T0>(&mut v6, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_withdraw<T0>(arg1, arg2, arg3, arg0.surplus_wallet, v15, arg5, arg6, arg7));
        };
        let v16 = 0x2::coin::value<T1>(&v7);
        if (v16 < v11) {
            let v17 = v11 - v16;
            assert!(0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::balance_of<T1>(arg3, arg0.surplus_wallet) >= v17, 301);
            0x2::coin::join<T1>(&mut v7, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_withdraw<T1>(arg1, arg2, arg3, arg0.surplus_wallet, v17, arg5, arg6, arg7));
        };
        v9 = 0;
        while (v9 < v8) {
            let v18 = *0x1::vector::borrow<0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&v4, v9);
            if (0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::is_positive(v18)) {
                if (*0x1::vector::borrow<bool>(&v3, v9)) {
                    0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_deposit<T0>(arg1, arg2, arg3, *0x1::vector::borrow<address>(&v5, v9), 0x2::coin::split<T0>(&mut v6, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v18), arg7), arg5, arg7);
                } else {
                    0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_deposit<T1>(arg1, arg2, arg3, *0x1::vector::borrow<address>(&v5, v9), 0x2::coin::split<T1>(&mut v7, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::as_u64(&v18), arg7), arg5, arg7);
                };
            };
            v9 = v9 + 1;
        };
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_deposit<T0>(arg1, arg2, arg3, arg0.surplus_wallet, v6, arg5, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T1>(&v7) > 0) {
            0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::update_balance_deposit<T1>(arg1, arg2, arg3, arg0.surplus_wallet, v7, arg5, arg7);
        } else {
            0x2::coin::destroy_zero<T1>(v7);
        };
    }

    fun process_position_updates<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &vector<PositionParam>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PositionParam>(arg1)) {
            let v1 = *0x1::vector::borrow<PositionParam>(arg1, v0);
            let v2 = ClientPositionKey{
                contract_id : v1.contract_id,
                client      : v1.client,
            };
            if (0x2::table::contains<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&arg0.client_positions, v2)) {
                let v3 = 0x2::table::borrow_mut<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&mut arg0.client_positions, v2);
                *v3 = 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::add(*v3, v1.size);
            } else {
                0x2::table::add<ClientPositionKey, 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::signed_integer::I64>(&mut arg0.client_positions, v2, v1.size);
            };
            v0 = v0 + 1;
        };
    }

    public fun strike_currency<T0, T1>(arg0: &Ledger<T0, T1>) : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T1>()
    }

    public fun surplus_wallet<T0, T1>(arg0: &Ledger<T0, T1>) : address {
        @0x0
    }

    public fun underlying_currency<T0, T1>(arg0: &Ledger<T0, T1>) : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    public fun update_fund_movements<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::UtilityAccountCap, arg2: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::CapabilityRegistry, arg3: &mut 0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::fundlock::FundLock, arg4: vector<FundMovementParam>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::assert_utility_account_active(arg1, arg2);
        assert!(0x1::vector::length<FundMovementParam>(&arg4) > 0, 300);
        process_fund_movements<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = FundMovementsUpdated{
            backend_id : arg5,
            ledger_id  : 0x2::object::id<Ledger<T0, T1>>(arg0),
        };
        0x2::event::emit<FundMovementsUpdated>(v0);
    }

    public fun update_positions<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::UtilityAccountCap, arg2: &0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::CapabilityRegistry, arg3: vector<PositionParam>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35f7a75542a9100ce9c50f47ed52be4a653122ddb4f4743bdd9afa9843538::access_control::assert_utility_account_active(arg1, arg2);
        assert!(0x1::vector::length<PositionParam>(&arg3) > 0, 300);
        process_position_updates<T0, T1>(arg0, &arg3, arg5);
        let v0 = PositionsUpdated{
            backend_id : arg4,
            ledger_id  : 0x2::object::id<Ledger<T0, T1>>(arg0),
        };
        0x2::event::emit<PositionsUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

