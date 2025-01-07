module 0x84ff2cbd7d089bc67dbc906018efb6ca4581b15bdf04538396220933ede22a30::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GAY>(arg0, 992257684192612167, b"WhyGay", b"Gay", b"Don't be Gay, Buy Gay", b"https://images.hop.ag/ipfs/Qmep3yhK8H9nr1y3bXeH5GZGpUuMN9dVnQuXws6AxDkC3Q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

