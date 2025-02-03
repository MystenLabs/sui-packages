module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::transfer {
    struct Transfer {
        amount: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount,
        token_address: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        token_chain: u16,
        recipient: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        recipient_chain: u16,
        relayer_fee: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount,
    }

    public(friend) fun new(arg0: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount, arg1: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress, arg2: u16, arg3: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress, arg4: u16, arg5: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount) : Transfer {
        Transfer{
            amount          : arg0,
            token_address   : arg1,
            token_chain     : arg2,
            recipient       : arg3,
            recipient_chain : arg4,
            relayer_fee     : arg5,
        }
    }

    public(friend) fun deserialize(arg0: vector<u8>) : Transfer {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::new<u8>(arg0);
        assert!(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u8(&mut v0) == 1, 0);
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::destroy_empty<u8>(v0);
        Transfer{
            amount          : 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::take_bytes(&mut v0),
            token_address   : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::take_bytes(&mut v0),
            token_chain     : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u16_be(&mut v0),
            recipient       : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::take_bytes(&mut v0),
            recipient_chain : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::take_u16_be(&mut v0),
            relayer_fee     : 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::take_bytes(&mut v0),
        }
    }

    public(friend) fun serialize(arg0: Transfer) : vector<u8> {
        let (v0, v1, v2, v3, v4, v5) = unpack(arg0);
        let v6 = 0x1::vector::empty<u8>();
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u8(&mut v6, 1);
        0x1::vector::append<u8>(&mut v6, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::to_bytes(v0));
        0x1::vector::append<u8>(&mut v6, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::to_bytes(v1));
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u16_be(&mut v6, v2);
        0x1::vector::append<u8>(&mut v6, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::to_bytes(v3));
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes::push_u16_be(&mut v6, v4);
        0x1::vector::append<u8>(&mut v6, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::to_bytes(v5));
        v6
    }

    public(friend) fun unpack(arg0: Transfer) : (0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress, u16, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress, u16, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::NormalizedAmount) {
        let Transfer {
            amount          : v0,
            token_address   : v1,
            token_chain     : v2,
            recipient       : v3,
            recipient_chain : v4,
            relayer_fee     : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    // decompiled from Move bytecode v6
}

