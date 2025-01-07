module 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::governance_message {
    struct DecreeTicket<phantom T0> {
        governance_chain: u16,
        governance_contract: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress,
        module_name: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32,
        action: u8,
        global: bool,
    }

    struct DecreeReceipt<phantom T0> {
        payload: vector<u8>,
        digest: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32,
        sequence: u64,
    }

    public fun authorize_verify_global<T0: drop>(arg0: T0, arg1: u16, arg2: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress, arg3: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32, arg4: u8) : DecreeTicket<T0> {
        DecreeTicket<T0>{
            governance_chain    : arg1,
            governance_contract : arg2,
            module_name         : arg3,
            action              : arg4,
            global              : true,
        }
    }

    public fun authorize_verify_local<T0: drop>(arg0: T0, arg1: u16, arg2: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::external_address::ExternalAddress, arg3: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32, arg4: u8) : DecreeTicket<T0> {
        DecreeTicket<T0>{
            governance_chain    : arg1,
            governance_contract : arg2,
            module_name         : arg3,
            action              : arg4,
            global              : false,
        }
    }

    fun deserialize(arg0: vector<u8>) : (0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::Bytes32, u8, u16, vector<u8>) {
        let v0 = 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::cursor::new<u8>(arg0);
        (0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes32::take_bytes(&mut v0), 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes::take_u8(&mut v0), 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::bytes::take_u16_be(&mut v0), 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::cursor::take_rest<u8>(v0))
    }

    public fun destroy<T0>(arg0: DecreeReceipt<T0>) {
        let DecreeReceipt {
            payload  : _,
            digest   : _,
            sequence : _,
        } = arg0;
    }

    public fun payload<T0>(arg0: &DecreeReceipt<T0>) : vector<u8> {
        arg0.payload
    }

    public fun sequence<T0>(arg0: &DecreeReceipt<T0>) : u64 {
        arg0.sequence
    }

    public fun take_payload<T0>(arg0: &mut 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::ConsumedVAAs, arg1: DecreeReceipt<T0>) : vector<u8> {
        let DecreeReceipt {
            payload  : v0,
            digest   : v1,
            sequence : _,
        } = arg1;
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::consumed_vaas::consume(arg0, v1);
        v0
    }

    public fun verify_vaa<T0>(arg0: &0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::state::State, arg1: 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::VAA, arg2: DecreeTicket<T0>) : DecreeReceipt<T0> {
        0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::state::assert_latest_only(arg0);
        let DecreeTicket {
            governance_chain    : v0,
            governance_contract : v1,
            module_name         : v2,
            action              : v3,
            global              : v4,
        } = arg2;
        assert!(0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::guardian_set_index(&arg1) == 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::state::guardian_set_index(arg0), 0);
        assert!(0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::emitter_chain(&arg1) == v0, 1);
        assert!(0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::emitter_address(&arg1) == v1, 2);
        let (v5, v6, v7, v8) = deserialize(0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::take_payload(arg1));
        assert!(v2 == v5, 4);
        assert!(v3 == v6, 5);
        if (v4) {
            assert!(v7 == 0, 6);
        } else {
            assert!(v7 == 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::state::chain_id(), 7);
        };
        DecreeReceipt<T0>{
            payload  : v8,
            digest   : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::digest(&arg1),
            sequence : 0xd56341aff3d912ec4a41782bfae743dc7f0f136198e7edd6ef0c3657897db9a3::vaa::sequence(&arg1),
        }
    }

    // decompiled from Move bytecode v6
}

