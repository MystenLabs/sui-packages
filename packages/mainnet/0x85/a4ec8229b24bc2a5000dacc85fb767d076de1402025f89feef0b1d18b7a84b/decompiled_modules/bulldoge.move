module 0x85a4ec8229b24bc2a5000dacc85fb767d076de1402025f89feef0b1d18b7a84b::bulldoge {
    struct BULLDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BULLDOGE>(arg0, 9117086809504487389, b"BULLDOGE ON SUI", b"BULLDOGE", b"BULLDOGE is a fearless token on Sui.https://x.com/BullDog_Sui | https://t.me/BullDog_Sui | https://t.me/BullDog_Sui", b"https://images.hop.ag/ipfs/QmdGbrk8Y1WQ1ZzwScvKAevEYGfWSiruzBajoioANM5zwt", 0x1::string::utf8(b"https://x.com/BullDog_Sui"), 0x1::string::utf8(b"https://bulldogsui.site"), 0x1::string::utf8(b"https://t.me/BullDog_Sui"), arg1);
    }

    // decompiled from Move bytecode v6
}

