module 0xfdb33e2362996c7489297e517166f0ad9ec87a282c295d914cc1fbaeedbace39::splashlt {
    struct SPLASHLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHLT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHLT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHLT>(arg0, b"SPLASHlT", b"SPLASHlTT", b"The stupid Splashlt is the new Splashy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZLjJ257iYLCU2A8vEXtLNA8T5WwYU499C3r84i95K2T7")), b"https://dexscreener.com/sui/0x4dd9caaf3775ece7a89355db76e3b1ca92481f69f791007119a33c8dc7da7886", b"TWITTER", b"DISCORD", b"https://t.me/splashy_CTO", 0x1::string::utf8(b"00ac737c9ffc8e0335796b717daa2c27dca724b170ebc1ebbf1d61649a343b8bccd83171f5a12b63bacc669e052852700bf73ed1510179b86bb6e3be121c6b4707d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770157"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

