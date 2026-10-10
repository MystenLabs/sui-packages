module 0xe054c53d3db26c750dc583f3877e5e4ca334c4f7b7dc7c5238dbefccdd1885a5::bridge_payload {
    struct BridgePayload has copy, drop, store {
        payload_type: u8,
        addr_dest: address,
        gas_drop: u64,
        fee_redeem: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        custom_payload_hash: address,
    }

    public(friend) fun serialize(arg0: &BridgePayload) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0.payload_type);
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.addr_dest));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.gas_drop));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u64_be(arg0.fee_redeem));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.addr_ref));
        0x1::vector::push_back<u8>(&mut v0, arg0.fee_rate_ref);
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.custom_payload_hash));
        assert!(0x1::vector::length<u8>(&v0) == 114, 0);
        v0
    }

    public fun addr_dest(arg0: &BridgePayload) : address {
        arg0.addr_dest
    }

    public fun addr_ref(arg0: &BridgePayload) : address {
        arg0.addr_ref
    }

    public fun bridge_payload_len() : u64 {
        114
    }

    public fun custom_payload_hash(arg0: &BridgePayload) : address {
        arg0.custom_payload_hash
    }

    public fun fee_rate_ref(arg0: &BridgePayload) : u8 {
        arg0.fee_rate_ref
    }

    public fun fee_redeem(arg0: &BridgePayload) : u64 {
        arg0.fee_redeem
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : BridgePayload {
        assert!(0x1::vector::length<u8>(arg0) == 114, 0);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        assert!(is_bridge_payload_type(v0), 1);
        BridgePayload{
            payload_type        : v0,
            addr_dest           : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 1, 32),
            gas_drop            : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 33, 8),
            fee_redeem          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u64_be(arg0, 41, 8),
            addr_ref            : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 49, 32),
            fee_rate_ref        : *0x1::vector::borrow<u8>(arg0, 81),
            custom_payload_hash : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 82, 32),
        }
    }

    public fun gas_drop(arg0: &BridgePayload) : u64 {
        arg0.gas_drop
    }

    public fun is_bridge_payload_type(arg0: u8) : bool {
        arg0 == 1 || arg0 == 2
    }

    public(friend) fun new(arg0: u8, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: u8, arg6: address) : BridgePayload {
        assert!(is_bridge_payload_type(arg0), 1);
        BridgePayload{
            payload_type        : arg0,
            addr_dest           : arg1,
            gas_drop            : arg2,
            fee_redeem          : arg3,
            addr_ref            : arg4,
            fee_rate_ref        : arg5,
            custom_payload_hash : arg6,
        }
    }

    public fun payload_type(arg0: &BridgePayload) : u8 {
        arg0.payload_type
    }

    public fun payload_type_custom() : u8 {
        2
    }

    public fun payload_type_default() : u8 {
        1
    }

    public(friend) fun unpack(arg0: BridgePayload) : (u8, address, u64, u64, address, u8, address) {
        let BridgePayload {
            payload_type        : v0,
            addr_dest           : v1,
            gas_drop            : v2,
            fee_redeem          : v3,
            addr_ref            : v4,
            fee_rate_ref        : v5,
            custom_payload_hash : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    // decompiled from Move bytecode v7
}

