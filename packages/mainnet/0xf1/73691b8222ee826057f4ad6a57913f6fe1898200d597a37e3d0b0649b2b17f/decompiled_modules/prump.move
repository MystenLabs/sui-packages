module 0xf173691b8222ee826057f4ad6a57913f6fe1898200d597a37e3d0b0649b2b17f::prump {
    struct PRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PRUMP>(arg0, 13049614757884049752, b"PRUMP EMPIRE", b"PRUMP", b"PRUMP UP", b"https://images.hop.ag/ipfs/QmRFcGzupceJLUs9Xty89BH4dtjbaAWELAp5MTB3rVckgu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

