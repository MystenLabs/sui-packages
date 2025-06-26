module 0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::mm_demo {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        quote_map: 0x2::table::Table<0x1::string::String, bool>,
    }

    public fun swap<T0, T1>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::confirmer::SwapCert<T0, T1>, arg6: &mut 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::fee_tier::FeeTier, arg7: &0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::confirmer::get_quote_id<T0, T1>(&arg5);
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(v1));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let (v2, v3) = verify_internal(v0, &arg4);
        assert!(v3 == arg0.owner, err_no_flash_permission());
        assert!(v2, err_signature());
        assert!(0x2::clock::timestamp_ms(arg8) / 1000 <= arg3, err_expired());
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.quote_map, v1), err_quote_id_used());
        let v4 = 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::confirmer::take_input_coin<T0, T1>(&mut arg5, arg7);
        assert!(0x2::coin::value<T0>(&v4) == arg1, err_incorrect_amount_in());
        let v5 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v5)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v5), v4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.balances, v5, v4);
        };
        let v6 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v6), err_insufficient_balance());
        let v7 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.balances, v6);
        assert!(0x2::coin::value<T1>(v7) > arg2, err_insufficient_balance());
        0x2::table::add<0x1::string::String, bool>(&mut arg0.quote_map, v1, true);
        0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::confirmer::destroy_swap_cert<T0, T1>(arg5, arg6, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(v7), arg2), arg7, arg9);
    }

    public entry fun deposit<T0>(arg0: &0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::versioned::Versioned, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) {
        0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::versioned::check_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.balances, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.balances, v0, arg2);
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

    fun err_quote_id_used() : u64 {
        abort 8
    }

    fun err_scheme_not_support() : u64 {
        abort 2
    }

    fun err_signature() : u64 {
        abort 4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            balances  : 0x2::bag::new(arg0),
            quote_map : 0x2::table::new<0x1::string::String, bool>(arg0),
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
        if (0x1::string::length(arg1) < 97) {
            let v0 = x"00";
            return (false, 0x2::address::from_bytes(0x2::hash::blake2b256(&v0)))
        };
        let (v1, v2, v3) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg1)));
        let v4 = v3;
        let v5 = v2;
        (0x2::ed25519::ed25519_verify(&v4, &v5, &arg0), v1)
    }

    public entry fun withdraw<T0>(arg0: &0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::versioned::Versioned, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::versioned::check_version(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), err_no_withdraw_permission());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.balances, v0);
            let v2 = if (0x2::coin::value<T0>(v1) > arg2) {
                arg2
            } else {
                0x2::coin::value<T0>(v1)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2, arg3), arg1.owner);
        };
    }

    // decompiled from Move bytecode v6
}

