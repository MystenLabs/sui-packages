module 0x1f83d519d5e3b7cdbdfdea15ba1c2c5a4b90e9db98416a3692a93b410b0b3a0e::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOP>(arg0, 14784052160576788066, b"HOPBUNNY", b"HOP", b"LIVE ON DEX", b"https://images.hop.ag/ipfs/QmXVYDRJBnNHmsUeBdkcW7MvhqwQs8urwE8RkYAYV3aRuT", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/hopbunnysui"), arg1);
    }

    // decompiled from Move bytecode v6
}

