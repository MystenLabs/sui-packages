module 0xd5cce6b7dd4c86cceecc08c74297236f9da8ca994512e5cda3161f3b54c99955::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUPE>(arg0, b"SUPE", b"SUIPEPE", b"WELCOME TO THE ERA OF MEME ON THE BEST CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXm3aXL1Gjg3xdB8A2BUD1BSdouQBF6aE4jweLMToh4Cy")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0008a2a37f3b52348cea761f47f45f58c1a2557ead76e0910544c076acf43a87a4a3f036cc7260d10770885b6f6a9bca8614cde2e0c4948a060717ce06b8381e0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747772969"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

