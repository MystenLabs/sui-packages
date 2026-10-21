module 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload {
    struct OrderPayload has copy, drop, store {
        payload_type: u8,
        addr_dest: address,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
    }

    public(friend) fun serialize(arg0: &OrderPayload) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0.payload_type);
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.addr_dest));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.token_out));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.amount_out_min));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.gas_drop));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.fee_redeem));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.fee_refund));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.deadline));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.addr_ref));
        0x1::vector::push_back<u8>(&mut v0, arg0.fee_rate_ref);
        assert!(0x1::vector::length<u8>(&v0) == 138, 0);
        v0
    }

    public fun addr_dest(arg0: &OrderPayload) : address {
        arg0.addr_dest
    }

    public fun addr_ref(arg0: &OrderPayload) : address {
        arg0.addr_ref
    }

    public fun amount_out_min(arg0: &OrderPayload) : u64 {
        arg0.amount_out_min
    }

    public fun deadline(arg0: &OrderPayload) : u64 {
        arg0.deadline
    }

    public fun fee_rate_ref(arg0: &OrderPayload) : u8 {
        arg0.fee_rate_ref
    }

    public fun fee_redeem(arg0: &OrderPayload) : u64 {
        arg0.fee_redeem
    }

    public fun fee_refund(arg0: &OrderPayload) : u64 {
        arg0.fee_refund
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : OrderPayload {
        assert!(0x1::vector::length<u8>(arg0) == 138, 0);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        assert!(is_order_payload_type(v0), 1);
        OrderPayload{
            payload_type   : v0,
            addr_dest      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 1, 32),
            token_out      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 33, 32),
            amount_out_min : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 65, 8),
            gas_drop       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 73, 8),
            fee_redeem     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 81, 8),
            fee_refund     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 89, 8),
            deadline       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 97, 8),
            addr_ref       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 105, 32),
            fee_rate_ref   : *0x1::vector::borrow<u8>(arg0, 137),
        }
    }

    public fun gas_drop(arg0: &OrderPayload) : u64 {
        arg0.gas_drop
    }

    public fun is_order_payload_type(arg0: u8) : bool {
        arg0 == 3
    }

    public(friend) fun new(arg0: u8, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: u8) : OrderPayload {
        assert!(is_order_payload_type(arg0), 1);
        OrderPayload{
            payload_type   : arg0,
            addr_dest      : arg1,
            token_out      : arg2,
            amount_out_min : arg3,
            gas_drop       : arg4,
            fee_redeem     : arg5,
            fee_refund     : arg6,
            deadline       : arg7,
            addr_ref       : arg8,
            fee_rate_ref   : arg9,
        }
    }

    public fun order_payload_len() : u64 {
        138
    }

    public fun payload_type(arg0: &OrderPayload) : u8 {
        arg0.payload_type
    }

    public fun payload_type_order() : u8 {
        3
    }

    public fun token_out(arg0: &OrderPayload) : address {
        arg0.token_out
    }

    public(friend) fun unpack(arg0: OrderPayload) : (u8, address, address, u64, u64, u64, u64, u64, address, u8) {
        let OrderPayload {
            payload_type   : v0,
            addr_dest      : v1,
            token_out      : v2,
            amount_out_min : v3,
            gas_drop       : v4,
            fee_redeem     : v5,
            fee_refund     : v6,
            deadline       : v7,
            addr_ref       : v8,
            fee_rate_ref   : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    // decompiled from Move bytecode v7
}

