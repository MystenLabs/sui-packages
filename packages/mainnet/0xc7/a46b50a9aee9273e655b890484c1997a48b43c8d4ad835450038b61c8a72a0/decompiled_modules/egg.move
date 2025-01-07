module 0xc7a46b50a9aee9273e655b890484c1997a48b43c8d4ad835450038b61c8a72a0::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<EGG>(arg0, 6619418500126352319, b"egg", b"EGG", b"egg", b"https://images.hop.ag/ipfs/QmPytmK1cg5JvZ9mevJKhAGwzi6pUKqFPamZ6T1GhSmDEU", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

