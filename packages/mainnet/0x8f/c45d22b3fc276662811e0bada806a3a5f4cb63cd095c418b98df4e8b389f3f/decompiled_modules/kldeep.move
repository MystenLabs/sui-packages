module 0x8fc45d22b3fc276662811e0bada806a3a5f4cb63cd095c418b98df4e8b389f3f::kldeep {
    struct KLDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLDEEP>(arg0, 6, b"klDEEP", b"klDEEP", b"Kai Leverage DEEP Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, KLDEEP>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, KLDEEP>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLDEEP>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

