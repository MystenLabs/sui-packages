module 0x6e95ad77474c0c1ef89bf7bb7437ef3eee832e02e525487f80091d7dabb14c96::w {
    entry fun new_player(arg0: &mut 0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::player::PlayerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::player::create(arg0, 0x1::option::none<address>(), arg1);
    }

    // decompiled from Move bytecode v7
}

