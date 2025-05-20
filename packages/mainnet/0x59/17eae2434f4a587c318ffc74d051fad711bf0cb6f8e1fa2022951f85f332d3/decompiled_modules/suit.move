module 0x5917eae2434f4a587c318ffc74d051fad711bf0cb6f8e1fa2022951f85f332d3::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIT>(arg0, b"SUIT", b"Suit on Sui", x"45766572792063686164206e65656473206120535549542e0a4a6f696e20746865206d6f76656d656e740a24535549207374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbqDY2tVYTGPwcuj1XhrewkwGri8cqm9cyNaeSVWXAhXW")), b"https://suiblockchain.net/suit", b"https://x.com/SuitOnSui_", b"DISCORD", b"https://t.me/Suit_Sui", 0x1::string::utf8(b"00c521ee47b98ee97cb2d74e88761d577cf880a8d02d2197981d26a7f23e94d99ce173bc829a2a57ba5705d3b843cbf51b108db7417ad5f0a78c51fa456e08ff02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747776154"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

