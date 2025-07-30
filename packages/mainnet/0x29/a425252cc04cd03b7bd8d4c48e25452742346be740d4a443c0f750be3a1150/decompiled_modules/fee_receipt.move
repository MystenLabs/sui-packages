module 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_receipt {
    struct FeeReceiptIssued has copy, drop {
        source: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct FeeReceiptConsumed has copy, drop {
        source: 0x1::ascii::String,
        amount: u64,
        fee_coin_type: 0x1::ascii::String,
    }

    public fun consume_fee_receipt<T0>(arg0: 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt, arg1: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::FeeReceiptAcl, arg2: &mut 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_distributor::FeeDistributor, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::Access>(&mut arg0, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::access(arg1), b"distributor_fee");
        let v1 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x1::ascii::String, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::Access>(&mut arg0, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::access(arg1), b"distributor_source");
        let v2 = 0x2::balance::value<T0>(&v0);
        assert!(v2 > 0, 0);
        0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_distributor::add_fees<T0>(v1, arg2, v0, arg3);
        let v3 = FeeReceiptConsumed{
            source        : v1,
            amount        : v2,
            fee_coin_type : get_coin_type_key<T0>(),
        };
        0x2::event::emit<FeeReceiptConsumed>(v3);
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::burn(arg0);
    }

    fun get_coin_type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun issue_fee_receipt_with_coins<T0, T1>(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::FeeReceiptAcl, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = get_coin_type_key<T1>();
        let v2 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::issue<0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::Access>(0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::access(arg0), 0x1::option::none<0x2::object::ID>(), arg2);
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::Access>(&mut v2, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::access(arg0), b"distributor_fee", arg1);
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x1::ascii::String, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::Access>(&mut v2, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::access(arg0), b"distributor_source", v1);
        let v3 = FeeReceiptIssued{
            source    : v1,
            coin_type : get_coin_type_key<T0>(),
            amount    : v0,
        };
        0x2::event::emit<FeeReceiptIssued>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

