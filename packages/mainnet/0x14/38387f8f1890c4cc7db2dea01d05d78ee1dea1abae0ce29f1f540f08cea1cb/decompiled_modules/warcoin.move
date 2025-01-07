module 0x1438387f8f1890c4cc7db2dea01d05d78ee1dea1abae0ce29f1f540f08cea1cb::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WARCOIN>(arg0, 6821507598750757814, b"Napoleon 3523", b"WARCOIN", b"Emperor of Sui. We'll make The Great Flip Happen and there is nothing they can do. Join The Sui Imperial Army or perish, it's a $WARCOIN", b"https://images.hop.ag/ipfs/QmShr3qRHk42W8bEFA2XYs5vFDPJ4M5fua8vfBso9rE7BS", 0x1::string::utf8(b"https://x.com/NapoleonTheCoin"), 0x1::string::utf8(b"https://n3523.com"), 0x1::string::utf8(b"https://t.me/Napoleon3523official"), arg1);
    }

    // decompiled from Move bytecode v6
}

