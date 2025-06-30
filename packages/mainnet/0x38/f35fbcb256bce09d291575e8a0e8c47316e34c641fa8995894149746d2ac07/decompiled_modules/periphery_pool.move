module 0x38f35fbcb256bce09d291575e8a0e8c47316e34c641fa8995894149746d2ac07::periphery_pool {
    struct PeripheryPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        chain_id: u64,
        src_vm_type: u8,
        kernel_pool: 0x1::string::String,
        kernel_factory: 0x1::string::String,
        manager: address,
        gateways: vector<address>,
        fee: u32,
        description: 0x1::string::String,
        staged_token0_amount_raw: u64,
        staged_token1_amount_raw: u64,
        user_datas: 0x2::table::Table<address, UserData>,
        pool_coin0_liquidity: 0x2::coin::Coin<T0>,
        pool_coin1_liquidity: 0x2::coin::Coin<T1>,
        action_box_config_id: 0x2::object::ID,
    }

    struct UserData has copy, drop, store {
        user: address,
        amount0_staged_raw: u64,
        amount1_staged_raw: u64,
        amount0_min: u64,
        amount1_min: u64,
        withdraw_after_ms: u64,
        action_id: vector<u8>,
    }

    struct PoolManagerCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolInitializedEvent has copy, drop {
        periphery_pool_id: 0x2::object::ID,
        manager: address,
        chain_id: u64,
        src_vm_type: u8,
        kernel_pool: 0x1::string::String,
        kernel_factory: 0x1::string::String,
        fee: u32,
        description: 0x1::string::String,
        gateways: vector<address>,
        pool_coin0_liquidity_value: u64,
        pool_coin1_liquidity_value: u64,
    }

    struct MintRequestedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        tick_lower: 0x1::string::String,
        tick_upper: 0x1::string::String,
        amount0_deposited_raw: u64,
        amount1_deposited_raw: u64,
        amount0_min: u64,
        amount1_min: u64,
        withdraw_after_ms: u64,
        action_id: vector<u8>,
    }

    struct MintSettledEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        settled_amount0_raw: u64,
        settled_amount0_transferred_raw: u64,
        settled_amount1_raw: u64,
        settled_amount1_transferred_raw: u64,
        task_id: vector<u8>,
    }

    struct StagedAssetsRemovedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        returned_amount0_raw: u64,
        returned_amount1_raw: u64,
        previous_withdraw_after_ms: u64,
    }

    struct BurnRequestedEvent has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        tick_lower: 0x1::string::String,
        tick_upper: 0x1::string::String,
        liquidity_amount: u128,
        amount0min: u64,
        amount1min: u64,
        token_id: 0x1::string::String,
        action_id: vector<u8>,
    }

    struct BurnSettledEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        amount0_transferred_raw: u64,
        amount1_transferred_raw: u64,
        task_id: vector<u8>,
    }

    struct SwapRequestedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        recipient_str: 0x1::string::String,
        zero_for_one: bool,
        amount_specified: u64,
        amount_is_positive: bool,
        sqrt_price_limit_x96_str: 0x1::string::String,
        dest_chain_id: u64,
        dest_vm_type: u8,
        action_id: vector<u8>,
    }

    struct SwapSettledEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        amount0_transferred_raw: u64,
        amount1_transferred_raw: u64,
        amount0_settled_raw: u64,
        amount1_settled_raw: u64,
        task_id: vector<u8>,
    }

    struct TokensTransferredToEvent<phantom T0, phantom T1> has copy, drop {
        periphery_pool_id: 0x2::object::ID,
        caller: address,
        recipient_address: address,
        amount0_transferred_raw: u64,
        amount1_transferred_raw: u64,
    }

    struct PoolConfigUpdatedEvent has copy, drop {
        periphery_pool_id: 0x2::object::ID,
        manager: address,
        chain_id: u64,
        src_vm_type: u8,
        description: 0x1::string::String,
        gateways: vector<address>,
        kernel_factory: 0x1::string::String,
        kernel_pool: 0x1::string::String,
    }

    struct IncreaseLiquidityEvent has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        token_id: 0x1::string::String,
        amount0: u64,
        amount1: u64,
        amount0_min: u64,
        amount1_min: u64,
        action_id: vector<u8>,
    }

    struct DecreaseLiquidityEvent has copy, drop {
        user: address,
        periphery_pool_id: 0x2::object::ID,
        token_id: 0x1::string::String,
        liquidity_amount: u128,
        amount0min: u64,
        amount1min: u64,
        action_id: vector<u8>,
    }

    struct KernelActionMintPayload has drop {
        action_id: vector<u8>,
        chain_id: u64,
        vm_type: u8,
        user_id_str: 0x1::string::String,
        kernel_pool_id_str: 0x1::string::String,
        tick_lower: 0x1::string::String,
        tick_upper: 0x1::string::String,
        amount0: u64,
        amount1: u64,
        amount0_min: u64,
        amount1_min: u64,
    }

    struct KernelActionBurnPayload has drop {
        action_id: vector<u8>,
        chain_id: u64,
        vm_type: u8,
        user_id_str: 0x1::string::String,
        kernel_pool_id_str: 0x1::string::String,
        tick_lower: 0x1::string::String,
        tick_upper: 0x1::string::String,
        liquidity_amount: u128,
        amount0min: u64,
        amount1min: u64,
        token_id: 0x1::string::String,
    }

    struct KernelActionSwapPayload has drop {
        action_id: vector<u8>,
        chain_id: u64,
        src_vm_type: u8,
        dest_chain_id: u64,
        dest_vm_type: u8,
        recipient_str: 0x1::string::String,
        user_id_str: 0x1::string::String,
        kernel_pool_id_str: 0x1::string::String,
        zero_for_one: bool,
        amount_specified: u64,
        amount_is_positive: bool,
        sqrt_price_limit_x96_str: 0x1::string::String,
        extra_data: vector<u8>,
    }

    struct KernelActionIncreaseLiquidityPayload has drop {
        action_id: vector<u8>,
        chain_id: u64,
        vm_type: u8,
        user_id_str: 0x1::string::String,
        kernel_pool_id_str: 0x1::string::String,
        token_id: 0x1::string::String,
        amount0: u64,
        amount1: u64,
        amount0_min: u64,
        amount1_min: u64,
    }

    struct KernelActionDecreaseLiquidityPayload has drop {
        action_id: vector<u8>,
        chain_id: u64,
        vm_type: u8,
        user_id_str: 0x1::string::String,
        kernel_pool_id_str: 0x1::string::String,
        token_id: 0x1::string::String,
        liquidity_amount: u128,
        amount0min: u64,
        amount1min: u64,
    }

    public entry fun swap<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::string::String, arg4: bool, arg5: u64, arg6: bool, arg7: 0x1::string::String, arg8: u64, arg9: u8, arg10: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg11: vector<u8>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        assert!(arg8 == arg0.chain_id, 6);
        if (!0x2::table::contains<address, UserData>(&arg0.user_datas, v0)) {
            let v3 = UserData{
                user               : v0,
                amount0_staged_raw : 0,
                amount1_staged_raw : 0,
                amount0_min        : 0,
                amount1_min        : 0,
                withdraw_after_ms  : 0,
                action_id          : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<address, UserData>(&mut arg0.user_datas, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, v0);
        let v5 = if (arg6) {
            arg5
        } else if (arg4) {
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::coin::value<T1>(&arg2)
        };
        if (arg4) {
            assert!(v5 > 0, 2);
            arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw + v5;
            v4.amount0_staged_raw = v4.amount0_staged_raw + v5;
        } else {
            assert!(v5 > 0, 2);
            arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw + v5;
            v4.amount1_staged_raw = v4.amount1_staged_raw + v5;
        };
        v4.withdraw_after_ms = 0x2::clock::timestamp_ms(arg13) + 600000;
        let v6 = addr_to_string(v0);
        let v7 = generate_action_id_v2(v0, arg13, arg0.chain_id, arg12, 0x2::tx_context::sender(arg14));
        while (v2 < 0x1::vector::length<u8>(&arg11)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg11, v2));
            v2 = v2 + 1;
        };
        let v8 = KernelActionSwapPayload{
            action_id                : v7,
            chain_id                 : arg0.chain_id,
            src_vm_type              : arg0.src_vm_type,
            dest_chain_id            : arg8,
            dest_vm_type             : arg9,
            recipient_str            : arg3,
            user_id_str              : v6,
            kernel_pool_id_str       : arg0.kernel_pool,
            zero_for_one             : arg4,
            amount_specified         : arg5,
            amount_is_positive       : arg6,
            sqrt_price_limit_x96_str : arg7,
            extra_data               : v1,
        };
        let (v9, v10) = if (arg4) {
            (0x1::string::utf8(b"Token0"), 0x1::string::utf8(b"Token1"))
        } else {
            (0x1::string::utf8(b"Token1"), 0x1::string::utf8(b"Token0"))
        };
        let v11 = if (arg4) {
            let v12 = 0x1::vector::empty<u64>();
            let v13 = &mut v12;
            0x1::vector::push_back<u64>(v13, v5);
            0x1::vector::push_back<u64>(v13, 0);
            v12
        } else {
            let v14 = 0x1::vector::empty<u64>();
            let v15 = &mut v14;
            0x1::vector::push_back<u64>(v15, 0);
            0x1::vector::push_back<u64>(v15, v5);
            v14
        };
        let v16 = 0x1::vector::empty<0x1::string::String>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x1::string::String>(v17, v9);
        0x1::vector::push_back<0x1::string::String>(v17, v10);
        call_action_box_create_action_v2<T0, T1>(arg0, arg10, v6, arg0.kernel_factory, 0x2::bcs::to_bytes<KernelActionSwapPayload>(&v8), v11, v16, arg12, arg13, arg14);
        if (arg4) {
            0x2::coin::join<T0>(&mut arg0.pool_coin0_liquidity, arg1);
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::coin::join<T1>(&mut arg0.pool_coin1_liquidity, arg2);
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v18 = SwapRequestedEvent<T0, T1>{
            user                     : v0,
            periphery_pool_id        : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            recipient_str            : arg3,
            zero_for_one             : arg4,
            amount_specified         : arg5,
            amount_is_positive       : arg6,
            sqrt_price_limit_x96_str : arg7,
            dest_chain_id            : arg8,
            dest_vm_type             : arg9,
            action_id                : v7,
        };
        0x2::event::emit<SwapRequestedEvent<T0, T1>>(v18);
    }

    public entry fun add_gateway<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: &PoolManagerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<PeripheryPool<T0, T1>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        0x1::vector::push_back<address>(&mut arg0.gateways, arg2);
        let v0 = PoolConfigUpdatedEvent{
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            manager           : arg0.manager,
            chain_id          : arg0.chain_id,
            src_vm_type       : arg0.src_vm_type,
            description       : arg0.description,
            gateways          : arg0.gateways,
            kernel_factory    : arg0.kernel_factory,
            kernel_pool       : arg0.kernel_pool,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    fun addr_to_string(arg0: address) : 0x1::string::String {
        0x2::address::to_string(arg0)
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public entry fun burn<T0, T1>(arg0: &PeripheryPool<T0, T1>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = addr_to_string(v0);
        let v2 = generate_action_id_v2(v0, arg9, arg0.chain_id, arg8, 0x2::tx_context::sender(arg10));
        let v3 = KernelActionBurnPayload{
            action_id          : v2,
            chain_id           : arg0.chain_id,
            vm_type            : arg0.src_vm_type,
            user_id_str        : v1,
            kernel_pool_id_str : arg0.kernel_pool,
            tick_lower         : arg1,
            tick_upper         : arg2,
            liquidity_amount   : arg3,
            amount0min         : arg4,
            amount1min         : arg5,
            token_id           : arg6,
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Token0"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Token1"));
        call_action_box_create_action_v2<T0, T1>(arg0, arg7, v1, arg0.kernel_factory, 0x2::bcs::to_bytes<KernelActionBurnPayload>(&v3), vector[0, 0], v4, arg8, arg9, arg10);
        let v6 = BurnRequestedEvent{
            user              : v0,
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            tick_lower        : arg1,
            tick_upper        : arg2,
            liquidity_amount  : arg3,
            amount0min        : arg4,
            amount1min        : arg5,
            token_id          : arg6,
            action_id         : v2,
        };
        0x2::event::emit<BurnRequestedEvent>(v6);
    }

    fun call_action_box_create_action_v2<T0, T1>(arg0: &PeripheryPool<T0, T1>, arg1: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<0x1::string::String>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::as_bytes(&arg2);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = 0x1::string::as_bytes(&arg3);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            v2 = v2 + 1;
        };
        while (v5 < 0x1::vector::length<u8>(v3)) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(v3, v5));
            v5 = v5 + 1;
        };
        while (v7 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            let v8 = 0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(&arg6, v7));
            let v9 = 0x1::vector::empty<u8>();
            let v10 = 0;
            while (v10 < 0x1::vector::length<u8>(v8)) {
                0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(v8, v10));
                v10 = v10 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v6, v9);
            v7 = v7 + 1;
        };
        0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::create_action_v2<PeripheryPool<T0, T1>>(arg1, v1, v4, arg4, arg5, v6, arg7, arg0, arg8, arg9);
    }

    public entry fun change_manager<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: PoolManagerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<PeripheryPool<T0, T1>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        arg0.manager = arg2;
        0x2::transfer::public_transfer<PoolManagerCap>(arg1, arg2);
        let v0 = PoolConfigUpdatedEvent{
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            manager           : arg0.manager,
            chain_id          : arg0.chain_id,
            src_vm_type       : arg0.src_vm_type,
            description       : arg0.description,
            gateways          : arg0.gateways,
            kernel_factory    : arg0.kernel_factory,
            kernel_pool       : arg0.kernel_pool,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    public entry fun decrease_liquidity<T0, T1>(arg0: &PeripheryPool<T0, T1>, arg1: 0x1::string::String, arg2: u128, arg3: u64, arg4: u64, arg5: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg3 <= 0x2::coin::value<T0>(&arg0.pool_coin0_liquidity) && arg4 <= 0x2::coin::value<T1>(&arg0.pool_coin1_liquidity), 5);
        let v1 = addr_to_string(v0);
        let v2 = generate_action_id_v2(v0, arg7, arg0.chain_id, arg6, 0x2::tx_context::sender(arg8));
        let v3 = KernelActionDecreaseLiquidityPayload{
            action_id          : v2,
            chain_id           : arg0.chain_id,
            vm_type            : arg0.src_vm_type,
            user_id_str        : v1,
            kernel_pool_id_str : arg0.kernel_pool,
            token_id           : arg1,
            liquidity_amount   : arg2,
            amount0min         : arg3,
            amount1min         : arg4,
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Token0"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Token1"));
        call_action_box_create_action_v2<T0, T1>(arg0, arg5, v1, arg0.kernel_factory, 0x2::bcs::to_bytes<KernelActionDecreaseLiquidityPayload>(&v3), vector[0, 0], v4, arg6, arg7, arg8);
        let v6 = DecreaseLiquidityEvent{
            user              : v0,
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            token_id          : arg1,
            liquidity_amount  : arg2,
            amount0min        : arg3,
            amount1min        : arg4,
            action_id         : v2,
        };
        0x2::event::emit<DecreaseLiquidityEvent>(v6);
    }

    public entry fun gateway_direct_transfer_to_user<T0, T1>(arg0: &PeripheryPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        if (arg4 > 0) {
            assert!(0x2::coin::value<T0>(arg1) >= arg4, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg4, arg6), arg3);
        };
        if (arg5 > 0) {
            assert!(0x2::coin::value<T1>(arg2) >= arg5, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg2, arg5, arg6), arg3);
        };
    }

    fun generate_action_id_v2(arg0: address, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg0));
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg4));
        0x2::hash::keccak256(&v0)
    }

    public entry fun increase_liquidity<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 || v2 > 0, 2);
        arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw + v1;
        arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw + v2;
        if (!0x2::table::contains<address, UserData>(&arg0.user_datas, v0)) {
            let v3 = UserData{
                user               : v0,
                amount0_staged_raw : 0,
                amount1_staged_raw : 0,
                amount0_min        : arg4,
                amount1_min        : arg5,
                withdraw_after_ms  : 0,
                action_id          : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<address, UserData>(&mut arg0.user_datas, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, v0);
        v4.amount0_staged_raw = v4.amount0_staged_raw + v1;
        v4.amount1_staged_raw = v4.amount1_staged_raw + v2;
        v4.withdraw_after_ms = 0x2::clock::timestamp_ms(arg8) + 600000;
        let v5 = addr_to_string(v0);
        let v6 = generate_action_id_v2(v0, arg8, arg0.chain_id, arg7, 0x2::tx_context::sender(arg9));
        let v7 = KernelActionIncreaseLiquidityPayload{
            action_id          : v6,
            chain_id           : arg0.chain_id,
            vm_type            : arg0.src_vm_type,
            user_id_str        : v5,
            kernel_pool_id_str : arg0.kernel_pool,
            token_id           : arg3,
            amount0            : v1,
            amount1            : v2,
            amount0_min        : arg4,
            amount1_min        : arg5,
        };
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v1);
        0x1::vector::push_back<u64>(v9, v2);
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Token0"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Token1"));
        call_action_box_create_action_v2<T0, T1>(arg0, arg6, v5, arg0.kernel_factory, 0x2::bcs::to_bytes<KernelActionIncreaseLiquidityPayload>(&v7), v8, v10, arg7, arg8, arg9);
        if (v1 > 0) {
            0x2::coin::join<T0>(&mut arg0.pool_coin0_liquidity, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (v2 > 0) {
            0x2::coin::join<T1>(&mut arg0.pool_coin1_liquidity, arg2);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v12 = IncreaseLiquidityEvent{
            user              : v0,
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            token_id          : arg3,
            amount0           : v1,
            amount1           : v2,
            amount0_min       : arg4,
            amount1_min       : arg5,
            action_id         : v6,
        };
        0x2::event::emit<IncreaseLiquidityEvent>(v12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_pool<T0, T1>(arg0: u64, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: 0x1::string::String, arg6: vector<address>, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = PeripheryPool<T0, T1>{
            id                       : v1,
            chain_id                 : arg0,
            src_vm_type              : arg1,
            kernel_pool              : arg2,
            kernel_factory           : arg3,
            manager                  : v0,
            gateways                 : arg6,
            fee                      : arg4,
            description              : arg5,
            staged_token0_amount_raw : 0,
            staged_token1_amount_raw : 0,
            user_datas               : 0x2::table::new<address, UserData>(arg8),
            pool_coin0_liquidity     : 0x2::coin::zero<T0>(arg8),
            pool_coin1_liquidity     : 0x2::coin::zero<T1>(arg8),
            action_box_config_id     : arg7,
        };
        let v4 = PoolManagerCap{
            id      : 0x2::object::new(arg8),
            pool_id : v2,
        };
        0x2::transfer::public_transfer<PoolManagerCap>(v4, v0);
        let v5 = PoolInitializedEvent{
            periphery_pool_id          : v2,
            manager                    : v0,
            chain_id                   : arg0,
            src_vm_type                : arg1,
            kernel_pool                : v3.kernel_pool,
            kernel_factory             : v3.kernel_factory,
            fee                        : arg4,
            description                : v3.description,
            gateways                   : v3.gateways,
            pool_coin0_liquidity_value : 0x2::coin::value<T0>(&v3.pool_coin0_liquidity),
            pool_coin1_liquidity_value : 0x2::coin::value<T1>(&v3.pool_coin1_liquidity),
        };
        0x2::event::emit<PoolInitializedEvent>(v5);
        0x2::transfer::public_share_object<PeripheryPool<T0, T1>>(v3);
    }

    public entry fun mint<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x1c8ccd40545ba604e390e7ff6eff77037d451333caa0fae447695c548abc2893::sui_action_box::Config, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 || v2 > 0, 2);
        arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw + v1;
        arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw + v2;
        if (!0x2::table::contains<address, UserData>(&arg0.user_datas, v0)) {
            let v3 = UserData{
                user               : v0,
                amount0_staged_raw : 0,
                amount1_staged_raw : 0,
                amount0_min        : arg5,
                amount1_min        : arg6,
                withdraw_after_ms  : 0,
                action_id          : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<address, UserData>(&mut arg0.user_datas, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, v0);
        v4.amount0_staged_raw = v4.amount0_staged_raw + v1;
        v4.amount1_staged_raw = v4.amount1_staged_raw + v2;
        v4.withdraw_after_ms = 0x2::clock::timestamp_ms(arg9) + 600000;
        let v5 = v4.withdraw_after_ms;
        let v6 = addr_to_string(v0);
        0x2::object::id<PeripheryPool<T0, T1>>(arg0);
        let v7 = generate_action_id_v2(v0, arg9, arg0.chain_id, arg8, 0x2::tx_context::sender(arg10));
        let v8 = KernelActionMintPayload{
            action_id          : v7,
            chain_id           : arg0.chain_id,
            vm_type            : arg0.src_vm_type,
            user_id_str        : v6,
            kernel_pool_id_str : arg0.kernel_pool,
            tick_lower         : arg3,
            tick_upper         : arg4,
            amount0            : v1,
            amount1            : v2,
            amount0_min        : arg5,
            amount1_min        : arg6,
        };
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, v1);
        0x1::vector::push_back<u64>(v10, v2);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Token0"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Token1"));
        call_action_box_create_action_v2<T0, T1>(arg0, arg7, v6, arg0.kernel_factory, 0x2::bcs::to_bytes<KernelActionMintPayload>(&v8), v9, v11, arg8, arg9, arg10);
        if (v1 > 0) {
            0x2::coin::join<T0>(&mut arg0.pool_coin0_liquidity, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (v2 > 0) {
            0x2::coin::join<T1>(&mut arg0.pool_coin1_liquidity, arg2);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v13 = MintRequestedEvent<T0, T1>{
            user                  : v0,
            periphery_pool_id     : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            tick_lower            : arg3,
            tick_upper            : arg4,
            amount0_deposited_raw : v1,
            amount1_deposited_raw : v2,
            amount0_min           : arg5,
            amount1_min           : arg6,
            withdraw_after_ms     : v5,
            action_id             : v7,
        };
        0x2::event::emit<MintRequestedEvent<T0, T1>>(v13);
    }

    public entry fun remove_gateway<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: &PoolManagerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<PeripheryPool<T0, T1>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.gateways) && !v1) {
            if (*0x1::vector::borrow<address>(&arg0.gateways, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.gateways, v0);
                v1 = true;
            };
            v0 = v0 + 1;
        };
        assert!(v1, 1);
        let v2 = PoolConfigUpdatedEvent{
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            manager           : arg0.manager,
            chain_id          : arg0.chain_id,
            src_vm_type       : arg0.src_vm_type,
            description       : arg0.description,
            gateways          : arg0.gateways,
            kernel_factory    : arg0.kernel_factory,
            kernel_pool       : arg0.kernel_pool,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v2);
    }

    public entry fun remove_staged_assets<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        assert!(0x2::table::contains<address, UserData>(&arg0.user_datas, arg3), 1);
        let v1 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, arg3);
        assert!(0x2::clock::timestamp_ms(arg4) > v1.withdraw_after_ms, 4);
        let v2 = v1.amount0_staged_raw;
        let v3 = v1.amount1_staged_raw;
        v1.amount0_staged_raw = 0;
        v1.amount1_staged_raw = 0;
        assert!(arg0.staged_token0_amount_raw >= v2, 2);
        assert!(arg0.staged_token1_amount_raw >= v3, 2);
        arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw - v2;
        arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw - v3;
        if (v2 > 0) {
            assert!(0x2::coin::value<T0>(arg1) >= v2, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v2, arg5), arg3);
        };
        if (v3 > 0) {
            assert!(0x2::coin::value<T1>(arg2) >= v3, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg2, v3, arg5), arg3);
        };
        let v4 = StagedAssetsRemovedEvent<T0, T1>{
            user                       : arg3,
            periphery_pool_id          : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            returned_amount0_raw       : v2,
            returned_amount1_raw       : v3,
            previous_withdraw_after_ms : v1.withdraw_after_ms,
        };
        0x2::event::emit<StagedAssetsRemovedEvent<T0, T1>>(v4);
    }

    public entry fun settle<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        let v1 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, arg1);
        assert!(v1.amount0_staged_raw >= arg2, 2);
        assert!(v1.amount1_staged_raw >= arg3, 2);
        v1.amount0_staged_raw = v1.amount0_staged_raw - arg2;
        v1.amount1_staged_raw = v1.amount1_staged_raw - arg3;
        assert!(arg0.staged_token0_amount_raw >= arg2, 2);
        assert!(arg0.staged_token1_amount_raw >= arg3, 2);
        arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw - arg2;
        arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw - arg3;
    }

    public entry fun settle_burn<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        if (arg2 > 0) {
            assert!(0x2::coin::value<T0>(&arg0.pool_coin0_liquidity) >= arg2, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool_coin0_liquidity, arg2, arg5), arg1);
        };
        if (arg3 > 0) {
            assert!(0x2::coin::value<T1>(&arg0.pool_coin1_liquidity) >= arg3, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.pool_coin1_liquidity, arg3, arg5), arg1);
        };
        let v1 = BurnSettledEvent<T0, T1>{
            user                    : arg1,
            periphery_pool_id       : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            amount0_transferred_raw : arg2,
            amount1_transferred_raw : arg3,
            task_id                 : arg4,
        };
        0x2::event::emit<BurnSettledEvent<T0, T1>>(v1);
    }

    public entry fun settle_mint<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        let v1 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, arg1);
        assert!(v1.amount0_staged_raw >= arg2, 2);
        assert!(v1.amount1_staged_raw >= arg3, 2);
        v1.amount0_staged_raw = v1.amount0_staged_raw - arg2;
        v1.amount1_staged_raw = v1.amount1_staged_raw - arg3;
        assert!(arg0.staged_token0_amount_raw >= arg2, 2);
        assert!(arg0.staged_token1_amount_raw >= arg3, 2);
        arg0.staged_token0_amount_raw = arg0.staged_token0_amount_raw - arg2;
        arg0.staged_token1_amount_raw = arg0.staged_token1_amount_raw - arg3;
        if (arg4 > 0) {
            assert!(0x2::coin::value<T0>(&arg0.pool_coin0_liquidity) >= arg4, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool_coin0_liquidity, arg4, arg7), arg1);
        };
        if (arg5 > 0) {
            assert!(0x2::coin::value<T1>(&arg0.pool_coin1_liquidity) >= arg5, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.pool_coin1_liquidity, arg5, arg7), arg1);
        };
        let v2 = MintSettledEvent<T0, T1>{
            user                            : arg1,
            periphery_pool_id               : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            settled_amount0_raw             : arg2,
            settled_amount0_transferred_raw : arg4,
            settled_amount1_raw             : arg3,
            settled_amount1_transferred_raw : arg5,
            task_id                         : arg6,
        };
        0x2::event::emit<MintSettledEvent<T0, T1>>(v2);
    }

    public entry fun settle_swap<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool_coin0_liquidity, arg2, arg7), arg1);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.pool_coin1_liquidity, arg3, arg7), arg1);
        };
        let v1 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.user_datas, arg1);
        assert!(v1.amount0_staged_raw >= arg4, 2);
        assert!(v1.amount1_staged_raw >= arg5, 2);
        v1.amount0_staged_raw = v1.amount0_staged_raw - arg4;
        v1.amount1_staged_raw = v1.amount1_staged_raw - arg5;
        let v2 = SwapSettledEvent<T0, T1>{
            user                    : arg1,
            periphery_pool_id       : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            amount0_transferred_raw : arg2,
            amount1_transferred_raw : arg3,
            amount0_settled_raw     : arg4,
            amount1_settled_raw     : arg5,
            task_id                 : arg6,
        };
        0x2::event::emit<SwapSettledEvent<T0, T1>>(v2);
    }

    public entry fun transfer_to<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.gateways, &v0), 1);
        if (arg2 > 0) {
            assert!(0x2::coin::value<T0>(&arg0.pool_coin0_liquidity) >= arg2, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool_coin0_liquidity, arg2, arg4), arg1);
        };
        if (arg3 > 0) {
            assert!(0x2::coin::value<T1>(&arg0.pool_coin1_liquidity) >= arg3, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.pool_coin1_liquidity, arg3, arg4), arg1);
        };
        let v1 = TokensTransferredToEvent<T0, T1>{
            periphery_pool_id       : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            caller                  : v0,
            recipient_address       : arg1,
            amount0_transferred_raw : arg2,
            amount1_transferred_raw : arg3,
        };
        0x2::event::emit<TokensTransferredToEvent<T0, T1>>(v1);
    }

    public entry fun update_pool_config<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: &PoolManagerCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u8>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<vector<address>>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<PeripheryPool<T0, T1>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg8) == arg0.manager, 1);
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.chain_id = 0x1::option::destroy_some<u64>(arg2);
        };
        if (0x1::option::is_some<u8>(&arg3)) {
            arg0.src_vm_type = 0x1::option::destroy_some<u8>(arg3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            arg0.description = 0x1::option::destroy_some<0x1::string::String>(arg4);
        };
        if (0x1::option::is_some<vector<address>>(&arg5)) {
            arg0.gateways = 0x1::option::destroy_some<vector<address>>(arg5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            arg0.kernel_factory = 0x1::option::destroy_some<0x1::string::String>(arg6);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            arg0.kernel_pool = 0x1::option::destroy_some<0x1::string::String>(arg7);
        };
        let v0 = PoolConfigUpdatedEvent{
            periphery_pool_id : 0x2::object::id<PeripheryPool<T0, T1>>(arg0),
            manager           : arg0.manager,
            chain_id          : arg0.chain_id,
            src_vm_type       : arg0.src_vm_type,
            description       : arg0.description,
            gateways          : arg0.gateways,
            kernel_factory    : arg0.kernel_factory,
            kernel_pool       : arg0.kernel_pool,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

