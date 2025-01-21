module 0x77fabf27b92d25412aa47e7062e09b9295200757d298cc66a4c883416da35adc::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<RING>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<RING>(arg0, b"RING", b"DRUNK RING", b"DRUNK RING SYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/ac64a2b1-5300-4228-9bee-28223461878b")), b"https://youtu.be/c-dqkLR6JEA?si=HNJKIdN5GWYLmvGw", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000185afd56895c31ac3f3ad5739b3e584d1536b5f96a746d588cae39b80bac833d68dab8999405ce124e22a183a46277c0f62379d0f9f35a161f6d63fd0e47a0df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737476773"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

