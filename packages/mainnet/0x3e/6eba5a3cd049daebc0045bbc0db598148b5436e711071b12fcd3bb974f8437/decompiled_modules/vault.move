module 0x3e6eba5a3cd049daebc0045bbc0db598148b5436e711071b12fcd3bb974f8437::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        extra: 0x2::bag::Bag,
        positions: 0x2::object_bag::ObjectBag,
        target_a: u64,
        target_b: u64,
        unlock_time_ms: u64,
        unlocked: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultUnlocked has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        asset: u8,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        asset: u8,
        amount: u64,
    }

    struct SwapExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        remaining_in: u64,
    }

    struct PositionOpened has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct LiquidityAdded has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        amount_a: u64,
        amount_b: u64,
    }

    struct PositionClosed has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        amount_a: u64,
        amount_b: u64,
    }

    public fun destroy_empty<T0, T1>(arg0: Vault<T0, T1>, arg1: OwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(&arg0), 0);
        let Vault {
            id             : v0,
            balance_a      : v1,
            balance_b      : v2,
            extra          : v3,
            positions      : v4,
            target_a       : _,
            target_b       : _,
            unlock_time_ms : _,
            unlocked       : _,
        } = arg0;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        let v12 = v1;
        assert!(0x2::balance::value<T0>(&v12) == 0, 4);
        assert!(0x2::balance::value<T1>(&v11) == 0, 4);
        assert!(0x2::bag::is_empty(&v10), 4);
        assert!(0x2::object_bag::is_empty(&v9), 4);
        0x2::balance::destroy_zero<T0>(v12);
        0x2::balance::destroy_zero<T1>(v11);
        0x2::bag::destroy_empty(v10);
        0x2::object_bag::destroy_empty(v9);
        0x2::object::delete(v0);
        let OwnerCap {
            id       : v13,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v13);
    }

    public fun add_liquidity_to_position<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg4), 6);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::take<T0>(&mut arg0.balance_a, arg5, arg12));
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::take<T1>(&mut arg0.balance_b, arg6, arg12));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg2, arg3, v0, v1, 0x2::object_bag::borrow_mut<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v2));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v3));
        let v4 = LiquidityAdded{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            name     : arg4,
        };
        0x2::event::emit<LiquidityAdded>(v4);
    }

    public fun balance_a<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a)
    }

    public fun balance_b<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_b)
    }

    public fun close_lp_position<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg4), 6);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(0x2::object_bag::borrow<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.positions, arg4));
        let (_, _, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_to_address(&v0));
        let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, 0x2::object_bag::borrow_mut<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4), v3, arg5, arg6, arg7, arg8, arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg2, arg3, 0x2::object_bag::borrow_mut<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4), 18446744073709551615, 18446744073709551615, 0x2::object::uid_to_address(&arg0.id), arg7, arg8, arg9, arg10);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v7));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v6));
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v11));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v10));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg3, 0x2::object_bag::remove<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4), arg9, arg10);
        let v12 = PositionClosed{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            name     : arg4,
            amount_a : 0x2::coin::value<T0>(&v7) + 0x2::coin::value<T0>(&v11),
            amount_b : 0x2::coin::value<T1>(&v6) + 0x2::coin::value<T1>(&v10),
        };
        0x2::event::emit<PositionClosed>(v12);
    }

    public fun collect_lp_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg4), 6);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg2, arg3, 0x2::object_bag::borrow_mut<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4), 18446744073709551615, 18446744073709551615, 0x2::object::uid_to_address(&arg0.id), arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v3));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v2));
        let v4 = FeesCollected{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            name     : arg4,
            amount_a : 0x2::coin::value<T0>(&v3),
            amount_b : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<FeesCollected>(v4);
    }

    public fun create<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1>{
            id             : 0x2::object::new(arg3),
            balance_a      : 0x2::balance::zero<T0>(),
            balance_b      : 0x2::balance::zero<T1>(),
            extra          : 0x2::bag::new(arg3),
            positions      : 0x2::object_bag::new(arg3),
            target_a       : arg1,
            target_b       : arg2,
            unlock_time_ms : arg0,
            unlocked       : false,
        };
        let v1 = OwnerCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v0),
        };
        let v2 = VaultCreated{vault_id: 0x2::object::id<Vault<T0, T1>>(&v0)};
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun deposit_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 0,
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun deposit_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        let v0 = Deposited{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 1,
            amount   : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun deposit_extra<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.extra, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v0), 0x2::coin::into_balance<T2>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v0, 0x2::coin::into_balance<T2>(arg1));
        };
        let v1 = Deposited{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 2,
            amount   : 0x2::coin::value<T2>(&arg1),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x1::string::String) : bool {
        0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg1)
    }

    public fun is_unlocked<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.unlocked
    }

    public fun open_lp_position<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x1::string::String, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(!0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg4), 5);
        assert!(arg11 > 0 || arg12 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::take<T0>(&mut arg0.balance_a, arg9, arg16));
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::take<T1>(&mut arg0.balance_b, arg10, arg16));
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg2, arg3, v0, v1, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v3));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v4));
        0x2::object_bag::add<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg4, v2);
        let v5 = PositionOpened{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            name     : arg4,
        };
        0x2::event::emit<PositionOpened>(v5);
    }

    fun refresh_unlock<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        if (arg0.unlocked) {
            return
        };
        let v0 = if (0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time_ms) {
            true
        } else if (arg0.target_a > 0 && 0x2::balance::value<T0>(&arg0.balance_a) >= arg0.target_a) {
            true
        } else {
            arg0.target_b > 0 && 0x2::balance::value<T1>(&arg0.balance_b) >= arg0.target_b
        };
        if (v0) {
            arg0.unlocked = true;
            let v1 = VaultUnlocked{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
            0x2::event::emit<VaultUnlocked>(v1);
        };
    }

    public fun swap_a_to_b<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::take<T0>(&mut arg0.balance_a, arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v4));
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v3));
        let v5 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T1>(&v4),
            remaining_in : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v5);
    }

    public fun swap_a_to_extra<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T3>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::take<T0>(&mut arg0.balance_a, arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T2, T3>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v3));
        let v5 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.extra, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5), 0x2::coin::into_balance<T2>(v4));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5, 0x2::coin::into_balance<T2>(v4));
        };
        let v6 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T2>(&v4),
            remaining_in : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v6);
    }

    public fun swap_b_to_a<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::take<T1>(&mut arg0.balance_b, arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v4));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v3));
        let v5 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T0>(&v4),
            remaining_in : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v5);
    }

    public fun swap_b_to_extra<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::take<T1>(&mut arg0.balance_b, arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T1, T2, T3>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v3));
        let v5 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.extra, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5), 0x2::coin::into_balance<T2>(v4));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5, 0x2::coin::into_balance<T2>(v4));
        };
        let v6 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T2>(&v4),
            remaining_in : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v6);
    }

    public fun swap_extra_to_a<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T3>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, 0x2::coin::take<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T0, T3>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(v3));
        let v5 = 0x1::type_name::get<T2>();
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.extra, v5)) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5));
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(v4));
        let v6 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T0>(&v4),
            remaining_in : 0x2::coin::value<T2>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v6);
    }

    public fun swap_extra_to_b<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T3>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, 0x2::coin::take<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T1, T3>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(v3));
        let v5 = 0x1::type_name::get<T2>();
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.extra, v5)) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5));
        };
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(v4));
        let v6 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T1>(&v4),
            remaining_in : 0x2::coin::value<T2>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v6);
    }

    public fun swap_extra_to_extra<T0, T1, T2, T3, T4>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        assert!(arg4 > 0, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, 0x2::coin::take<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), arg3, arg9));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg2, v0, arg3, arg4, arg5, true, 0x2::object::uid_to_address(&arg0.id), arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, 0x1::type_name::get<T2>()), 0x2::coin::into_balance<T2>(v3));
        let v5 = 0x1::type_name::get<T2>();
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.extra, v5)) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v5));
        };
        let v6 = 0x1::type_name::get<T3>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.extra, v6)) {
            0x2::balance::join<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.extra, v6), 0x2::coin::into_balance<T3>(v4));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.extra, v6, 0x2::coin::into_balance<T3>(v4));
        };
        let v7 = SwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount_in    : arg3,
            amount_out   : 0x2::coin::value<T3>(&v4),
            remaining_in : 0x2::coin::value<T2>(&v3),
        };
        0x2::event::emit<SwapExecuted>(v7);
    }

    public fun target_a<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.target_a
    }

    public fun target_b<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.target_b
    }

    public fun try_unlock<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        refresh_unlock<T0, T1>(arg0, arg1);
    }

    public fun unlock_time_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.unlock_time_ms
    }

    public fun withdraw_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        refresh_unlock<T0, T1>(arg0, arg3);
        assert!(arg0.unlocked, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) >= arg2, 2);
        let v0 = Withdrawn{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 0,
            amount   : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::take<T0>(&mut arg0.balance_a, arg2, arg4)
    }

    public fun withdraw_all_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        withdraw_a<T0, T1>(arg0, arg1, v0, arg2, arg3)
    }

    public fun withdraw_all_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<T1>(&arg0.balance_b);
        withdraw_b<T0, T1>(arg0, arg1, v0, arg2, arg3)
    }

    public fun withdraw_all_extra<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.extra, 0x1::type_name::get<T2>()));
        withdraw_extra<T0, T1, T2>(arg0, arg1, v0, arg2, arg3)
    }

    public fun withdraw_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        refresh_unlock<T0, T1>(arg0, arg3);
        assert!(arg0.unlocked, 1);
        assert!(0x2::balance::value<T1>(&arg0.balance_b) >= arg2, 2);
        let v0 = Withdrawn{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 1,
            amount   : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::take<T1>(&mut arg0.balance_b, arg2, arg4)
    }

    public fun withdraw_extra<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        refresh_unlock<T0, T1>(arg0, arg3);
        assert!(arg0.unlocked, 1);
        let v0 = 0x1::type_name::get<T2>();
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v0);
        assert!(0x2::balance::value<T2>(v1) >= arg2, 2);
        let v2 = 0x2::coin::take<T2>(v1, arg2, arg4);
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.extra, v0)) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.extra, v0));
        };
        let v3 = Withdrawn{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            asset    : 2,
            amount   : arg2,
        };
        0x2::event::emit<Withdrawn>(v3);
        v2
    }

    public fun withdraw_position_nft<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0);
        refresh_unlock<T0, T1>(arg0, arg3);
        assert!(arg0.unlocked, 1);
        assert!(0x2::object_bag::contains<0x1::string::String>(&arg0.positions, arg2), 6);
        0x2::transfer::public_transfer<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(0x2::object_bag::remove<0x1::string::String, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.positions, arg2), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

