module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::set::Set<0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32) {
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::set::add<0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::set::new<0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

