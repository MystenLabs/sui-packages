module 0x4acb21bc82d09db099d89a5cf48f433d34fbc46c04fc7b79dda0b27e7f32fb20::klwbtc {
    struct KLWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLWBTC>(arg0, 8, b"klWBTC", b"klWBTC", b"Kai Leverage WBTC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0xaafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC, KLWBTC>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0xaafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC, KLWBTC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLWBTC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

