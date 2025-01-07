module 0x19c31dc2c6d6fdf5bcc8c62c1e041756b9eef080ce20854701e831031c3f0939::bitcat {
    struct BITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BITCAT>(arg0, 12688304381707779690, b"Bitcat", b"BITCAT", b"Piggy bank Cat Glutton with sausages", b"https://images.hop.ag/ipfs/Qmdv24n6v52UfFsaz5YnwvmVuaFTe1BbxPzSVhGhbSm7nT", 0x1::string::utf8(b"https://x.com/BitcoinCatToken"), 0x1::string::utf8(b"https://bitcoin.org/nl/"), 0x1::string::utf8(b"https://t.me/bitcatcoinsolana"), arg1);
    }

    // decompiled from Move bytecode v6
}

