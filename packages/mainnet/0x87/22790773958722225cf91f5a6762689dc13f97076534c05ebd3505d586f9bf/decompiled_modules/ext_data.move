module 0x8722790773958722225cf91f5a6762689dc13f97076534c05ebd3505d586f9bf::ext_data {
    struct ExtData has copy, drop, store {
        value: u64,
        value_sign: bool,
        relayer: address,
        relayer_fee: u64,
        encrypted_output0: vector<u8>,
        encrypted_output1: vector<u8>,
    }

    public(friend) fun assert_relayer(arg0: ExtData, arg1: &0x2::tx_context::TxContext) {
        if (arg0.relayer != @0x0) {
            assert!(arg0.relayer == 0x2::tx_context::sender(arg1), 806);
        };
    }

    public(friend) fun encrypted_output0(arg0: ExtData) : vector<u8> {
        arg0.encrypted_output0
    }

    public(friend) fun encrypted_output1(arg0: ExtData) : vector<u8> {
        arg0.encrypted_output1
    }

    public fun new(arg0: u64, arg1: bool, arg2: address, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) : ExtData {
        ExtData{
            value             : arg0,
            value_sign        : arg1,
            relayer           : arg2,
            relayer_fee       : arg3,
            encrypted_output0 : arg4,
            encrypted_output1 : arg5,
        }
    }

    public(friend) fun public_value(arg0: ExtData) : u256 {
        if (arg0.value_sign) {
            ((arg0.value - arg0.relayer_fee) as u256)
        } else {
            21888242871839275222246405745257275088548364400416034343698204186575808495617 - (arg0.value as u256)
        }
    }

    public(friend) fun relayer(arg0: ExtData) : address {
        arg0.relayer
    }

    public(friend) fun relayer_fee(arg0: ExtData) : u64 {
        arg0.relayer_fee
    }

    public(friend) fun value(arg0: ExtData) : u64 {
        arg0.value
    }

    public(friend) fun value_sign(arg0: ExtData) : bool {
        arg0.value_sign
    }

    // decompiled from Move bytecode v7
}

