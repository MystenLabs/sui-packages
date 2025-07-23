module 0x439536b0ed9ffa4ead507ec35ae2bdc759a8bb7abe30fafea68a06af54476d75::klxbtc {
    struct KLXBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLXBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLXBTC>(arg0, 8, b"klXBTC", b"klXBTC", b"Kai Leverage XBTC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x876a4b7bce8aeaef60464c11f4026903e9afacab79b9b142686158aa86560b50::xbtc::XBTC, KLXBTC>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x876a4b7bce8aeaef60464c11f4026903e9afacab79b9b142686158aa86560b50::xbtc::XBTC, KLXBTC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLXBTC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

