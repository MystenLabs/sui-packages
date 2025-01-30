module 0xcc89168df227621ceab8f2309f134fef00606cc056b61c598a776847367b8e36::klusdy {
    struct KLUSDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::create_treasury<KLUSDY>(arg0, 6, b"klUSDY", b"klUSDY", b"Kai Leverage USDY Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::PoolCreationTicket<0x960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY, KLUSDY>>(0x826f6e045f5b19fb883f5997fa344cbff2c78f0f9fc70115a09cffb8f338e456::init::new_pool_creation_ticket<0x960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY, KLUSDY>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDY>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

