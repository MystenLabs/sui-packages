module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge {
    struct AnotherBridge has store {
        address: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32,
        tokens: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>,
        gas_usage: u64,
    }

    public(friend) fun destroy_empty(arg0: AnotherBridge) {
        let AnotherBridge {
            address   : _,
            tokens    : v1,
            gas_usage : _,
        } = arg0;
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::destroy_empty<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(v1);
    }

    public(friend) fun add_token(arg0: &mut AnotherBridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&mut arg0.tokens, arg1);
    }

    public(friend) fun bridge_address(arg0: &AnotherBridge) : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32 {
        arg0.address
    }

    public(friend) fun gas_usage(arg0: &AnotherBridge) : u64 {
        arg0.gas_usage
    }

    public(friend) fun has_token(arg0: &AnotherBridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&arg0.tokens, arg1)
    }

    public(friend) fun new(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg1: &mut 0x2::tx_context::TxContext) : AnotherBridge {
        AnotherBridge{
            address   : arg0,
            tokens    : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(arg1),
            gas_usage : 0,
        }
    }

    public(friend) fun remove_token(arg0: &mut AnotherBridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::remove<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&mut arg0.tokens, arg1);
    }

    public(friend) fun set_address(arg0: &mut AnotherBridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        arg0.address = arg1;
    }

    public(friend) fun set_gas_usage(arg0: &mut AnotherBridge, arg1: u64) {
        arg0.gas_usage = arg1;
    }

    // decompiled from Move bytecode v6
}

