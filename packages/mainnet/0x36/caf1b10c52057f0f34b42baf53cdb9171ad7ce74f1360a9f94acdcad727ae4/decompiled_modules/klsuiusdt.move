module 0x36caf1b10c52057f0f34b42baf53cdb9171ad7ce74f1360a9f94acdcad727ae4::klsuiusdt {
    struct KLSUIUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLSUIUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLSUIUSDT>(arg0, 6, b"klsuiUSDT-2", b"klsuiUSDT-2", b"Kai Leverage suiUSDT Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT, KLSUIUSDT>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT, KLSUIUSDT>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLSUIUSDT>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

