module 0x387ba883f1501d57f8757318347c0fc862183a807414cfdc6316688571e93d17::mm_demo {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
    }

    struct FlashSwapCert<phantom T0, phantom T1> {
        loan_amount: u64,
        repay_amount: u64,
        expired_at: u64,
    }

    struct SwapEvent has copy, drop, store {
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    public fun swap<T0, T1>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::confirmer::SwapCert<T0, T1>, arg6: &mut 0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::fee_tier::FeeTier, arg7: &0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let (v1, v2) = verify_internal(v0, &arg4);
        assert!(v2 == arg0.owner, err_no_flash_permission());
        assert!(v1, err_signature());
        assert!(0x2::clock::timestamp_ms(arg8) / 1000 <= arg3, err_expired());
        let v3 = 0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::confirmer::take_input_coin<T0, T1>(&mut arg5, arg7);
        assert!(0x2::coin::value<T0>(&v3) == arg1, err_incorrect_amount_in());
        let v4 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v4)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v4), v3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v4, v3);
        };
        let v5 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v5), err_insufficient_balance());
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.balances, v5);
        assert!(0x2::coin::value<T1>(v6) > arg2, err_insufficient_balance());
        0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::confirmer::destory_swap_cert<T0, T1>(arg5, arg6, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(v6), arg2), arg7, arg9);
    }

    public fun destory_swap_cert<T0, T1>(arg0: FlashSwapCert<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut Vault, arg3: &0x2::clock::Clock) {
        let FlashSwapCert {
            loan_amount  : v0,
            repay_amount : v1,
            expired_at   : v2,
        } = arg0;
        assert!(0x2::coin::value<T1>(&arg1) == v1, err_insufficient_balance());
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 <= v2, err_expired());
        let v3 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg2.balances, v3)) {
            0x2::coin::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.balances, v3), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.balances, v3, arg1);
        };
        let v4 = SwapEvent{
            from       : 0x1::type_name::get<T1>(),
            target     : 0x1::type_name::get<T0>(),
            amount_in  : v0,
            amount_out : v1,
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun err_expired() : u64 {
        abort 6
    }

    fun err_incorrect_amount_in() : u64 {
        abort 7
    }

    fun err_insufficient_balance() : u64 {
        abort 5
    }

    fun err_no_flash_permission() : u64 {
        abort 3
    }

    fun err_no_withdraw_permission() : u64 {
        abort 1
    }

    fun err_scheme_not_support() : u64 {
        abort 2
    }

    fun err_signature() : u64 {
        abort 4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, err_scheme_not_support());
        let v0 = x"00";
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = 1;
        while (v3 < v2) {
            if (v3 <= v2 - 32 - 1) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v3));
            } else {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v3));
            };
            v3 = v3 + 1;
        };
        0x1::vector::remove<u8>(&mut v0, 0);
        (0x2::address::from_bytes(0x2::hash::blake2b256(&v0)), v0, v1)
    }

    fun verify_internal(arg0: vector<u8>, arg1: &0x1::string::String) : (bool, address) {
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg1)));
        let v3 = v2;
        let v4 = v1;
        (0x2::ed25519::ed25519_verify(&v3, &v4, &arg0), v0)
    }

    public entry fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), err_no_withdraw_permission());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v0);
            let v2 = if (0x2::coin::value<T0>(v1) > arg1) {
                arg1
            } else {
                0x2::coin::value<T0>(v1)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2, arg2), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

