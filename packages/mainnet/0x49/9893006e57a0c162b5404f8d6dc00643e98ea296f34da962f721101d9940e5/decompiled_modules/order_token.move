module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token {
    struct OrderToken has copy, drop {
        token_type: 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::OrderTokenType,
        token_address: address,
        token_id: u256,
        token_amount: u256,
    }

    public(friend) fun to_bytes(arg0: &OrderToken) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::get_discriminant(&arg0.token_type));
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_address));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0.token_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0.token_amount));
        v0
    }

    public(friend) fun from_u256_vector(arg0: vector<u256>) : OrderToken {
        OrderToken{
            token_type    : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::from_discriminant((*0x1::vector::borrow<u256>(&arg0, 0) as u8)),
            token_address : 0x2::address::from_u256(*0x1::vector::borrow<u256>(&arg0, 1)),
            token_id      : *0x1::vector::borrow<u256>(&arg0, 2),
            token_amount  : *0x1::vector::borrow<u256>(&arg0, 3),
        }
    }

    public(friend) fun new(arg0: 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::OrderTokenType, arg1: address, arg2: u256, arg3: u256) : OrderToken {
        OrderToken{
            token_type    : arg0,
            token_address : arg1,
            token_id      : arg2,
            token_amount  : arg3,
        }
    }

    public(friend) fun read_order_type_vector_from_abi_reader(arg0: &mut 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::AbiReader) : vector<OrderToken> {
        let v0 = 0x1::vector::empty<OrderToken>();
        let v1 = 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_vector_fixed_length_type(arg0, 4);
        0x1::vector::reverse<vector<u256>>(&mut v1);
        while (0x1::vector::length<vector<u256>>(&v1) != 0) {
            0x1::vector::push_back<OrderToken>(&mut v0, from_u256_vector(0x1::vector::pop_back<vector<u256>>(&mut v1)));
        };
        0x1::vector::destroy_empty<vector<u256>>(v1);
        v0
    }

    public(friend) fun write_order_type_vector_in_abi_writer(arg0: vector<OrderToken>, arg1: &mut 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::AbiWriter) {
        let v0 = vector[];
        0x1::vector::reverse<OrderToken>(&mut arg0);
        while (0x1::vector::length<OrderToken>(&arg0) != 0) {
            let v1 = 0x1::vector::pop_back<OrderToken>(&mut arg0);
            0x1::vector::push_back<vector<u8>>(&mut v0, to_bytes(&v1));
        };
        0x1::vector::destroy_empty<OrderToken>(arg0);
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_vector_bytes(arg1, v0);
    }

    // decompiled from Move bytecode v6
}

