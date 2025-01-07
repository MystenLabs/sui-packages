module 0xbf8dbd7c852f7f202d8bda694a8b8e9c9bd7212f955bcb18d674c9cee73213b3::suirca {
    struct SUIRCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIRCA>(arg0, 12026665370514429157, b"Sui Orca", b"SUIRCA", b"Meet Suirca ($SUIRCA), the apex predator of Sui!", b"https://images.hop.ag/ipfs/QmQQXrdAHZyQbxmAc9M7sz42m7HkDfrDcGitoKYrxQdFmE", 0x1::string::utf8(b"https://x.com/SuircaOnHop"), 0x1::string::utf8(b"https://www.suirca.xyz/"), 0x1::string::utf8(b"https://t.me/suiiorca"), arg1);
    }

    // decompiled from Move bytecode v6
}

