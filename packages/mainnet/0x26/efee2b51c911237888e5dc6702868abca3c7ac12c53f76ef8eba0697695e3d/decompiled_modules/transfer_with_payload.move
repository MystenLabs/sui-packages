module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload {
    struct TransferWithPayload has drop {
        amount: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount,
        token_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        token_chain: u16,
        redeemer: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        redeemer_chain: u16,
        sender: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        payload: vector<u8>,
    }

    public fun amount(arg0: &TransferWithPayload) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount {
        arg0.amount
    }

    public fun deserialize(arg0: vector<u8>) : TransferWithPayload {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 3, 0);
        TransferWithPayload{
            amount         : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::take_bytes(&mut v0),
            token_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0),
            token_chain    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            redeemer       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0),
            redeemer_chain : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            sender         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0),
            payload        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0),
        }
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg3: u16, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg5: u16, arg6: vector<u8>) : TransferWithPayload {
        TransferWithPayload{
            amount         : arg1,
            token_address  : arg2,
            token_chain    : arg3,
            redeemer       : arg4,
            redeemer_chain : arg5,
            sender         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_id(arg0),
            payload        : arg6,
        }
    }

    public fun payload(arg0: &TransferWithPayload) : vector<u8> {
        arg0.payload
    }

    public fun redeemer(arg0: &TransferWithPayload) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.redeemer
    }

    public fun redeemer_chain(arg0: &TransferWithPayload) : u16 {
        arg0.redeemer_chain
    }

    public fun redeemer_id(arg0: &TransferWithPayload) : 0x2::object::ID {
        0x2::object::id_from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.redeemer))
    }

    public fun sender(arg0: &TransferWithPayload) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.sender
    }

    public fun serialize(arg0: TransferWithPayload) : vector<u8> {
        let TransferWithPayload {
            amount         : v0,
            token_address  : v1,
            token_chain    : v2,
            redeemer       : v3,
            redeemer_chain : v4,
            sender         : v5,
            payload        : v6,
        } = arg0;
        let v7 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v7, 3);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u256_be(&mut v7, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_u256(v0));
        0x1::vector::append<u8>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v7, v2);
        0x1::vector::append<u8>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v3));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v7, v4);
        0x1::vector::append<u8>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v5));
        0x1::vector::append<u8>(&mut v7, v6);
        v7
    }

    public fun take_payload(arg0: TransferWithPayload) : vector<u8> {
        let TransferWithPayload {
            amount         : _,
            token_address  : _,
            token_chain    : _,
            redeemer       : _,
            redeemer_chain : _,
            sender         : _,
            payload        : v6,
        } = arg0;
        v6
    }

    public fun token_address(arg0: &TransferWithPayload) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.token_address
    }

    public fun token_chain(arg0: &TransferWithPayload) : u16 {
        arg0.token_chain
    }

    // decompiled from Move bytecode v6
}

