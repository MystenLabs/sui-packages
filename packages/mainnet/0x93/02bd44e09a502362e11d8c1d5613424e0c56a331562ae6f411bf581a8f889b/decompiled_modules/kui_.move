module 0x9302bd44e09a502362e11d8c1d5613424e0c56a331562ae6f411bf581a8f889b::kui_ {
    struct KUI_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI_, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUI_>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUI_>(arg0, b"KUI_", b"SharKui", b"KUI is not just a crypto, not just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRaP84inPjjwkV3GEAwumnX9SXpcczUj7rcwFrNG5o5BR")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI/", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"009bde1c5a64d44b7d2c308b666eb770d07a90fcd5d92e957459a69099b002af696f4fc0f744f11fba299268f5a3e568e6c46bd632bc5c1aff6eaa423af804320ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747844994"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

