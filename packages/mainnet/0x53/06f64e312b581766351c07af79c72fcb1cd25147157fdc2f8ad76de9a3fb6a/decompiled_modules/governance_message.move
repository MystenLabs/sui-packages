module 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message {
    struct DecreeTicket<phantom T0> {
        governance_chain: u16,
        governance_contract: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        module_name: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
        action: u8,
        global: bool,
    }

    struct DecreeReceipt<phantom T0> {
        payload: vector<u8>,
        digest: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
        sequence: u64,
    }

    public fun authorize_verify_global<T0: drop>(arg0: T0, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg4: u8) : DecreeTicket<T0> {
        DecreeTicket<T0>{
            governance_chain    : arg1,
            governance_contract : arg2,
            module_name         : arg3,
            action              : arg4,
            global              : true,
        }
    }

    public fun authorize_verify_local<T0: drop>(arg0: T0, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg4: u8) : DecreeTicket<T0> {
        DecreeTicket<T0>{
            governance_chain    : arg1,
            governance_contract : arg2,
            module_name         : arg3,
            action              : arg4,
            global              : false,
        }
    }

    fun deserialize(arg0: vector<u8>) : (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, u8, u16, vector<u8>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0))
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

    public fun take_payload<T0>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs, arg1: DecreeReceipt<T0>) : vector<u8> {
        let DecreeReceipt {
            payload  : v0,
            digest   : v1,
            sequence : _,
        } = arg1;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::consume(arg0, v1);
        v0
    }

    public fun verify_vaa<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg2: DecreeTicket<T0>) : DecreeReceipt<T0> {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::assert_latest_only(arg0);
        let DecreeTicket {
            governance_chain    : v0,
            governance_contract : v1,
            module_name         : v2,
            action              : v3,
            global              : v4,
        } = arg2;
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::guardian_set_index(&arg1) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::guardian_set_index(arg0), 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&arg1) == v0, 1);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&arg1) == v1, 2);
        let (v5, v6, v7, v8) = deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(arg1));
        assert!(v2 == v5, 4);
        assert!(v3 == v6, 5);
        if (v4) {
            assert!(v7 == 0, 6);
        } else {
            assert!(v7 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 7);
        };
        DecreeReceipt<T0>{
            payload  : v8,
            digest   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg1),
            sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
        }
    }

    // decompiled from Move bytecode v6
}

