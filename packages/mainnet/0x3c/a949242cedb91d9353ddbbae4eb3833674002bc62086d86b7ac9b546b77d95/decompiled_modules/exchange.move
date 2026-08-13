module 0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::exchange {
    struct ExchangeAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct ExchangePriceAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct ExchangePauseAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct ExchangePool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        reserve_admin: address,
        reserve_admin_version: u64,
        price_admin: address,
        price_admin_version: u64,
        pause_admin: address,
        pause_admin_version: u64,
        receiver: address,
        paused: bool,
        ast_decimals: u8,
        usdc_decimals: u8,
        ast_unit: u64,
        usdc_unit: u64,
        price_e8: u64,
        price_version: u64,
        ast_reserve: 0x2::balance::Balance<T0>,
        total_usdc_received: u128,
        total_ast_sold: u128,
    }

    struct ExchangePoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        admin: address,
        price_admin: address,
        pause_admin: address,
        receiver: address,
        ast_decimals: u8,
        usdc_decimals: u8,
        price_e8: u64,
        initial_ast_reserve: u64,
        timestamp_ms: u64,
    }

    struct AstPurchased has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        receiver: address,
        channel: u8,
        usdc_amount: u64,
        ast_amount: u64,
        price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct ExchangePriceUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_price_e8: u64,
        new_price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct ExchangeReceiverUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_receiver: address,
        new_receiver: address,
        timestamp_ms: u64,
    }

    struct ExchangePauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct ExchangeReserveUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        deposited: bool,
        amount: u64,
        reserve_after: u64,
        timestamp_ms: u64,
    }

    struct ExchangeReserveFunded has copy, drop {
        pool_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
        reserve_after: u64,
        timestamp_ms: u64,
    }

    struct ExchangeAdminUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        role: u8,
        old_admin: address,
        new_admin: address,
        role_version: u64,
        timestamp_ms: u64,
    }

    fun assert_admin<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: &ExchangeAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<ExchangePool<T0, T1>>(arg0), 11);
        assert!(arg1.role_version == arg0.reserve_admin_version, 11);
    }

    fun assert_pause_admin<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: &ExchangePauseAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<ExchangePool<T0, T1>>(arg0), 11);
        assert!(arg1.role_version == arg0.pause_admin_version, 11);
    }

    fun assert_price_admin<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: &ExchangePriceAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<ExchangePool<T0, T1>>(arg0), 11);
        assert!(arg1.role_version == arg0.price_admin_version, 11);
    }

    entry fun buy<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        buy_and_transfer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8);
    }

    fun buy_and_transfer<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = buy_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 1, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg9), arg7);
    }

    public(friend) fun buy_for_order<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        buy_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 2, arg7, arg8)
    }

    public(friend) fun buy_for_order_current<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        let v0 = arg0.price_e8;
        let v1 = arg0.price_version;
        let v2 = arg0.receiver;
        let (v3, v4) = buy_internal<T0, T1>(arg0, arg1, v0, v1, v2, 0, 0x2::clock::timestamp_ms(arg2), 2, arg2, arg3);
        (v3, v4, v0)
    }

    fun buy_internal<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        assert!(!arg0.paused, 4);
        assert!(arg0.price_e8 == arg2, 5);
        assert!(arg0.price_version == arg3, 6);
        assert!(arg0.receiver == arg4, 7);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 <= arg6, 8);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = quote_ast_out_internal<T0, T1>(arg0, v1);
        assert!(v2 >= arg5, 9);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= v2, 10);
        arg0.total_usdc_received = arg0.total_usdc_received + (v1 as u128);
        arg0.total_ast_sold = arg0.total_ast_sold + (v2 as u128);
        let v3 = AstPurchased{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            buyer         : 0x2::tx_context::sender(arg9),
            receiver      : arg0.receiver,
            channel       : arg7,
            usdc_amount   : v1,
            ast_amount    : v2,
            price_e8      : arg0.price_e8,
            price_version : arg0.price_version,
            timestamp_ms  : v0,
        };
        0x2::event::emit<AstPurchased>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.receiver);
        (0x2::balance::split<T0>(&mut arg0.ast_reserve, v2), v2)
    }

    entry fun create_empty_pool<T0, T1>(arg0: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg1: u8, arg2: u8, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg0);
        let v0 = 0x2::coin::zero<T0>(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        create_pool_internal<T0, T1>(v0, arg1, arg2, arg3, arg4, v1, v2, v3, arg5, arg6);
    }

    entry fun create_empty_pool_with_roles<T0, T1>(arg0: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg1: u8, arg2: u8, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg0);
        let v0 = 0x2::coin::zero<T0>(arg9);
        create_pool_internal<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun create_pool<T0, T1>(arg0: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u8, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        create_pool_internal<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, v1, v2, arg6, arg7);
    }

    fun create_pool_internal<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: u8, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != @0x0, 1);
        assert!(arg3 > 0, 2);
        assert!(arg1 <= 9, 3);
        assert!(arg2 <= 9, 3);
        let v0 = if (arg5 != @0x0) {
            if (arg6 != @0x0) {
                arg7 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 15);
        let v1 = ExchangePool<T0, T1>{
            id                    : 0x2::object::new(arg9),
            schema_version        : 3,
            reserve_admin         : arg5,
            reserve_admin_version : 1,
            price_admin           : arg6,
            price_admin_version   : 1,
            pause_admin           : arg7,
            pause_admin_version   : 1,
            receiver              : arg4,
            paused                : false,
            ast_decimals          : arg1,
            usdc_decimals         : arg2,
            ast_unit              : pow10(arg1),
            usdc_unit             : pow10(arg2),
            price_e8              : arg3,
            price_version         : 1,
            ast_reserve           : 0x2::coin::into_balance<T0>(arg0),
            total_usdc_received   : 0,
            total_ast_sold        : 0,
        };
        let v2 = 0x2::object::id<ExchangePool<T0, T1>>(&v1);
        let v3 = ExchangeAdminCap<T0, T1>{
            id             : 0x2::object::new(arg9),
            schema_version : 3,
            pool_id        : v2,
            role_version   : 1,
        };
        let v4 = ExchangePriceAdminCap<T0, T1>{
            id             : 0x2::object::new(arg9),
            schema_version : 3,
            pool_id        : v2,
            role_version   : 1,
        };
        let v5 = ExchangePauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg9),
            schema_version : 3,
            pool_id        : v2,
            role_version   : 1,
        };
        let v6 = ExchangePoolCreated{
            pool_id             : v2,
            owner               : 0x2::tx_context::sender(arg9),
            admin               : arg5,
            price_admin         : arg6,
            pause_admin         : arg7,
            receiver            : arg4,
            ast_decimals        : arg1,
            usdc_decimals       : arg2,
            price_e8            : arg3,
            initial_ast_reserve : 0x2::coin::value<T0>(&arg0),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<ExchangePoolCreated>(v6);
        0x2::transfer::share_object<ExchangePool<T0, T1>>(v1);
        0x2::transfer::transfer<ExchangeAdminCap<T0, T1>>(v3, arg5);
        0x2::transfer::transfer<ExchangePriceAdminCap<T0, T1>>(v4, arg6);
        0x2::transfer::transfer<ExchangePauseAdminCap<T0, T1>>(v5, arg7);
    }

    public fun deposit_ast_reserve<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &ExchangeAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v0 = ExchangeReserveUpdated{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            deposited     : true,
            amount        : 0x2::coin::value<T0>(&arg2),
            reserve_after : 0x2::balance::value<T0>(&arg0.ast_reserve),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExchangeReserveUpdated>(v0);
    }

    fun emit_admin_updated<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: u8, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = ExchangeAdminUpdated{
            pool_id      : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            role         : arg1,
            old_admin    : arg2,
            new_admin    : arg3,
            role_version : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ExchangeAdminUpdated>(v0);
    }

    public fun fund_ast_reserve<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 14);
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::balance::value<T0>(&arg0.ast_reserve);
        let v2 = ExchangeReserveUpdated{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            deposited     : true,
            amount        : v0,
            reserve_after : v1,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ExchangeReserveUpdated>(v2);
        let v3 = ExchangeReserveFunded{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            contributor   : 0x2::tx_context::sender(arg3),
            amount        : v0,
            reserve_after : v1,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ExchangeReserveFunded>(v3);
    }

    public fun get_admin_pool_id<T0, T1>(arg0: &ExchangeAdminCap<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_ast_unit<T0, T1>(arg0: &ExchangePool<T0, T1>) : u64 {
        arg0.ast_unit
    }

    public fun get_pool_id<T0, T1>(arg0: &ExchangePool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<ExchangePool<T0, T1>>(arg0)
    }

    public fun get_pool_info<T0, T1>(arg0: &ExchangePool<T0, T1>) : (u64, address, bool, u8, u8, u64, u64, u64, u128, u128) {
        (arg0.schema_version, arg0.receiver, arg0.paused, arg0.ast_decimals, arg0.usdc_decimals, arg0.price_e8, arg0.price_version, 0x2::balance::value<T0>(&arg0.ast_reserve), arg0.total_usdc_received, arg0.total_ast_sold)
    }

    public fun get_price_e8<T0, T1>(arg0: &ExchangePool<T0, T1>) : u64 {
        arg0.price_e8
    }

    public fun get_price_version<T0, T1>(arg0: &ExchangePool<T0, T1>) : u64 {
        arg0.price_version
    }

    public fun get_receiver<T0, T1>(arg0: &ExchangePool<T0, T1>) : address {
        arg0.receiver
    }

    public fun get_reserve<T0, T1>(arg0: &ExchangePool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.ast_reserve)
    }

    public fun get_role_info<T0, T1>(arg0: &ExchangePool<T0, T1>) : (address, u64, address, u64, address, u64) {
        (arg0.reserve_admin, arg0.reserve_admin_version, arg0.price_admin, arg0.price_admin_version, arg0.pause_admin, arg0.pause_admin_version)
    }

    public fun get_usdc_unit<T0, T1>(arg0: &ExchangePool<T0, T1>) : u64 {
        arg0.usdc_unit
    }

    public fun owner_replace_pause_admin<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 15);
        arg0.pause_admin = arg2;
        arg0.pause_admin_version = arg0.pause_admin_version + 1;
        let v0 = arg0.pause_admin_version;
        let v1 = ExchangePauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 3,
            pool_id        : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 3, arg0.pause_admin, arg2, v0, arg3);
        0x2::transfer::transfer<ExchangePauseAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_price_admin<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 15);
        arg0.price_admin = arg2;
        arg0.price_admin_version = arg0.price_admin_version + 1;
        let v0 = arg0.price_admin_version;
        let v1 = ExchangePriceAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 3,
            pool_id        : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 2, arg0.price_admin, arg2, v0, arg3);
        0x2::transfer::transfer<ExchangePriceAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_reserve_admin<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 15);
        arg0.reserve_admin = arg2;
        arg0.reserve_admin_version = arg0.reserve_admin_version + 1;
        let v0 = arg0.reserve_admin_version;
        let v1 = ExchangeAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 3,
            pool_id        : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 1, arg0.reserve_admin, arg2, v0, arg3);
        0x2::transfer::transfer<ExchangeAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_set_paused<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: bool, arg3: &0x2::clock::Clock) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_set_price<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        set_price_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_set_receiver<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        set_receiver_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_withdraw_ast_reserve<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::ProtocolOwnerCap, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ca949242cedb91d9353ddbbae4eb3833674002bc62086d86b7ac9b546b77d95::governance::assert_owner(arg1);
        withdraw_ast_reserve_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
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

    public fun quote_ast_out<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: u64) : u64 {
        quote_ast_out_internal<T0, T1>(arg0, arg1)
    }

    fun quote_ast_out_internal<T0, T1>(arg0: &ExchangePool<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.ast_unit as u128) * (100000000 as u128) / (arg0.price_e8 as u128) * (arg0.usdc_unit as u128);
        assert!(v0 > 0, 13);
        assert!(v0 <= 18446744073709551615, 12);
        (v0 as u64)
    }

    public fun set_paused<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &ExchangePauseAdminCap<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_pause_admin<T0, T1>(arg0, arg1);
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_paused_internal<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) {
        arg0.paused = arg1;
        let v0 = ExchangePauseUpdated{
            pool_id      : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            paused       : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ExchangePauseUpdated>(v0);
    }

    public fun set_price<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &ExchangePriceAdminCap<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_price_admin<T0, T1>(arg0, arg1);
        set_price_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_price_internal<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0, 2);
        arg0.price_e8 = arg1;
        arg0.price_version = arg0.price_version + 1;
        let v0 = ExchangePriceUpdated{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            old_price_e8  : arg0.price_e8,
            new_price_e8  : arg1,
            price_version : arg0.price_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ExchangePriceUpdated>(v0);
    }

    public fun set_receiver<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &ExchangeAdminCap<T0, T1>, arg2: address, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        set_receiver_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_receiver_internal<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(arg1 != @0x0, 1);
        arg0.receiver = arg1;
        let v0 = ExchangeReceiverUpdated{
            pool_id      : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            old_receiver : arg0.receiver,
            new_receiver : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ExchangeReceiverUpdated>(v0);
    }

    public fun withdraw_ast_reserve<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: &ExchangeAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        withdraw_ast_reserve_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    fun withdraw_ast_reserve_internal<T0, T1>(arg0: &mut ExchangePool<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 1);
        assert!(arg1 > 0, 14);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= arg1, 10);
        let v0 = ExchangeReserveUpdated{
            pool_id       : 0x2::object::id<ExchangePool<T0, T1>>(arg0),
            deposited     : false,
            amount        : arg1,
            reserve_after : 0x2::balance::value<T0>(&arg0.ast_reserve),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExchangeReserveUpdated>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.ast_reserve, arg1), arg4), arg2);
    }

    // decompiled from Move bytecode v7
}

