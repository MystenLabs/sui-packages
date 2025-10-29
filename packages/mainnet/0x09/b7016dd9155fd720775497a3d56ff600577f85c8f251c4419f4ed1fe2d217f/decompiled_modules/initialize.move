module 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::initialize {
    public entry fun init_oft_entry<T0>(arg0: 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_impl::OFTInitTicket, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_impl::init_oft<T0>(arg0, arg1, arg2, arg3, 6, arg4);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::migration::MigrationCap>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

