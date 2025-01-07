module 0x56798a37b86f8f85f77941df12969ce083185f27d20f66f1ad2916ecf25ec715::hopvm {
    struct HOPVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPVM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPVM>(arg0, 9370094965415666970, b"HOPVEMBER", b"$HOPVM", x"4d4f4f4e56454d424552202b20484f502e46554e203d20484f5056454d4245520a0a576974682069747320756e69717565206e61727261746976652c2024686f7076656d626572206973206f6e20697427732077617920746f2074616b65206f7665722074686520737569207472656e6368657321", b"https://images.hop.ag/ipfs/QmdwrAZd5WT3EDuGxrrLkTXPrH2yA2yipgA2zdR7UnsPPK", 0x1::string::utf8(b"https://x.com/hopvember"), 0x1::string::utf8(b"https://hopvember.surge.sh/"), 0x1::string::utf8(b"https://t.me/hopvember"), arg1);
    }

    // decompiled from Move bytecode v6
}

