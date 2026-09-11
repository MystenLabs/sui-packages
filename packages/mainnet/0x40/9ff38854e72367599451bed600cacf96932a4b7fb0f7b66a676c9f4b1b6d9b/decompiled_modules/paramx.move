module 0x409ff38854e72367599451bed600cacf96932a4b7fb0f7b66a676c9f4b1b6d9b::paramx {
    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, Account<T0>>,
        contracts: 0x2::table::Table<u256, GridContract<T0>>,
        transfer_data: TransferData,
        oracle_data: OracleData,
        fees: 0x2::balance::Balance<T0>,
        taker_fee_bps: u64,
        emergency_withdraw_address: address,
    }

    struct GridContract<phantom T0> has store {
        reward: 0x2::balance::Balance<T0>,
        yes_positions: 0x2::table::Table<address, u64>,
        no_positions: 0x2::table::Table<address, u64>,
    }

    struct Account<phantom T0> has store {
        trading_pubkey: vector<u8>,
        nonce_data: 0x2::table::Table<u64, NonceData>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct NonceData has store {
        expiry: u64,
        filled_amount: 0x1::option::Option<u64>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct TransferData has store {
        new_owner: 0x1::option::Option<address>,
        request_time: 0x1::option::Option<u64>,
        hold_time: 0x1::option::Option<u64>,
    }

    struct OracleData has store {
        pubkey: 0x1::option::Option<vector<u8>>,
        new_pubkey: 0x1::option::Option<vector<u8>>,
        request_time: 0x1::option::Option<u64>,
        hold_time: 0x1::option::Option<u64>,
    }

    struct TradingKeyTransfer has key {
        id: 0x2::object::UID,
        user: address,
        trading_pubkey: vector<u8>,
        expiry: u64,
        nonce: u64,
    }

    struct DepositTransfer<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        bal: 0x2::balance::Balance<T0>,
    }

    struct MintContractIntent has drop {
        exchange_object_id: 0x2::object::ID,
        user: address,
        underlying_id: u32,
        start_active_ts: u32,
        end_active_ts: u32,
        max_strike: u64,
        min_strike: u64,
        amount: u64,
        expiry: u64,
        nonce: u64,
    }

    struct BuyerOrderIntent has drop {
        user: address,
        total_price: u64,
        total_amount: 0x1::option::Option<u64>,
        contract_side_yes: bool,
        contract_id: u256,
        exchange_object_id: 0x2::object::ID,
        expiry: u64,
        nonce: u64,
    }

    struct SellerOrderIntent has drop {
        user: address,
        seller_contract_side_yes: bool,
        contract_id: u256,
        total_amount: u64,
        total_price: 0x1::option::Option<u64>,
        exchange_object_id: 0x2::object::ID,
        expiry: u64,
        nonce: u64,
    }

    struct CancelOrderIntent has drop {
        user: address,
        order_max_amount: u64,
        order_nonce: u64,
        exchange_object_id: 0x2::object::ID,
        expiry: u64,
    }

    struct GridContractYesProof has drop {
        exchange_object_id: 0x2::object::ID,
        underlying_id: u32,
        price: u64,
        timestamp: u32,
    }

    struct GridContractNoProof has drop {
        exchange_object_id: 0x2::object::ID,
        underlying_id: u32,
        min_strike: u64,
        max_strike: u64,
        start_ts: u32,
        end_ts: u32,
    }

    public fun accept_deposit_transfer<T0>(arg0: &mut Exchange<T0>, arg1: DepositTransfer<T0>) {
        let DepositTransfer {
            id   : v0,
            user : v1,
            bal  : v2,
        } = arg1;
        0x2::balance::join<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v1).balance, v2);
        0x2::object::delete(v0);
    }

    public fun accept_trading_key_transfer<T0>(arg0: &mut Exchange<T0>, arg1: TradingKeyTransfer, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let TradingKeyTransfer {
            id             : v0,
            user           : v1,
            trading_pubkey : v2,
            expiry         : v3,
            nonce          : v4,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg2) < v3, 7);
        if (0x2::table::contains<address, Account<T0>>(&arg0.accounts, v1)) {
            let v5 = 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v1);
            assert!(!0x2::table::contains<u64, NonceData>(&v5.nonce_data, v4), 8);
            v5.trading_pubkey = v2;
            let v6 = NonceData{
                expiry        : v3,
                filled_amount : 0x1::option::none<u64>(),
            };
            0x2::table::add<u64, NonceData>(&mut v5.nonce_data, v4, v6);
        } else {
            let v7 = 0x2::table::new<u64, NonceData>(arg3);
            let v8 = NonceData{
                expiry        : v3,
                filled_amount : 0x1::option::none<u64>(),
            };
            0x2::table::add<u64, NonceData>(&mut v7, v4, v8);
            let v9 = Account<T0>{
                trading_pubkey : v2,
                nonce_data     : v7,
                balance        : 0x2::balance::zero<T0>(),
            };
            0x2::table::add<address, Account<T0>>(&mut arg0.accounts, v1, v9);
        };
        0x2::object::delete(v0);
    }

    public fun cancel_oracle_rotation<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<u64>(&arg1.oracle_data.request_time), 7);
        arg1.oracle_data.new_pubkey = 0x1::option::none<vector<u8>>();
        arg1.oracle_data.request_time = 0x1::option::none<u64>();
        arg1.oracle_data.hold_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2) + 604800000);
    }

    public fun cancel_order_intent<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: &vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = CancelOrderIntent{
            user               : arg1,
            order_max_amount   : arg2,
            order_nonce        : arg3,
            exchange_object_id : arg4,
            expiry             : arg5,
        };
        let v1 = 0x2::bcs::to_bytes<CancelOrderIntent>(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg6, &0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).trading_pubkey, &v1), 14);
        assert!(v0.expiry > 0x2::clock::timestamp_ms(arg7), 13);
        if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.order_nonce)) {
            0x2::table::borrow_mut<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).nonce_data, v0.order_nonce).filled_amount = 0x1::option::some<u64>(v0.order_max_amount);
            0x2::table::borrow_mut<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).nonce_data, v0.order_nonce).expiry = v0.expiry;
        } else {
            let v2 = NonceData{
                expiry        : v0.expiry,
                filled_amount : 0x1::option::some<u64>(v0.order_max_amount),
            };
            0x2::table::add<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).nonce_data, v0.order_nonce, v2);
        };
    }

    public fun cancel_transfer_ownership<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<u64>(&arg1.transfer_data.request_time), 3);
        arg1.transfer_data.new_owner = 0x1::option::none<address>();
        arg1.transfer_data.request_time = 0x1::option::none<u64>();
        arg1.transfer_data.hold_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2) + 604800000);
    }

    public fun emergency_liquidate_contract<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u256) {
        0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut 0x2::table::borrow_mut<u256, GridContract<T0>>(&mut arg1.contracts, arg2).reward), arg1.emergency_withdraw_address);
    }

    public fun execute_trade<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: bool, arg5: u256, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &vector<u8>, arg10: address, arg11: bool, arg12: u256, arg13: 0x1::option::Option<u64>, arg14: u64, arg15: 0x2::object::ID, arg16: u64, arg17: u64, arg18: &vector<u8>, arg19: bool, arg20: &0x2::clock::Clock) {
        let v0 = BuyerOrderIntent{
            user               : arg1,
            total_price        : arg2,
            total_amount       : arg3,
            contract_side_yes  : arg4,
            contract_id        : arg5,
            exchange_object_id : arg6,
            expiry             : arg7,
            nonce              : arg8,
        };
        let v1 = SellerOrderIntent{
            user                     : arg10,
            seller_contract_side_yes : arg11,
            contract_id              : arg12,
            total_amount             : arg14,
            total_price              : arg13,
            exchange_object_id       : arg15,
            expiry                   : arg16,
            nonce                    : arg17,
        };
        let v2 = 0x2::bcs::to_bytes<BuyerOrderIntent>(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg9, &0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).trading_pubkey, &v2), 1);
        let v3 = 0x2::bcs::to_bytes<SellerOrderIntent>(&v1);
        assert!(0x2::ed25519::ed25519_verify(arg18, &0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v1.user).trading_pubkey, &v3), 12);
        let v4 = v0.exchange_object_id;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v4, 3);
        let v5 = v1.exchange_object_id;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v5, 4);
        assert!(0x2::clock::timestamp_ms(arg20) < v0.expiry, 15);
        assert!(0x2::clock::timestamp_ms(arg20) < v1.expiry, 15);
        assert!(0x1::option::is_some<u64>(&v0.total_amount) && 0x1::option::is_some<u64>(&v1.total_price) || 0x1::option::is_none<u64>(&v0.total_amount) != 0x1::option::is_none<u64>(&v1.total_price) && (arg19 && 0x1::option::is_some<u64>(&v0.total_amount) || !arg19 && 0x1::option::is_some<u64>(&v1.total_price)), 9);
        let v6 = (0x1::option::get_with_default<u64>(&v0.total_amount, 0) as u128);
        let v7 = (v0.total_price as u128);
        let v8 = (0x1::option::get_with_default<u64>(&v1.total_price, 0) as u128);
        let v9 = (v1.total_amount as u128);
        let v10 = if (0x1::option::is_some<u64>(&v0.total_amount)) {
            if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.nonce)) {
                0x1::option::get_with_default<u64>(&v0.total_amount, 0) - 0x1::option::get_with_default<u64>(&0x2::table::borrow<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.nonce).filled_amount, 0)
            } else {
                0x1::option::get_with_default<u64>(&v0.total_amount, 0)
            }
        } else {
            let v11 = if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.nonce)) {
                v0.total_price - 0x1::option::get_with_default<u64>(&0x2::table::borrow<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.nonce).filled_amount, 0)
            } else {
                v0.total_price
            };
            (((v11 as u128) * v9 / v8) as u64)
        };
        assert!(v10 > 0, 13);
        let v12 = if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v1.user).nonce_data, v1.nonce)) {
            v1.total_amount - 0x1::option::get_with_default<u64>(&0x2::table::borrow<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v1.user).nonce_data, v1.nonce).filled_amount, 0)
        } else {
            v1.total_amount
        };
        assert!(v12 > 0, 14);
        let v13 = 0x1::u64::min(v10, v12);
        assert!(v1.contract_id == v0.contract_id, 19);
        assert!(v1.seller_contract_side_yes == v0.contract_side_yes, 20);
        assert!(v1.user != v0.user, 25);
        if (0x1::option::is_some<u64>(&v0.total_amount)) {
            assert!(v7 * v9 >= v8 * v6, 16);
        };
        let v14 = if (arg19) {
            v7 * (v13 as u128) / v6
        } else {
            (v8 * (v13 as u128) + v9 - 1) / v9
        };
        let v15 = (v14 as u64);
        let v16 = 0x2::table::borrow_mut<u256, GridContract<T0>>(&mut arg0.contracts, v1.contract_id);
        if (v1.seller_contract_side_yes) {
            assert!(*0x2::table::borrow<address, u64>(&v16.yes_positions, v1.user) >= v13, 17);
        } else {
            assert!(*0x2::table::borrow<address, u64>(&v16.no_positions, v1.user) >= v13, 17);
        };
        assert!(0x2::balance::value<T0>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).balance) >= v15, 18);
        let v17 = 0x2::balance::split<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).balance, v15);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v17, v15 * arg0.taker_fee_bps / 10000));
        0x2::balance::join<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v1.user).balance, v17);
        if (v1.seller_contract_side_yes) {
            0x2::table::add<address, u64>(&mut v16.yes_positions, v1.user, 0x2::table::remove<address, u64>(&mut v16.yes_positions, v1.user) - v13);
            if (!0x2::table::contains<address, u64>(&v16.yes_positions, v0.user)) {
                0x2::table::add<address, u64>(&mut v16.yes_positions, v0.user, v13);
            } else {
                0x2::table::add<address, u64>(&mut v16.yes_positions, v0.user, 0x2::table::remove<address, u64>(&mut v16.yes_positions, v0.user) + v13);
            };
        } else {
            0x2::table::add<address, u64>(&mut v16.no_positions, v1.user, 0x2::table::remove<address, u64>(&mut v16.no_positions, v1.user) - v13);
            if (!0x2::table::contains<address, u64>(&v16.no_positions, v0.user)) {
                0x2::table::add<address, u64>(&mut v16.no_positions, v0.user, v13);
            } else {
                0x2::table::add<address, u64>(&mut v16.no_positions, v0.user, 0x2::table::remove<address, u64>(&mut v16.no_positions, v0.user) + v13);
            };
        };
        let v18 = if (0x1::option::is_some<u64>(&v0.total_amount)) {
            v13
        } else {
            v15
        };
        if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v0.user).nonce_data, v0.nonce)) {
            let v19 = 0x2::table::borrow_mut<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).nonce_data, v0.nonce);
            let v20 = 0x1::option::get_with_default<u64>(&v19.filled_amount, 0) + v18;
            let v21 = if (0x1::option::is_some<u64>(&v0.total_amount)) {
                0x1::option::get_with_default<u64>(&v0.total_amount, 0)
            } else {
                v0.total_price
            };
            assert!(v20 <= v21, 25);
            v19.filled_amount = 0x1::option::some<u64>(v20);
        } else {
            let v22 = NonceData{
                expiry        : v0.expiry,
                filled_amount : 0x1::option::some<u64>(v18),
            };
            0x2::table::add<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user).nonce_data, v0.nonce, v22);
        };
        if (0x2::table::contains<u64, NonceData>(&0x2::table::borrow<address, Account<T0>>(&arg0.accounts, v1.user).nonce_data, v1.nonce)) {
            let v23 = 0x2::table::borrow_mut<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v1.user).nonce_data, v1.nonce);
            let v24 = 0x1::option::get_with_default<u64>(&v23.filled_amount, 0) + v13;
            assert!(v24 <= v1.total_amount, 25);
            v23.filled_amount = 0x1::option::some<u64>(v24);
        } else {
            let v25 = NonceData{
                expiry        : v1.expiry,
                filled_amount : 0x1::option::some<u64>(v13),
            };
            0x2::table::add<u64, NonceData>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v1.user).nonce_data, v1.nonce, v25);
        };
    }

    public fun mint_and_trade<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &vector<u8>, arg12: address, arg13: bool, arg14: u256, arg15: 0x1::option::Option<u64>, arg16: u64, arg17: 0x2::object::ID, arg18: u64, arg19: u64, arg20: &vector<u8>, arg21: address, arg22: u64, arg23: 0x1::option::Option<u64>, arg24: bool, arg25: u256, arg26: 0x2::object::ID, arg27: u64, arg28: u64, arg29: &vector<u8>, arg30: bool, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == arg12, 30);
        mint_contract<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg31, arg32);
        execute_trade<T0>(arg0, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg30, arg31);
    }

    public fun mint_contract<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = MintContractIntent{
            exchange_object_id : arg1,
            user               : arg2,
            underlying_id      : arg3,
            start_active_ts    : arg4,
            end_active_ts      : arg5,
            max_strike         : arg6,
            min_strike         : arg7,
            amount             : arg8,
            expiry             : arg9,
            nonce              : arg10,
        };
        let v1 = 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, v0.user);
        let v2 = 0x2::bcs::to_bytes<MintContractIntent>(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg11, &v1.trading_pubkey, &v2), 14);
        assert!(0x2::clock::timestamp_ms(arg12) < v0.expiry, 15);
        assert!(!0x2::table::contains<u64, NonceData>(&v1.nonce_data, v0.nonce), 1);
        let v3 = v0.exchange_object_id;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v3, 16);
        assert!(v0.start_active_ts < v0.end_active_ts, 17);
        assert!(v0.min_strike < v0.max_strike, 18);
        assert!(v0.amount > 0, 19);
        let v4 = (v0.underlying_id as u256) << 224 | (v0.start_active_ts as u256) << 192 | (v0.end_active_ts as u256) << 160 | (v0.max_strike as u256) << 96 | (v0.min_strike as u256) << 32;
        if (!0x2::table::contains<u256, GridContract<T0>>(&arg0.contracts, v4)) {
            let v5 = GridContract<T0>{
                reward        : 0x2::balance::zero<T0>(),
                yes_positions : 0x2::table::new<address, u64>(arg13),
                no_positions  : 0x2::table::new<address, u64>(arg13),
            };
            0x2::table::add<u256, GridContract<T0>>(&mut arg0.contracts, v4, v5);
        };
        let v6 = 0x2::table::borrow_mut<u256, GridContract<T0>>(&mut arg0.contracts, v4);
        0x2::balance::join<T0>(&mut v6.reward, 0x2::balance::split<T0>(&mut v1.balance, v0.amount));
        if (0x2::table::contains<address, u64>(&v6.yes_positions, v0.user)) {
            0x2::table::add<address, u64>(&mut v6.yes_positions, v0.user, 0x2::table::remove<address, u64>(&mut v6.yes_positions, v0.user) + v0.amount);
        } else {
            0x2::table::add<address, u64>(&mut v6.yes_positions, v0.user, v0.amount);
        };
        if (0x2::table::contains<address, u64>(&v6.no_positions, v0.user)) {
            0x2::table::add<address, u64>(&mut v6.no_positions, v0.user, 0x2::table::remove<address, u64>(&mut v6.no_positions, v0.user) + v0.amount);
        } else {
            0x2::table::add<address, u64>(&mut v6.no_positions, v0.user, v0.amount);
        };
        let v7 = NonceData{
            expiry        : v0.expiry,
            filled_amount : 0x1::option::none<u64>(),
        };
        0x2::table::add<u64, NonceData>(&mut v1.nonce_data, v0.nonce, v7);
    }

    public fun new_deposit_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositTransfer<T0>{
            id   : 0x2::object::new(arg2),
            user : 0x2::tx_context::sender(arg2),
            bal  : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::transfer<DepositTransfer<T0>>(v0, arg1);
    }

    public fun new_exchange<T0>(arg0: vector<u8>, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferData{
            new_owner    : 0x1::option::none<address>(),
            request_time : 0x1::option::none<u64>(),
            hold_time    : 0x1::option::none<u64>(),
        };
        let v1 = OracleData{
            pubkey       : 0x1::option::some<vector<u8>>(arg0),
            new_pubkey   : 0x1::option::none<vector<u8>>(),
            request_time : 0x1::option::none<u64>(),
            hold_time    : 0x1::option::none<u64>(),
        };
        let v2 = Exchange<T0>{
            id                         : 0x2::object::new(arg4),
            accounts                   : 0x2::table::new<address, Account<T0>>(arg4),
            contracts                  : 0x2::table::new<u256, GridContract<T0>>(arg4),
            transfer_data              : v0,
            oracle_data                : v1,
            fees                       : 0x2::balance::zero<T0>(),
            taker_fee_bps              : 30,
            emergency_withdraw_address : arg3,
        };
        let v3 = AdminCap<T0>{id: 0x2::object::new(arg4)};
        0x2::transfer::transfer<Exchange<T0>>(v2, arg1);
        0x2::transfer::transfer<AdminCap<T0>>(v3, arg2);
    }

    public fun new_trading_key_transfer(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TradingKeyTransfer{
            id             : 0x2::object::new(arg4),
            user           : 0x2::tx_context::sender(arg4),
            trading_pubkey : arg0,
            expiry         : arg1,
            nonce          : arg2,
        };
        0x2::transfer::transfer<TradingKeyTransfer>(v0, arg3);
    }

    public fun reclaim_expired_nonce<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) > 0x2::table::borrow<u64, NonceData>(&v0.nonce_data, arg2).expiry, 12);
        let NonceData {
            expiry        : _,
            filled_amount : _,
        } = 0x2::table::remove<u64, NonceData>(&mut v0.nonce_data, arg2);
    }

    public fun reclaim_expired_trading_key_transfer<T0>(arg0: &mut Exchange<T0>, arg1: TradingKeyTransfer, arg2: &0x2::clock::Clock) {
        let TradingKeyTransfer {
            id             : v0,
            user           : _,
            trading_pubkey : _,
            expiry         : v3,
            nonce          : _,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg2) > v3, 10);
        0x2::object::delete(v0);
    }

    public fun reclaim_user_account<T0>(arg0: &mut Exchange<T0>, arg1: address) {
        let Account {
            trading_pubkey : _,
            nonce_data     : v1,
            balance        : v2,
        } = 0x2::table::remove<address, Account<T0>>(&mut arg0.accounts, arg1);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::table::destroy_empty<u64, NonceData>(v1);
    }

    public fun remove_oracle<T0>(arg0: &mut Exchange<T0>) {
        arg0.oracle_data.pubkey = 0x1::option::none<vector<u8>>();
        arg0.oracle_data.new_pubkey = 0x1::option::none<vector<u8>>();
        arg0.oracle_data.request_time = 0x1::option::none<u64>();
        arg0.oracle_data.hold_time = 0x1::option::none<u64>();
    }

    public fun request_oracle_rotation<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = &arg1.oracle_data.hold_time;
        assert!(0x1::option::is_none<u64>(v1) || v0 > *0x1::option::borrow<u64>(v1), 6);
        arg1.oracle_data.new_pubkey = 0x1::option::some<vector<u8>>(arg2);
        arg1.oracle_data.request_time = 0x1::option::some<u64>(v0);
    }

    public fun request_transfer_ownership<T0>(arg0: &AdminCap<T0>, arg1: address, arg2: &mut Exchange<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = &arg2.transfer_data.hold_time;
        assert!(0x1::option::is_none<u64>(v1) || v0 > *0x1::option::borrow<u64>(v1), 2);
        arg2.transfer_data.new_owner = 0x1::option::some<address>(arg1);
        arg2.transfer_data.request_time = 0x1::option::some<u64>(v0);
    }

    public fun rotate_oracle<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = &arg1.oracle_data.hold_time;
        assert!(0x1::option::is_none<u64>(v1) || v0 > *0x1::option::borrow<u64>(v1), 8);
        let v2 = &arg1.oracle_data.request_time;
        assert!(0x1::option::is_some<u64>(v2) && v0 > *0x1::option::borrow<u64>(v2) + 86400000, 9);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.oracle_data.new_pubkey), 10);
        arg1.oracle_data.pubkey = 0x1::option::some<vector<u8>>(0x1::option::get_with_default<vector<u8>>(&arg1.oracle_data.new_pubkey, b""));
        arg1.oracle_data.new_pubkey = 0x1::option::none<vector<u8>>();
        arg1.oracle_data.request_time = 0x1::option::none<u64>();
    }

    public fun settle_no_side<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: u32, arg3: address, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: 0x2::object::ID, arg9: &vector<u8>, arg10: &0x2::clock::Clock) {
        let v0 = GridContractNoProof{
            exchange_object_id : arg8,
            underlying_id      : arg2,
            min_strike         : arg4,
            max_strike         : arg5,
            start_ts           : arg6,
            end_ts             : arg7,
        };
        let v1 = &arg0.oracle_data.pubkey;
        let v2 = if (0x1::option::is_some<vector<u8>>(v1)) {
            let v3 = 0x2::bcs::to_bytes<GridContractNoProof>(&v0);
            0x2::ed25519::ed25519_verify(arg9, 0x1::option::borrow<vector<u8>>(v1), &v3)
        } else {
            false
        };
        assert!(v2, 11);
        let v4 = v0.exchange_object_id;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v4, 26);
        let v5 = ((arg1 >> 160 & 4294967295) as u32);
        assert!(((arg1 >> 224) as u32) == v0.underlying_id, 23);
        assert!(v0.min_strike == ((arg1 >> 32 & 18446744073709551615) as u64) && v0.max_strike == ((arg1 >> 96 & 18446744073709551615) as u64), 24);
        assert!(v0.start_ts == ((arg1 >> 192 & 4294967295) as u32) && v0.end_ts == v5, 25);
        assert!(0x2::clock::timestamp_ms(arg10) > (v5 as u64) * 1000, 27);
        let v6 = 0x2::table::borrow_mut<u256, GridContract<T0>>(&mut arg0.contracts, arg1);
        if (0x2::table::contains<address, u64>(&v6.no_positions, arg3)) {
            if (0x2::table::contains<address, Account<T0>>(&arg0.accounts, arg3)) {
                0x2::balance::join<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg3).balance, 0x2::balance::split<T0>(&mut v6.reward, 0x2::table::remove<address, u64>(&mut v6.no_positions, arg3)));
            } else {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v6.reward, 0x2::table::remove<address, u64>(&mut v6.no_positions, arg3)), arg3);
            };
        };
        if (0x2::balance::value<T0>(&v6.reward) == 0) {
            let GridContract {
                reward        : v7,
                yes_positions : v8,
                no_positions  : v9,
            } = 0x2::table::remove<u256, GridContract<T0>>(&mut arg0.contracts, arg1);
            0x2::balance::destroy_zero<T0>(v7);
            0x2::table::drop<address, u64>(v8);
            0x2::table::drop<address, u64>(v9);
        };
    }

    public fun settle_yes_side<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: address, arg3: u32, arg4: u64, arg5: u32, arg6: 0x2::object::ID, arg7: &vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = GridContractYesProof{
            exchange_object_id : arg6,
            underlying_id      : arg3,
            price              : arg4,
            timestamp          : arg5,
        };
        let v1 = &arg0.oracle_data.pubkey;
        let v2 = if (0x1::option::is_some<vector<u8>>(v1)) {
            let v3 = 0x2::bcs::to_bytes<GridContractYesProof>(&v0);
            0x2::ed25519::ed25519_verify(arg7, 0x1::option::borrow<vector<u8>>(v1), &v3)
        } else {
            false
        };
        assert!(v2, 11);
        let v4 = v0.exchange_object_id;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v4, 12);
        let v5 = ((arg1 >> 192 & 4294967295) as u32);
        assert!(((arg1 >> 224) as u32) == v0.underlying_id, 23);
        assert!(v0.price >= ((arg1 >> 32 & 18446744073709551615) as u64) && v0.price <= ((arg1 >> 96 & 18446744073709551615) as u64), 24);
        assert!(v0.timestamp >= v5 && v0.timestamp <= ((arg1 >> 160 & 4294967295) as u32), 25);
        assert!(0x2::clock::timestamp_ms(arg8) > (v5 as u64) * 1000, 27);
        let v6 = 0x2::table::borrow_mut<u256, GridContract<T0>>(&mut arg0.contracts, arg1);
        if (0x2::table::contains<address, u64>(&v6.yes_positions, arg2)) {
            if (0x2::table::contains<address, Account<T0>>(&arg0.accounts, arg2)) {
                0x2::balance::join<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg2).balance, 0x2::balance::split<T0>(&mut v6.reward, 0x2::table::remove<address, u64>(&mut v6.yes_positions, arg2)));
            } else {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v6.reward, 0x2::table::remove<address, u64>(&mut v6.yes_positions, arg2)), arg2);
            };
        };
        if (0x2::balance::value<T0>(&v6.reward) == 0) {
            let GridContract {
                reward        : v7,
                yes_positions : v8,
                no_positions  : v9,
            } = 0x2::table::remove<u256, GridContract<T0>>(&mut arg0.contracts, arg1);
            0x2::balance::destroy_zero<T0>(v7);
            0x2::table::drop<address, u64>(v8);
            0x2::table::drop<address, u64>(v9);
        };
    }

    public fun transfer_ownership<T0>(arg0: &AdminCap<T0>, arg1: Exchange<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = &arg1.transfer_data.hold_time;
        assert!(0x1::option::is_none<u64>(v1) || v0 > *0x1::option::borrow<u64>(v1), 7);
        let v2 = &arg1.transfer_data.request_time;
        assert!(0x1::option::is_some<u64>(v2) && v0 > *0x1::option::borrow<u64>(v2) + 86400000, 4);
        let v3 = &arg1.transfer_data.new_owner;
        assert!(0x1::option::is_some<address>(v3) && *0x1::option::borrow<address>(v3) == arg2, 5);
        0x2::transfer::transfer<Exchange<T0>>(arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, Account<T0>>(&arg0.accounts, arg1), 11);
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut 0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg1).balance, arg2), arg1);
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u64, arg3: address) {
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg1.fees, arg2), arg3);
    }

    // decompiled from Move bytecode v7
}

