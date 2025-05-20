module 0x859bdb4f7b4ca0471b731fa385e69bdd34721c499d71d1fc3f368a92b5c4695b::splashhhit {
    struct SPLASHHHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHHHIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHHHIT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHHHIT>(arg0, b"SPLASHHHIT", b"SPLASH IT", x"54686520646576206f662053504c41534859200a2045766572797468696e67207761732073746f6c656e2077697468207365766572616c206163636f756e74732e2e2e206e6f77207765206465636964656420746f206372656174652053504c415348204954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZLjJ257iYLCU2A8vEXtLNA8T5WwYU499C3r84i95K2T7")), b"https://dexscreener.com/sui/0x4dd9caaf3775ece7a89355db76e3b1ca92481f69f791007119a33c8dc7da7886", b"TWITTER", b"DISCORD", b"https://t.me/splashy_CTO", 0x1::string::utf8(b"005fac0a11992d4e9c559040bd452ba1ddab1783d95a5d9d132561fd4c37885074d3e605c26b9d1ca3bafb0e4e0d83c63503f6cdea79b1ec20311915964ac22d06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770412"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

