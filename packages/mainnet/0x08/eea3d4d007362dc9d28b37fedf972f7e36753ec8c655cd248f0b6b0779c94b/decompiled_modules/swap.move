module 0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::swap {
    struct SwapAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct SwapPriceAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct SwapPauseAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct SwapPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        reserve_admin: address,
        reserve_admin_version: u64,
        price_admin: address,
        price_admin_version: u64,
        pause_admin: address,
        pause_admin_version: u64,
        paused: bool,
        ast_decimals: u8,
        usdc_decimals: u8,
        ast_unit: u64,
        usdc_unit: u64,
        price_e8: u64,
        price_version: u64,
        buy_fee_bps: u64,
        sell_fee_bps: u64,
        ast_reserve: 0x2::balance::Balance<T0>,
        usdc_reserve: 0x2::balance::Balance<T1>,
        total_ast_fee: u128,
        total_usdc_fee: u128,
        total_usdc_in: u128,
        total_ast_out: u128,
        total_ast_in: u128,
        total_usdc_out: u128,
    }

    struct SwapPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        admin: address,
        price_admin: address,
        pause_admin: address,
        burn_address: address,
        ast_decimals: u8,
        usdc_decimals: u8,
        price_e8: u64,
        initial_ast_reserve: u64,
        initial_usdc_reserve: u64,
        timestamp_ms: u64,
    }

    struct SwapExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
        price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct SwapPriceUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_price_e8: u64,
        new_price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct SwapPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct SwapFeeUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_buy_fee_bps: u64,
        new_buy_fee_bps: u64,
        old_sell_fee_bps: u64,
        new_sell_fee_bps: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct SwapFeeCharged has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        direction: u8,
        gross_amount_out: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_bps: u64,
        fee_asset: u8,
        fee_from_input: bool,
        burn_address: address,
        timestamp_ms: u64,
    }

    struct SwapReserveUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        asset: u8,
        deposited: bool,
        amount: u64,
        reserve_after: u64,
        timestamp_ms: u64,
    }

    struct SwapAdminUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        role: u8,
        old_admin: address,
        new_admin: address,
        role_version: u64,
        timestamp_ms: u64,
    }

    fun assert_admin<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<SwapPool<T0, T1>>(arg0), 10);
        assert!(arg1.role_version == arg0.reserve_admin_version, 10);
    }

    fun assert_pause_admin<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: &SwapPauseAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<SwapPool<T0, T1>>(arg0), 10);
        assert!(arg1.role_version == arg0.pause_admin_version, 10);
    }

    fun assert_price_admin<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: &SwapPriceAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<SwapPool<T0, T1>>(arg0), 10);
        assert!(arg1.role_version == arg0.price_admin_version, 10);
    }

    fun assert_trade_ready<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!arg0.paused, 3);
        assert!(arg0.price_e8 == arg1, 4);
        assert!(arg0.price_version == arg2, 5);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 6);
    }

    fun buy_fee_bps<T0, T1>(arg0: &SwapPool<T0, T1>) : u64 {
        let (v0, _) = fee_bps<T0, T1>(arg0);
        v0
    }

    entry fun create_empty_pool<T0, T1>(arg0: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg1: u8, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg0);
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::zero<T1>(arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = 0x2::tx_context::sender(arg5);
        create_pool_internal<T0, T1>(v0, v1, arg1, arg2, arg3, 0, 100, v2, v3, v4, arg4, arg5);
    }

    entry fun create_empty_pool_with_fees<T0, T1>(arg0: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg0);
        let v0 = 0x2::coin::zero<T0>(arg7);
        let v1 = 0x2::coin::zero<T1>(arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        create_pool_internal<T0, T1>(v0, v1, arg1, arg2, arg3, arg4, arg5, v2, v3, v4, arg6, arg7);
    }

    entry fun create_empty_pool_with_roles<T0, T1>(arg0: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg0);
        let v0 = 0x2::coin::zero<T0>(arg10);
        let v1 = 0x2::coin::zero<T1>(arg10);
        create_pool_internal<T0, T1>(v0, v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun create_pool<T0, T1>(arg0: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        create_pool_internal<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0, 100, v0, v1, v2, arg6, arg7);
    }

    fun create_pool_internal<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 1);
        assert!(arg2 <= 9, 2);
        assert!(arg3 <= 9, 2);
        let v0 = if (arg7 != @0x0) {
            if (arg8 != @0x0) {
                arg9 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        validate_fee_bps(arg5);
        validate_fee_bps(arg6);
        let v1 = SwapPool<T0, T1>{
            id                    : 0x2::object::new(arg11),
            schema_version        : 4,
            reserve_admin         : arg7,
            reserve_admin_version : 1,
            price_admin           : arg8,
            price_admin_version   : 1,
            pause_admin           : arg9,
            pause_admin_version   : 1,
            paused                : false,
            ast_decimals          : arg2,
            usdc_decimals         : arg3,
            ast_unit              : pow10(arg2),
            usdc_unit             : pow10(arg3),
            price_e8              : arg4,
            price_version         : 1,
            buy_fee_bps           : arg5,
            sell_fee_bps          : arg6,
            ast_reserve           : 0x2::coin::into_balance<T0>(arg0),
            usdc_reserve          : 0x2::coin::into_balance<T1>(arg1),
            total_ast_fee         : 0,
            total_usdc_fee        : 0,
            total_usdc_in         : 0,
            total_ast_out         : 0,
            total_ast_in          : 0,
            total_usdc_out        : 0,
        };
        let v2 = 0x2::object::id<SwapPool<T0, T1>>(&v1);
        let v3 = SwapAdminCap<T0, T1>{
            id             : 0x2::object::new(arg11),
            schema_version : 4,
            pool_id        : v2,
            role_version   : 1,
        };
        let v4 = SwapPriceAdminCap<T0, T1>{
            id             : 0x2::object::new(arg11),
            schema_version : 4,
            pool_id        : v2,
            role_version   : 1,
        };
        let v5 = SwapPauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg11),
            schema_version : 4,
            pool_id        : v2,
            role_version   : 1,
        };
        let v6 = SwapPoolCreated{
            pool_id              : v2,
            owner                : 0x2::tx_context::sender(arg11),
            admin                : arg7,
            price_admin          : arg8,
            pause_admin          : arg9,
            burn_address         : @0xdead,
            ast_decimals         : arg2,
            usdc_decimals        : arg3,
            price_e8             : arg4,
            initial_ast_reserve  : 0x2::coin::value<T0>(&arg0),
            initial_usdc_reserve : 0x2::coin::value<T1>(&arg1),
            timestamp_ms         : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<SwapPoolCreated>(v6);
        0x2::transfer::share_object<SwapPool<T0, T1>>(v1);
        0x2::transfer::transfer<SwapAdminCap<T0, T1>>(v3, arg7);
        0x2::transfer::transfer<SwapPriceAdminCap<T0, T1>>(v4, arg8);
        0x2::transfer::transfer<SwapPauseAdminCap<T0, T1>>(v5, arg9);
    }

    fun emit_admin_updated<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u8, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = SwapAdminUpdated{
            pool_id      : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            role         : arg1,
            old_admin    : arg2,
            new_admin    : arg3,
            role_version : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapAdminUpdated>(v0);
    }

    fun emit_reserve<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u8, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = SwapReserveUpdated{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            asset         : arg1,
            deposited     : arg2,
            amount        : arg3,
            reserve_after : arg4,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapReserveUpdated>(v0);
    }

    fun emit_swap<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = SwapExecuted{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            trader        : 0x2::tx_context::sender(arg8),
            direction     : arg1,
            amount_in     : arg2,
            amount_out    : arg4,
            price_e8      : arg0.price_e8,
            price_version : arg0.price_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SwapExecuted>(v0);
        let v1 = SwapFeeCharged{
            pool_id          : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            trader           : 0x2::tx_context::sender(arg8),
            direction        : arg1,
            gross_amount_out : arg3,
            amount_out       : arg4,
            fee_amount       : arg5,
            fee_bps          : arg6,
            fee_asset        : 1,
            fee_from_input   : arg1 == 2,
            burn_address     : @0xdead,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SwapFeeCharged>(v1);
    }

    fun fee_bps<T0, T1>(arg0: &SwapPool<T0, T1>) : (u64, u64) {
        (arg0.buy_fee_bps, arg0.sell_fee_bps)
    }

    public fun fund_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        fund_ast_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun fund_ast_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13);
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg1));
        emit_reserve<T0, T1>(arg0, 1, true, v0, 0x2::balance::value<T0>(&arg0.ast_reserve), arg2);
    }

    public fun fund_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        fund_usdc_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun fund_usdc_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 13);
        0x2::balance::join<T1>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T1>(arg1));
        emit_reserve<T0, T1>(arg0, 2, true, v0, 0x2::balance::value<T1>(&arg0.usdc_reserve), arg2);
    }

    public fun get_fee_info<T0, T1>(arg0: &SwapPool<T0, T1>) : (bool, bool, u64, u64, u128, u128) {
        (true, arg0.paused, arg0.buy_fee_bps, arg0.sell_fee_bps, arg0.total_ast_fee, arg0.total_usdc_fee)
    }

    public fun get_pool_info<T0, T1>(arg0: &SwapPool<T0, T1>) : (u64, bool, u8, u8, u64, u64, u64, u64, u128, u128, u128, u128) {
        (arg0.schema_version, arg0.paused, arg0.ast_decimals, arg0.usdc_decimals, arg0.price_e8, arg0.price_version, 0x2::balance::value<T0>(&arg0.ast_reserve), 0x2::balance::value<T1>(&arg0.usdc_reserve), arg0.total_usdc_in, arg0.total_ast_out, arg0.total_ast_in, arg0.total_usdc_out)
    }

    public fun get_role_info<T0, T1>(arg0: &SwapPool<T0, T1>) : (address, u64, address, u64, address, u64) {
        (arg0.reserve_admin, arg0.reserve_admin_version, arg0.price_admin, arg0.price_admin_version, arg0.pause_admin, arg0.pause_admin_version)
    }

    public fun owner_fund_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        fund_ast_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_fund_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        fund_usdc_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_replace_pause_admin<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 16);
        arg0.pause_admin = arg2;
        arg0.pause_admin_version = arg0.pause_admin_version + 1;
        let v0 = arg0.pause_admin_version;
        let v1 = SwapPauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 4,
            pool_id        : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 3, arg0.pause_admin, arg2, v0, arg3);
        0x2::transfer::transfer<SwapPauseAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_price_admin<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 16);
        arg0.price_admin = arg2;
        arg0.price_admin_version = arg0.price_admin_version + 1;
        let v0 = arg0.price_admin_version;
        let v1 = SwapPriceAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 4,
            pool_id        : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 2, arg0.price_admin, arg2, v0, arg3);
        0x2::transfer::transfer<SwapPriceAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_reserve_admin<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 16);
        arg0.reserve_admin = arg2;
        arg0.reserve_admin_version = arg0.reserve_admin_version + 1;
        let v0 = arg0.reserve_admin_version;
        let v1 = SwapAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 4,
            pool_id        : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 1, arg0.reserve_admin, arg2, v0, arg3);
        0x2::transfer::transfer<SwapAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_set_fees<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        set_fees_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun owner_set_paused<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: bool, arg3: &0x2::clock::Clock) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_set_price<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        set_price_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_withdraw_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        withdraw_ast_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun owner_withdraw_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::ProtocolOwnerCap, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance::assert_owner(arg1);
        withdraw_usdc_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun quote_after_fee(arg0: u128, arg1: u64) : (u64, u64, u64) {
        assert!(arg0 > 0, 12);
        assert!(arg0 <= 18446744073709551615, 11);
        let v0 = arg0 * (arg1 as u128) / (10000 as u128);
        let v1 = arg0 - v0;
        assert!(v1 > 0, 12);
        ((arg0 as u64), (v0 as u64), (v1 as u64))
    }

    public fun quote_ast_out<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        let (_, _, v2) = quote_ast_out_internal<T0, T1>(arg0, arg1);
        v2
    }

    public fun quote_ast_out_details<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        quote_ast_out_internal<T0, T1>(arg0, arg1)
    }

    fun quote_ast_out_internal<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        quote_after_fee((arg1 as u128) * (arg0.ast_unit as u128) * (100000000 as u128) / (arg0.price_e8 as u128) * (arg0.usdc_unit as u128), buy_fee_bps<T0, T1>(arg0))
    }

    public fun quote_usdc_out<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        let (_, _, v2) = quote_usdc_out_internal<T0, T1>(arg0, arg1);
        v2
    }

    public fun quote_usdc_out_details<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        quote_usdc_out_internal<T0, T1>(arg0, arg1)
    }

    fun quote_usdc_out_internal<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        let v0 = (arg1 as u128);
        let v1 = v0 * (sell_fee_bps<T0, T1>(arg0) as u128) / (10000 as u128);
        let v2 = v0 - v1;
        assert!(v2 > 0, 12);
        let v3 = (arg0.ast_unit as u128) * (100000000 as u128);
        let v4 = v0 * (arg0.price_e8 as u128) * (arg0.usdc_unit as u128) / v3;
        let v5 = v2 * (arg0.price_e8 as u128) * (arg0.usdc_unit as u128) / v3;
        assert!(v4 > 0 && v5 > 0, 12);
        let v6 = if (v4 <= 18446744073709551615) {
            if (v1 <= 18446744073709551615) {
                v5 <= 18446744073709551615
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 11);
        ((v4 as u64), (v1 as u64), (v5 as u64))
    }

    fun record_ast_fee<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        arg0.total_ast_fee = arg0.total_ast_fee + (arg1 as u128);
    }

    fun sell_fee_bps<T0, T1>(arg0: &SwapPool<T0, T1>) : u64 {
        let (_, v1) = fee_bps<T0, T1>(arg0);
        v1
    }

    public fun set_fees<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        set_fees_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    fun set_fees_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        validate_fee_bps(arg1);
        validate_fee_bps(arg2);
        arg0.buy_fee_bps = arg1;
        arg0.sell_fee_bps = arg2;
        arg0.price_version = arg0.price_version + 1;
        let v0 = SwapFeeUpdated{
            pool_id          : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            old_buy_fee_bps  : arg0.buy_fee_bps,
            new_buy_fee_bps  : arg1,
            old_sell_fee_bps : arg0.sell_fee_bps,
            new_sell_fee_bps : arg2,
            price_version    : arg0.price_version,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapFeeUpdated>(v0);
    }

    public fun set_paused<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapPauseAdminCap<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_pause_admin<T0, T1>(arg0, arg1);
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_paused_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) {
        arg0.paused = arg1;
        let v0 = SwapPauseUpdated{
            pool_id      : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            paused       : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapPauseUpdated>(v0);
    }

    public fun set_price<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapPriceAdminCap<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_price_admin<T0, T1>(arg0, arg1);
        set_price_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_price_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0, 1);
        arg0.price_e8 = arg1;
        arg0.price_version = arg0.price_version + 1;
        let v0 = SwapPriceUpdated{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            old_price_e8  : arg0.price_e8,
            new_price_e8  : arg1,
            price_version : arg0.price_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapPriceUpdated>(v0);
    }

    entry fun swap_ast_for_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_trade_ready<T0, T1>(arg0, arg2, arg3, arg5, arg6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2, v3) = quote_usdc_out_internal<T0, T1>(arg0, v0);
        assert!(v3 >= arg4, 7);
        assert!(0x2::balance::value<T1>(&arg0.usdc_reserve) >= v3, 9);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg7), @0xdead);
        };
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v4 = 0x2::balance::split<T1>(&mut arg0.usdc_reserve, v3);
        arg0.total_ast_in = arg0.total_ast_in + (v0 as u128);
        arg0.total_usdc_out = arg0.total_usdc_out + (v3 as u128);
        let v5 = sell_fee_bps<T0, T1>(arg0);
        record_ast_fee<T0, T1>(arg0, v2);
        emit_swap<T0, T1>(arg0, 2, v0, v1, v3, v2, v5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg7), 0x2::tx_context::sender(arg7));
    }

    entry fun swap_usdc_for_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_trade_ready<T0, T1>(arg0, arg2, arg3, arg5, arg6);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let (v1, v2, v3) = quote_ast_out_internal<T0, T1>(arg0, v0);
        assert!(v3 >= arg4, 7);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= v1, 8);
        0x2::balance::join<T1>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T1>(arg1));
        let v4 = 0x2::balance::split<T0>(&mut arg0.ast_reserve, v3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.ast_reserve, v2), arg7), @0xdead);
        };
        arg0.total_usdc_in = arg0.total_usdc_in + (v0 as u128);
        arg0.total_ast_out = arg0.total_ast_out + (v3 as u128);
        let v5 = buy_fee_bps<T0, T1>(arg0);
        record_ast_fee<T0, T1>(arg0, v2);
        emit_swap<T0, T1>(arg0, 1, v0, v1, v3, v2, v5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg7), 0x2::tx_context::sender(arg7));
    }

    fun validate_fee_bps(arg0: u64) {
        assert!(arg0 <= 1000, 15);
    }

    public fun withdraw_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        withdraw_ast_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun withdraw_ast_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13);
        assert!(arg2 != @0x0, 14);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= arg1, 8);
        emit_reserve<T0, T1>(arg0, 1, false, arg1, 0x2::balance::value<T0>(&arg0.ast_reserve), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.ast_reserve, arg1), arg4), arg2);
    }

    public fun withdraw_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        withdraw_usdc_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun withdraw_usdc_internal<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13);
        assert!(arg2 != @0x0, 14);
        assert!(0x2::balance::value<T1>(&arg0.usdc_reserve) >= arg1, 9);
        emit_reserve<T0, T1>(arg0, 2, false, arg1, 0x2::balance::value<T1>(&arg0.usdc_reserve), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.usdc_reserve, arg1), arg4), arg2);
    }

    // decompiled from Move bytecode v7
}

