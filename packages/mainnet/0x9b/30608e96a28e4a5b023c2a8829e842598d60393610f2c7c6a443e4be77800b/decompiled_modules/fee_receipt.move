module 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::fee_receipt {
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

    public fun consume_fee_receipt<T0>(arg0: 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::PermissionedReceipt, arg1: &0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::FeeReceiptAcl, arg2: &mut 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::fee_distributor::FeeDistributor, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::Access>(&mut arg0, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::access(arg1), b"distributor_fee");
        let v1 = 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<vector<u8>, 0x1::ascii::String, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::Access>(&mut arg0, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::access(arg1), b"distributor_source");
        let v2 = 0x2::balance::value<T0>(&v0);
        assert!(v2 > 0, 0);
        0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::fee_distributor::add_fees<T0>(v1, arg2, v0, arg3);
        let v3 = FeeReceiptConsumed{
            source        : v1,
            amount        : v2,
            fee_coin_type : get_coin_type_key<T0>(),
        };
        0x2::event::emit<FeeReceiptConsumed>(v3);
        0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::burn(arg0);
    }

    fun get_coin_type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun issue_fee_receipt_with_coins<T0, T1>(arg0: &0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::FeeReceiptAcl, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::PermissionedReceipt {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = get_coin_type_key<T1>();
        let v2 = 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::issue<0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::Access>(0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::access(arg0), 0x1::option::none<0x2::object::ID>(), arg2);
        0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::Access>(&mut v2, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::access(arg0), b"distributor_fee", arg1);
        0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::add_data<vector<u8>, 0x1::ascii::String, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::Access>(&mut v2, 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl::access(arg0), b"distributor_source", v1);
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

