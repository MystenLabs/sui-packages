module 0x21101dbd484664b2b86a6408f2f09871c99d45c6535fd6b9bf55ab85d909f9d2::pool {
    struct MintEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        user: address,
        tick_lower: u64,
        tick_lower_negative: bool,
        tick_upper: u64,
        tick_upper_negative: bool,
        amount0: u64,
        amount1: u64,
    }

    struct BurnedEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        user: address,
        liquidity_amount: u128,
    }

    struct SwappedEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        user: address,
        zero_for_one: bool,
        amount_specified: u64,
        sqrt_price_limit_x96: u128,
    }

    struct AmountSettledEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        user: address,
        amount0: u64,
        amount1: u64,
    }

    struct TransferredToEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        user: address,
        amount0: u64,
        amount1: u64,
    }

    struct PoolDataModifiedEvent has copy, drop {
        pool: address,
        kernel_pool: address,
        manager: address,
        fee: u32,
        dest_chain_id: u64,
        dest_vm_type: u8,
    }

    struct PeripheryPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        kernel_pool: address,
        kernel_manager: address,
        manager: address,
        fee: u32,
        description: vector<u8>,
        config: 0x440464ccb8d0f25a18dc447d67d4fa471fd803761d7014efa339697fc6d471ef::sui_action_box::Config,
        chain_id: u64,
        vm_type: u8,
        dest_chain_id: u64,
        dest_vm_type: u8,
        users_data: 0x2::table::Table<address, UserData>,
        balance0: 0x2::balance::Balance<T0>,
        balance1: 0x2::balance::Balance<T1>,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct UserData has store {
        amount0: u64,
        amount1: u64,
        withdraw_after: u64,
    }

    public entry fun swap<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: &mut 0x2::coin::Coin<T0>, arg10: &mut 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 4);
        if (arg2) {
            assert!(0x2::balance::value<T1>(&arg0.balance1) >= arg5, 3);
        } else {
            assert!(0x2::balance::value<T0>(&arg0.balance0) >= arg5, 3);
        };
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = &mut arg0.users_data;
        let v2 = get_or_create_user_data<T0, T1>(v1, v0, arg12);
        if (arg2) {
            v2.amount0 = v2.amount0 + arg3;
        } else {
            v2.amount1 = v2.amount1 + arg3;
        };
        v2.withdraw_after = 0x2::clock::timestamp_ms(arg11) + 600000;
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, b"swap");
        0x1::vector::append<u8>(&mut v3, get_action_id(v0, arg11, arg0.chain_id, 0x2::clock::timestamp_ms(arg11), &arg0.id));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u8>(&arg0.vm_type));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u8>(&arg7));
        0x1::vector::append<u8>(&mut v3, arg1);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg0.kernel_pool));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<bool>(&arg2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u128>(&arg4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v3, arg8);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, arg3);
        0x1::vector::push_back<u64>(&mut v4, arg5);
        0x440464ccb8d0f25a18dc447d67d4fa471fd803761d7014efa339697fc6d471ef::sui_action_box::create_action_v2(&arg0.config, 0x2::bcs::to_bytes<address>(&v0), 0x2::bcs::to_bytes<address>(&arg0.kernel_pool), v3, v4, 0x1::vector::empty<vector<u8>>(), 0x2::clock::timestamp_ms(arg11), arg11, arg12);
        if (arg2) {
            0x2::balance::join<T0>(&mut arg0.balance0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg9, arg3, arg12)));
        } else {
            0x2::balance::join<T1>(&mut arg0.balance1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg10, arg3, arg12)));
        };
        let v5 = SwappedEvent{
            pool                 : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool          : arg0.kernel_pool,
            user                 : v0,
            zero_for_one         : arg2,
            amount_specified     : arg3,
            sqrt_price_limit_x96 : arg4,
        };
        0x2::event::emit<SwappedEvent>(v5);
    }

    public entry fun add_to_whitelist<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        0x2::table::add<address, bool>(&mut arg0.whitelist, arg1, true);
    }

    public entry fun backdoor_withdraw<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance0, 18446744073709551615), arg1), arg0.manager);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance1, 18446744073709551615), arg1), arg0.manager);
    }

    public entry fun burn<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg0.users_data;
        get_or_create_user_data<T0, T1>(v1, v0, arg3);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"burn");
        0x1::vector::append<u8>(&mut v2, get_action_id(v0, arg2, arg0.chain_id, 0x2::clock::timestamp_ms(arg2), &arg0.id));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u8>(&arg0.vm_type));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&arg0.kernel_pool));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u128>(&arg1));
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&v3));
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, (arg1 as u64));
        0x440464ccb8d0f25a18dc447d67d4fa471fd803761d7014efa339697fc6d471ef::sui_action_box::create_action_v2(&arg0.config, 0x2::bcs::to_bytes<address>(&v0), 0x2::bcs::to_bytes<address>(&arg0.kernel_pool), v2, v4, 0x1::vector::empty<vector<u8>>(), 0x2::clock::timestamp_ms(arg2), arg2, arg3);
        let v5 = BurnedEvent{
            pool             : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool      : arg0.kernel_pool,
            user             : v0,
            liquidity_amount : arg1,
        };
        0x2::event::emit<BurnedEvent>(v5);
    }

    public entry fun create_pool<T0, T1>(arg0: address, arg1: address, arg2: u32, arg3: vector<u8>, arg4: 0x440464ccb8d0f25a18dc447d67d4fa471fd803761d7014efa339697fc6d471ef::sui_action_box::Config, arg5: u64, arg6: u8, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = PeripheryPool<T0, T1>{
            id             : 0x2::object::new(arg9),
            kernel_pool    : arg1,
            kernel_manager : arg0,
            manager        : 0x2::tx_context::sender(arg9),
            fee            : arg2,
            description    : arg3,
            config         : arg4,
            chain_id       : arg5,
            vm_type        : arg6,
            dest_chain_id  : arg7,
            dest_vm_type   : arg8,
            users_data     : 0x2::table::new<address, UserData>(arg9),
            balance0       : 0x2::balance::zero<T0>(),
            balance1       : 0x2::balance::zero<T1>(),
            whitelist      : 0x2::table::new<address, bool>(arg9),
        };
        0x2::table::add<address, bool>(&mut v0.whitelist, 0x2::tx_context::sender(arg9), true);
        0x2::transfer::transfer<PeripheryPool<T0, T1>>(v0, 0x2::tx_context::sender(arg9));
    }

    fun get_action_id(arg0: address, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::object::UID) : vector<u8> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        let v2 = @0x0;
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v2));
        0x2::hash::keccak256(&v1)
    }

    fun get_or_create_user_data<T0, T1>(arg0: &mut 0x2::table::Table<address, UserData>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut UserData {
        if (!0x2::table::contains<address, UserData>(arg0, arg1)) {
            let v0 = UserData{
                amount0        : 0,
                amount1        : 0,
                withdraw_after : 0,
            };
            0x2::table::add<address, UserData>(arg0, arg1, v0);
        };
        0x2::table::borrow_mut<address, UserData>(arg0, arg1)
    }

    fun is_whitelisted<T0, T1>(arg0: &PeripheryPool<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelist, arg1)
    }

    public entry fun mint<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0 || arg8 > 0, 0);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = &mut arg0.users_data;
        let v2 = get_or_create_user_data<T0, T1>(v1, v0, arg10);
        v2.amount0 = v2.amount0 + arg7;
        v2.amount1 = v2.amount1 + arg8;
        v2.withdraw_after = 0x2::clock::timestamp_ms(arg9) + 600000;
        0x2::balance::join<T0>(&mut arg0.balance0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, arg7, arg10)));
        0x2::balance::join<T1>(&mut arg0.balance1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg6, arg8, arg10)));
        let v3 = MintEvent{
            pool                : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool         : arg0.kernel_pool,
            user                : v0,
            tick_lower          : arg1,
            tick_lower_negative : arg2,
            tick_upper          : arg3,
            tick_upper_negative : arg4,
            amount0             : arg7,
            amount1             : arg8,
        };
        0x2::event::emit<MintEvent>(v3);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, b"mint");
        0x1::vector::append<u8>(&mut v4, get_action_id(v0, arg9, arg0.chain_id, 0x2::clock::timestamp_ms(arg9), &arg0.id));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u8>(&arg0.vm_type));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&arg0.kernel_pool));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v4, 0x1::vector::empty<u8>());
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, arg7);
        0x1::vector::push_back<u64>(&mut v5, arg8);
        0x440464ccb8d0f25a18dc447d67d4fa471fd803761d7014efa339697fc6d471ef::sui_action_box::create_action_v2(&arg0.config, 0x2::bcs::to_bytes<address>(&v0), 0x2::bcs::to_bytes<address>(&arg0.kernel_pool), v4, v5, 0x1::vector::empty<vector<u8>>(), 0x2::clock::timestamp_ms(arg9), arg9, arg10);
    }

    public entry fun modify_pool_data<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: bool, arg3: address, arg4: bool, arg5: address, arg6: bool, arg7: u32, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: u64, arg12: bool, arg13: u8, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg15) == arg0.manager, 1);
        if (arg2) {
            arg0.kernel_manager = arg1;
        };
        if (arg4) {
            arg0.kernel_pool = arg3;
        };
        if (arg6) {
            arg0.manager = arg5;
        };
        if (arg8) {
            arg0.fee = arg7;
        };
        if (arg10) {
            arg0.description = arg9;
        };
        if (arg12) {
            arg0.dest_chain_id = arg11;
        };
        if (arg14) {
            arg0.dest_vm_type = arg13;
        };
        let v0 = PoolDataModifiedEvent{
            pool          : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool   : arg0.kernel_pool,
            manager       : arg0.manager,
            fee           : arg0.fee,
            dest_chain_id : arg0.dest_chain_id,
            dest_vm_type  : arg0.dest_vm_type,
        };
        0x2::event::emit<PoolDataModifiedEvent>(v0);
    }

    fun normalize_token_amount(arg0: u64, arg1: address) : u64 {
        arg0
    }

    public entry fun remove_from_whitelist<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        0x2::table::remove<address, bool>(&mut arg0.whitelist, arg1);
    }

    public entry fun settle_burn<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelisted<T0, T1>(arg0, 0x2::tx_context::sender(arg6)), 1);
        settle_internal<T0, T1>(arg0, arg1, arg2, arg3);
        transfer_to_internal<T0, T1>(arg0, arg1, arg4, arg5, arg6);
        let v0 = AmountSettledEvent{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool : arg0.kernel_pool,
            user        : arg1,
            amount0     : arg2,
            amount1     : arg3,
        };
        0x2::event::emit<AmountSettledEvent>(v0);
    }

    fun settle_internal<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, UserData>(&mut arg0.users_data, arg1);
        assert!(v0.amount0 >= arg2 && v0.amount1 >= arg3, 3);
        v0.amount0 = v0.amount0 - arg2;
        v0.amount1 = v0.amount1 - arg3;
    }

    public entry fun settle_mint<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelisted<T0, T1>(arg0, 0x2::tx_context::sender(arg6)), 1);
        settle_internal<T0, T1>(arg0, arg1, arg2, arg3);
        transfer_to_internal<T0, T1>(arg0, arg1, arg4, arg5, arg6);
        let v0 = AmountSettledEvent{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool : arg0.kernel_pool,
            user        : arg1,
            amount0     : arg2,
            amount1     : arg3,
        };
        0x2::event::emit<AmountSettledEvent>(v0);
        let v1 = TransferredToEvent{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            kernel_pool : arg0.kernel_pool,
            user        : arg1,
            amount0     : arg4,
            amount1     : arg5,
        };
        0x2::event::emit<TransferredToEvent>(v1);
    }

    fun transfer_to_internal<T0, T1>(arg0: &mut PeripheryPool<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance0, arg2), arg4), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance1, arg3), arg4), arg1);
    }

    // decompiled from Move bytecode v6
}

