module 0x3b4a3b14203e30dc9cb3fe3642c3a1833c117de864415db457aee6ee72ffbab7::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUICIDE>(arg0, 18207992981047354485, b"SUICIDE", b"SUICIDE", b"We take this token to 100m or meet on a bridge.", b"https://images.hop.ag/ipfs/QmUDQh485khinSSo2fTKyq48yzbJJLUnfWKp4ayznhUs6B", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

