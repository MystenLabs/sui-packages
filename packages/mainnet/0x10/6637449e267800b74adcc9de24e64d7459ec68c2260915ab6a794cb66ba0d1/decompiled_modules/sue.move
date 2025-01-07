module 0x106637449e267800b74adcc9de24e64d7459ec68c2260915ab6a794cb66ba0d1::sue {
    struct SUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SUE>(arg0, 12223960153363134519, b"SUMAE", b"SUE", b"A Mermaid in the Waters of the $Sui Ocean.", b"https://images.hop.ag/ipfs/QmXNpWCQo3F7aGJUTjTyPX5HbMDVPURi6eY4jxfc7opvML", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://sumaesui.com"), 0x1::string::utf8(b"https://t.me/sumaesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

