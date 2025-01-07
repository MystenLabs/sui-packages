module 0xee90871d27cee37758beb290ae60239a755f8a732457ff604c5d43d675edba2f::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OINK>(arg0, 9980972505685784936, b"Sui Oink", b"$oink", x"f09f90bdf09fa4bf20244f494e4b20697320746865206d6f737420616476656e7475726f7573207069672c2073637562612d646976696e6720696e746f20535549204f6365616e20f09f92a7", b"https://images.hop.ag/ipfs/QmSVLVKJgudnXQTyowHTJ8MTYV9SvtZrbVKk7QzcCFzRqh", 0x1::string::utf8(b"https://x.com/sui_oink"), 0x1::string::utf8(b"https://www.suioink.fun/"), 0x1::string::utf8(b"https://t.me/sui_oink"), arg1);
    }

    // decompiled from Move bytecode v6
}

