module 0x7e2e654756e5d79c2290680646bfb96fb067a243a7cd8035f44ad511613377f0::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<KOA>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<KOA>(arg0, b"KOA", b"Cute Koala", b"KOA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/fb647905-ed06-4b60-b789-5d292dd447b4")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"00ab0a817af7c80cbb119d04c4853bf95e97fd5944bbe804a8c7fd6367cf3e8b038ac4f995bf91a971f8c95724264627c7eabc91454ac43bb64053768cda70e20cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738822899"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

