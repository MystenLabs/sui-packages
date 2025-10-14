module 0xace254f2cf5d749753a4bd8cab5bb0b9b54a21a83cf01b2fb6ca9c0d42836b4a::faucet {
    struct DlmmPositionWrapper has store, key {
        id: 0x2::object::UID,
        position: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position,
    }

    public fun unwrap_position(arg0: DlmmPositionWrapper, arg1: &mut 0x2::tx_context::TxContext) {
        let DlmmPositionWrapper {
            id       : v0,
            position : v1,
        } = arg0;
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    public fun wrap_position(arg0: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DlmmPositionWrapper{
            id       : 0x2::object::new(arg1),
            position : arg0,
        };
        0x2::transfer::public_transfer<DlmmPositionWrapper>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

