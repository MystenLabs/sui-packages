module 0x4a33c0eab3fa4c43dc63782b6782d5ed4557d772fdbd486e0b4ce54d9def0948::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TSUI>(arg0, 17148588556232364648, b"Suinami", b"Tsui", b"It's just a drop of water in the Sea", b"https://images.hop.ag/ipfs/QmcpRKqKKS9btn8nrQTvzm1SjVYNaqDg7Kubt3by6Togti", 0x1::string::utf8(b"https://x.com/WeldingJoints?t=K3WlCmb4aoIJdk6YeNWfTw&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

