module 0x358b47a13abe067fe4054e414f4ee1d1524236cc60ffc716ec10931c5dbec795::klwhusdte {
    struct KLWHUSDTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLWHUSDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLWHUSDTE>(arg0, 6, b"klWHUSDTE", b"klWHUSDTE", b"Kai Leverage WHUSDTE Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, KLWHUSDTE>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, KLWHUSDTE>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLWHUSDTE>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

