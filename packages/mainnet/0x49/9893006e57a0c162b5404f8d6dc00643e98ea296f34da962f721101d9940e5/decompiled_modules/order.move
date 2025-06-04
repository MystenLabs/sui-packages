module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order {
    struct Order has copy, drop {
        user: address,
        recipient: address,
        filler: address,
        inputs: vector<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>,
        outputs: vector<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>,
        source_chain_id: u32,
        destination_chain_id: u32,
        sponsored: bool,
        primary_filler_deadline: u64,
        deadline: u64,
        call_recipient: address,
        call_data: vector<u8>,
        call_value: u256,
    }

    public(friend) fun from_abi_reader(arg0: &mut 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::AbiReader) : Order {
        let v0 = 0x2::address::from_u256(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0));
        0x1::debug::print<address>(&v0);
        Order{
            user                    : 0x2::address::from_u256(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0)),
            recipient               : 0x2::address::from_u256(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0)),
            filler                  : v0,
            inputs                  : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::read_order_type_vector_from_abi_reader(arg0),
            outputs                 : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::read_order_type_vector_from_abi_reader(arg0),
            source_chain_id         : (0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0) as u32),
            destination_chain_id    : (0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0) as u32),
            sponsored               : (0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0) as u8) != 0,
            primary_filler_deadline : (0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0) as u64),
            deadline                : (0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0) as u64),
            call_recipient          : 0x2::address::from_u256(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0)),
            call_data               : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_bytes(arg0),
            call_value              : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::read_u256(arg0),
        }
    }

    public(friend) fun test_create_dummy_order(arg0: address, arg1: address, arg2: address) : Order {
        let v0 = 0x1::vector::empty<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>(v1, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::new(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::new_fungible_token(), arg0, 123456, 10));
        0x1::vector::push_back<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>(v1, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::new(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::new_native(), arg1, 789, 20));
        let v2 = 0x1::vector::empty<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>(v3, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::new(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::new_non_fungible_token(), arg0, 1, 100));
        0x1::vector::push_back<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>(v3, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::new(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::new_semi_fungible_token(), arg1, 22, 200));
        0x1::vector::push_back<0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::OrderToken>(v3, 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::new(0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token_type::new_native(), arg2, 333, 300));
        Order{
            user                    : arg0,
            recipient               : arg1,
            filler                  : arg2,
            inputs                  : v0,
            outputs                 : v2,
            source_chain_id         : 101,
            destination_chain_id    : 1000,
            sponsored               : true,
            primary_filler_deadline : 800,
            deadline                : 2000,
            call_recipient          : arg0,
            call_data               : x"0a141e",
            call_value              : 1000000000000000000,
        }
    }

    public(friend) fun write_in_abi_writer(arg0: &Order, arg1: &mut 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::AbiWriter) {
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, 0x2::address::to_u256(arg0.user));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, 0x2::address::to_u256(arg0.recipient));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, 0x2::address::to_u256(arg0.filler));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::write_order_type_vector_in_abi_writer(arg0.inputs, arg1);
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::order_token::write_order_type_vector_in_abi_writer(arg0.outputs, arg1);
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, (arg0.source_chain_id as u256));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, (arg0.destination_chain_id as u256));
        let v0 = if (arg0.sponsored) {
            1
        } else {
            0
        };
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, v0);
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, (arg0.primary_filler_deadline as u256));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, (arg0.deadline as u256));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, 0x2::address::to_u256(arg0.call_recipient));
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_bytes(arg1, arg0.call_data);
        0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::abi::write_u256(arg1, (arg0.call_value as u256));
    }

    // decompiled from Move bytecode v6
}

