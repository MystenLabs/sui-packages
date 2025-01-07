module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address {
    struct DolaAddress has copy, drop, store {
        dola_chain_id: u16,
        dola_address: vector<u8>,
    }

    public fun convert_address_to_dola(arg0: address) : DolaAddress {
        DolaAddress{
            dola_chain_id : 0,
            dola_address  : 0x2::bcs::to_bytes<address>(&arg0),
        }
    }

    public fun convert_dola_to_address(arg0: DolaAddress) : address {
        assert!(0x1::vector::length<u8>(&arg0.dola_address) == 32, 0);
        0x2::address::from_bytes(arg0.dola_address)
    }

    public fun convert_dola_to_pool(arg0: DolaAddress) : vector<u8> {
        arg0.dola_address
    }

    public fun convert_pool_to_dola<T0>() : DolaAddress {
        DolaAddress{
            dola_chain_id : 0,
            dola_address  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        }
    }

    public fun create_dola_address(arg0: u16, arg1: vector<u8>) : DolaAddress {
        DolaAddress{
            dola_chain_id : arg0,
            dola_address  : arg1,
        }
    }

    public fun decode_dola_address(arg0: vector<u8>) : DolaAddress {
        let v0 = 0;
        let v1 = 2;
        let v2 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::serde::vector_slice<u8>(&arg0, v0, v0 + v1);
        DolaAddress{
            dola_chain_id : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::serde::deserialize_u16(&v2),
            dola_address  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::serde::vector_slice<u8>(&arg0, v0 + v1, 0x1::vector::length<u8>(&arg0)),
        }
    }

    public fun encode_dola_address(arg0: DolaAddress) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::serde::serialize_u16(&mut v0, arg0.dola_chain_id);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::serde::serialize_vector(&mut v0, arg0.dola_address);
        v0
    }

    public fun get_dola_address(arg0: &DolaAddress) : vector<u8> {
        arg0.dola_address
    }

    public fun get_dola_chain_id(arg0: &DolaAddress) : u16 {
        arg0.dola_chain_id
    }

    public fun get_native_dola_chain_id() : u16 {
        0
    }

    public fun update_dola_address(arg0: DolaAddress, arg1: vector<u8>) : DolaAddress {
        arg0.dola_address = arg1;
        arg0
    }

    public fun update_dola_chain_id(arg0: DolaAddress, arg1: u16) : DolaAddress {
        arg0.dola_chain_id = arg1;
        arg0
    }

    // decompiled from Move bytecode v6
}

