module 0x1de35e5a9aacb8f7bd21ea6df54688649b461a669cab3c5967ab74b72b323f32::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<KOA>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<KOA>(arg0, b"KOA", b"Cute Koala", b"KOA .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/63e486dc-2430-4533-8cc0-932a57fe01a8")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"005f3471bc0724114fba5669da5a19274fa4522370efd8092e225c16b4c1345d61bd53e547b2b5cf61ecb46049e3ed4325b8ae68b5ffbacba63586a0ce0bea30032b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

