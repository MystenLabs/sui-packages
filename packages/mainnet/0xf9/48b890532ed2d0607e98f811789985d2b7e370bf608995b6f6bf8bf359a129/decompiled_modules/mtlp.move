module 0xf948b890532ed2d0607e98f811789985d2b7e370bf608995b6f6bf8bf359a129::mtlp {
    struct MTLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MTLP>(arg0, 9, 0x1::string::utf8(b"mTLP"), 0x1::string::utf8(b"Main Typus Perps LP Token"), 0x1::string::utf8(b"Main Typus Perps LP Token"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/mTLP.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MTLP>>(0x2::coin_registry::finalize<MTLP>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTLP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

