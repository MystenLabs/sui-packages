module 0xfc95c5e06a81ff03e66e114de4f9226a8f068d8b72ee0f8953adea3600576786::sdruytfhb {
    struct SDRUYTFHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRUYTFHB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SDRUYTFHB>(arg0, 4377947190337141343, b"uoystdvfbn", b"sdruytfhb", b"qzdqsefef", b"https://images.hop.ag/ipfs/QmanpVzNZ3JdkhhEJr2Y3KowNgA6wgtxmuTdA93WVZqeRf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

