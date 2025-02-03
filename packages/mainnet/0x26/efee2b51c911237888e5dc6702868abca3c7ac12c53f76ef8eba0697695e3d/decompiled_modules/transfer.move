module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer {
    struct Transfer {
        amount: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount,
        token_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        token_chain: u16,
        recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        recipient_chain: u16,
        relayer_fee: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : Transfer {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        Transfer{
            amount          : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::take_bytes(&mut v0),
            token_address   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0),
            token_chain     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            recipient       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0),
            recipient_chain : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            relayer_fee     : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::take_bytes(&mut v0),
        }
    }

    public(friend) fun new(arg0: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: u16, arg5: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount) : Transfer {
        Transfer{
            amount          : arg0,
            token_address   : arg1,
            token_chain     : arg2,
            recipient       : arg3,
            recipient_chain : arg4,
            relayer_fee     : arg5,
        }
    }

    public(friend) fun serialize(arg0: Transfer) : vector<u8> {
        let (v0, v1, v2, v3, v4, v5) = unpack(arg0);
        let v6 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v6, 1);
        0x1::vector::append<u8>(&mut v6, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_bytes(v0));
        0x1::vector::append<u8>(&mut v6, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v6, v2);
        0x1::vector::append<u8>(&mut v6, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v3));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v6, v4);
        0x1::vector::append<u8>(&mut v6, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_bytes(v5));
        v6
    }

    public(friend) fun unpack(arg0: Transfer) : (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, u16, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount) {
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

