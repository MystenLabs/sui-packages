module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta {
    struct AssetMeta {
        token_address: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        token_chain: u16,
        native_decimals: u8,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : AssetMeta {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::new<u8>(arg0);
        assert!(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u8(&mut v0) == 2, 0);
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::destroy_empty<u8>(v0);
        AssetMeta{
            token_address   : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::take_bytes(&mut v0),
            token_chain     : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u16_be(&mut v0),
            native_decimals : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u8(&mut v0),
            symbol          : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_utf8(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::take_bytes(&mut v0)),
            name            : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_utf8(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::take_bytes(&mut v0)),
        }
    }

    public(friend) fun from_metadata<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : AssetMeta {
        AssetMeta{
            token_address   : 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::canonical_address<T0>(arg0),
            token_chain     : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::chain_id(),
            native_decimals : 0x2::coin::get_decimals<T0>(arg0),
            symbol          : 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg0)),
            name            : 0x2::coin::get_name<T0>(arg0),
        }
    }

    public(friend) fun serialize(arg0: AssetMeta) : vector<u8> {
        let (v0, v1, v2, v3, v4) = unpack(arg0);
        let v5 = 0x1::vector::empty<u8>();
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u8(&mut v5, 2);
        0x1::vector::append<u8>(&mut v5, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::to_bytes(v0));
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u16_be(&mut v5, v1);
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u8(&mut v5, v2);
        0x1::vector::append<u8>(&mut v5, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_bytes(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::from_utf8(v3)));
        0x1::vector::append<u8>(&mut v5, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_bytes(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::from_utf8(v4)));
        v5
    }

    public fun token_address(arg0: &AssetMeta) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        arg0.token_address
    }

    public fun token_chain(arg0: &AssetMeta) : u16 {
        arg0.token_chain
    }

    public(friend) fun unpack(arg0: AssetMeta) : (0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress, u16, u8, 0x1::string::String, 0x1::string::String) {
        let AssetMeta {
            token_address   : v0,
            token_chain     : v1,
            native_decimals : v2,
            symbol          : v3,
            name            : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v6
}

