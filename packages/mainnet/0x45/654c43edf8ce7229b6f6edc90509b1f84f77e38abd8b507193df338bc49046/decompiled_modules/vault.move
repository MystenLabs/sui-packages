module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::vault {
    struct TaliseVault has key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        deposits_total: u64,
        auto_swaps_total: u64,
    }

    struct SwapTicket {
        vault_id: 0x2::object::ID,
        from_type: vector<u8>,
        from_amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct VaultDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
        from: address,
    }

    struct VaultWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
        to: address,
    }

    struct VaultAutoSwap has copy, drop {
        vault_id: 0x2::object::ID,
        from_type: vector<u8>,
        to_type: vector<u8>,
        from_amount: u64,
        to_amount: u64,
        ts_ms: u64,
    }

    public fun auto_swap_deposit<T0>(arg0: &mut TaliseVault, arg1: 0x2::balance::Balance<T0>, arg2: SwapTicket, arg3: &0x2::clock::Clock) {
        let SwapTicket {
            vault_id    : v0,
            from_type   : v1,
            from_amount : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<TaliseVault>(arg0), 204);
        let v3 = 0x2::balance::value<T0>(&arg1);
        if (v3 > 0) {
            let v4 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
            if (0x2::bag::contains<vector<u8>>(&arg0.balances, v4)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v4), arg1);
            } else {
                0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v4, arg1);
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        arg0.auto_swaps_total = arg0.auto_swaps_total + 1;
        let v5 = VaultAutoSwap{
            vault_id    : 0x2::object::id<TaliseVault>(arg0),
            from_type   : v1,
            to_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            from_amount : v2,
            to_amount   : v3,
            ts_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultAutoSwap>(v5);
    }

    public fun auto_swap_extract<T0>(arg0: &mut TaliseVault, arg1: &mut 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::AutoSwapRegistry, arg2: &0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::AutoSwapCap<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, SwapTicket) {
        assert!(0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::cap_vault<T0>(arg2) == 0x2::object::id<TaliseVault>(arg0), 204);
        assert!(arg3 > 0, 202);
        0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::validate_for_swap<T0>(arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5);
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        assert!(0x2::bag::contains<vector<u8>>(&arg0.balances, v0), 203);
        let v1 = 0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg3, 201);
        let v2 = 0x2::balance::split<T0>(v1, arg3);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0));
        };
        let v3 = SwapTicket{
            vault_id    : 0x2::object::id<TaliseVault>(arg0),
            from_type   : v0,
            from_amount : arg3,
        };
        (v2, v3)
    }

    public fun auto_swaps_total(arg0: &TaliseVault) : u64 {
        arg0.auto_swaps_total
    }

    public fun balance_of<T0>(arg0: &TaliseVault) : u64 {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<vector<u8>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TaliseVault{
            id               : 0x2::object::new(arg0),
            owner            : 0x2::tx_context::sender(arg0),
            balances         : 0x2::bag::new(arg0),
            deposits_total   : 0,
            auto_swaps_total : 0,
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::id<TaliseVault>(&v0),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<TaliseVault>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut TaliseVault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 202);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut TaliseVault, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<vector<u8>>(&arg0.balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, arg1);
        };
        arg0.deposits_total = arg0.deposits_total + 1;
        let v2 = VaultDeposit{
            vault_id  : 0x2::object::id<TaliseVault>(arg0),
            coin_type : v1,
            amount    : v0,
            from      : arg2,
        };
        0x2::event::emit<VaultDeposit>(v2);
    }

    public fun deposits_total(arg0: &TaliseVault) : u64 {
        arg0.deposits_total
    }

    public entry fun enable_auto_swap<T0>(arg0: &TaliseVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 200);
        0x2::transfer::public_transfer<0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::AutoSwapCap<T0>>(0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap::mint_cap<T0>(0x2::object::id<TaliseVault>(arg0), arg0.owner, arg1, arg2, arg3), arg0.owner);
    }

    public fun owner(arg0: &TaliseVault) : address {
        arg0.owner
    }

    public entry fun receive_and_deposit<T0>(arg0: &mut TaliseVault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        assert!(0x2::coin::value<T0>(&v0) > 0, 202);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0), 0x2::tx_context::sender(arg2));
    }

    public fun type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun withdraw<T0>(arg0: &mut TaliseVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 200);
        assert!(arg1 > 0, 202);
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        assert!(0x2::bag::contains<vector<u8>>(&arg0.balances, v0), 203);
        let v1 = 0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 201);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0));
        };
        let v3 = VaultWithdraw{
            vault_id  : 0x2::object::id<TaliseVault>(arg0),
            coin_type : v0,
            amount    : arg1,
            to        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultWithdraw>(v3);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public entry fun withdraw_and_send<T0>(arg0: &mut TaliseVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

