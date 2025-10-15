module 0xaa91fde4c2f18e825c361e7f658bd74487a9faa3246e392945089a2c43aa7f10::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MMT>(arg0, 9, 0x1::string::utf8(b"MMT"), 0x1::string::utf8(b"MMT"), 0x1::string::utf8(b"MMT is the native governance token for Momentum, the operating system powering the next era of global finance. MMT empowers holders to govern the protocol through vote-escrowed staking (veMMT) for community-driven decisions within the Momentum ecosystem."), 0x1::string::utf8(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MMT>>(0x2::coin_registry::finalize<MMT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

