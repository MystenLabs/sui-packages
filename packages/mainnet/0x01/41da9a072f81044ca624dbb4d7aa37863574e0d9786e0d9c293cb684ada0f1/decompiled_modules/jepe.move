module 0x141da9a072f81044ca624dbb4d7aa37863574e0d9786e0d9c293cb684ada0f1::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<JEPE>(arg0, 2252036957286185338, b"JEPE", b"JEPE", b"the most memeable jellyfish on the internet", b"https://images.hop.ag/ipfs/QmUWyWzQceTzs7EGQF94NydKGQQ2iWVcDiTYcFZNjC6dXy", 0x1::string::utf8(b"https://x.com/jepeonsui"), 0x1::string::utf8(b"https://jepesui.com/"), 0x1::string::utf8(b"https://t.me/jepeonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

