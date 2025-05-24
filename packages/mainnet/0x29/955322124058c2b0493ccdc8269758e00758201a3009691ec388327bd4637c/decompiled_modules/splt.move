module 0x29955322124058c2b0493ccdc8269758e00758201a3009691ec388327bd4637c::splt {
    struct SPLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLT>(arg0, b"SPLT", b"Splash Token", x"5468652066697273742066616972206c61756e636820706c6174666f726d206f6e2053756920f09f92a7496e7374616e74206c61756e636865732e20436f6d6d756e6974792d66697273742e204275696c6465722d67726164652e2020506f77657265642062792024484950504f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmexygpth6wwmVRxTk6iLmu1YjrqZBHeAymFQb24jHHmty")), b"https://app.splash.xyz/", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00dea9249f80ce4145937d3e6b9614303b9cdfcd1731b51378def481f93b4494a9b0c71b36ac1b6525acbd9e5a803a594430ddc9d10e66b4d4d3637803626ae60ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748086938"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

