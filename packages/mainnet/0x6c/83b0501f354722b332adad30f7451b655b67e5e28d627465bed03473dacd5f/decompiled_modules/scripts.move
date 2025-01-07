module 0x6c83b0501f354722b332adad30f7451b655b67e5e28d627465bed03473dacd5f::scripts {
    entry fun buy_hfrog(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, 100000000, arg1), @0xe00a925861f93ce50e9474e2c284c705dc3bf124bb00d651a847426bda861094);
    }

    // decompiled from Move bytecode v6
}

