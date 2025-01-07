module 0x6720ec5db121cf8e199577e8daaa2ca0d4b18b222c2a579017d50edb2d5b9fd4::shallow {
    struct SHALLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALLOW, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SHALLOW>(arg0, 4428694967427954008, b"ShallowBook Token", b"SHALLOW", b"ShallowBook", b"https://images.hop.ag/ipfs/QmZ8wTdKNaK8RhawC6mQ2oUkc8zMaqs1to3kG7JQzkVuLS", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

