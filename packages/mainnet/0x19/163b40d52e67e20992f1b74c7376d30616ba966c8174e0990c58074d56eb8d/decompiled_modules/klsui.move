module 0x19163b40d52e67e20992f1b74c7376d30616ba966c8174e0990c58074d56eb8d::klsui {
    struct KLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLSUI>(arg0, 6, b"klSUI", b"klSUI", b"Kai Leverage SUI Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x2::sui::SUI, KLSUI>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x2::sui::SUI, KLSUI>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLSUI>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

