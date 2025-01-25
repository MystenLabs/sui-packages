module 0x65d4127017637b1411b20beca5417199573b6f94da8f83aaf2e9aefe5931f4e1::siker {
    struct SIKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIKER, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SIKER>(arg0, 3310184325644677261, b"SIKERDIO", b"SIKER", b"SIKERSIKERSIKERSIKERSIKERSIKERSIKERSIKERSIKERSIKER", b"https://images.hop.ag/ipfs/QmQS842h57c6DiqRLrhY7SZUvkvXnXhaxHXQ6oPm1VHxM4", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

