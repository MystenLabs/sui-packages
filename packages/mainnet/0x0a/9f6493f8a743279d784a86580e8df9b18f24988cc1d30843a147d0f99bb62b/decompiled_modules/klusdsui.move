module 0xa9f6493f8a743279d784a86580e8df9b18f24988cc1d30843a147d0f99bb62b::klusdsui {
    struct KLUSDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLUSDSUI>(arg0, 6, b"klUSDSUI", b"klUSDSUI", b"Kai Leverage USDSUI Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI, KLUSDSUI>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI, KLUSDSUI>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDSUI>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

