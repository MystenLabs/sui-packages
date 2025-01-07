module 0xad71921fa88f33df4035ad0a88596d3cc1cfa8978b8068ee735118d75a3e43db::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUITARD>(arg0, 8285830718462896783, b"Suitard", b"SUITARD", b"im suitarded", b"https://images.hop.ag/ipfs/QmbzcxgvdMpLvtadA85BsKZZMhLLhhDWhSpF6fMqKmHBS8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

