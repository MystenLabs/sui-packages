module 0xb874dee14cd15969c130e7fe6ae2a178f4c0eedd146707ba72a2393e9884c007::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DDS>(arg0, 6092935359380840033, b"DeadDudeSociety", b"DDS", b"Reborn of The Deads", b"https://images.hop.ag/ipfs/QmZ6NZTgK7KgktHRxhVKgbiWxmXRmcy5UsKUu5nDfy9Myj", 0x1::string::utf8(b"https://x.com/deaddudesociety"), 0x1::string::utf8(b"https://www.deaddudeproject.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

