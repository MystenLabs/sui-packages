module 0x33c36f8d1fb021fb36e4dfc69d1f4bdff847cce2ceccc86f1737cfb16f336d5::aasui {
    struct AASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AASUI>(arg0, 11117149716533451467, b"Agent AI", b"AASUI", b"none", b"https://images.hop.ag/ipfs/QmfMqCYYK7ZfrW9VNPo7Vjm1NuHzLxyEkbfA91F4G3Jcgv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

