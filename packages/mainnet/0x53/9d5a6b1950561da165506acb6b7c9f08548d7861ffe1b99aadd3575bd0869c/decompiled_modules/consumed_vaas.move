module 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::set::Set<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::bytes32::Bytes32) {
        0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::set::add<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::set::new<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

