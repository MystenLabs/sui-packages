module 0xbcbfd58015ef6ef85cf472cae42fb8efb713bb86901c2e58ceee4fc5fd78e6fa::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<CCAT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<CCAT>(arg0, b"CCAT", b"Crazy Cats", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/7b575be8-de80-4254-9ca5-1ec0763bfab2")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"008bbc87861a3cc6531cd11854012cd7d8bc4418ef234c9b32d87a26288e74266c9c3c4f99138c57925312152bda07586688156a59eccd0b2174afceaf0bed8005f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738333815"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

