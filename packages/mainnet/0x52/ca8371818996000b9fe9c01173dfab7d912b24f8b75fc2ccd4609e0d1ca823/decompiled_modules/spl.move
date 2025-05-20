module 0x52ca8371818996000b9fe9c01173dfab7d912b24f8b75fc2ccd4609e0d1ca823::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPL>(arg0, b"SPL", b"Splash", x"4b656570206275696c64696e672c205468652066697273742066616972206c61756e636820706c6174666f726d206f6e2053756920f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmexygpth6wwmVRxTk6iLmu1YjrqZBHeAymFQb24jHHmty")), b"https://splash.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"https://t.me/splash_support", 0x1::string::utf8(b"00ed390ffa3c4fdb6574582022a32cb948f271772110af762fc846f00be719b5cd150678e1e89f44768bd05d6bec43caca153251e92c99ffaf1a7ba1804f793106d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762579"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

