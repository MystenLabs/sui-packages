module 0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::set::Set<0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::bytes32::Bytes32) {
        0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::set::add<0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::set::new<0x856fe354ed8bada41be769e686af143d3fa07987294c91377b8afdda6e504546::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

