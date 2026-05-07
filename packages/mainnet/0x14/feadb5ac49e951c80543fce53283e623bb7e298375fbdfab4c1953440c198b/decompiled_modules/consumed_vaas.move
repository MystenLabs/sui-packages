module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::set::Set<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32) {
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::set::add<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::set::new<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v7
}

