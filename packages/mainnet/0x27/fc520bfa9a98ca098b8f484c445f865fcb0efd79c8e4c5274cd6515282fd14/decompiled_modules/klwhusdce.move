module 0x27fc520bfa9a98ca098b8f484c445f865fcb0efd79c8e4c5274cd6515282fd14::klwhusdce {
    struct KLWHUSDCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLWHUSDCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLWHUSDCE>(arg0, 6, b"klWHUSDCE", b"klWHUSDCE", b"Kai Leverage WHUSDCE Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, KLWHUSDCE>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, KLWHUSDCE>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLWHUSDCE>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

