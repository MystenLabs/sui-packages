module 0x90ee8911249d0d9cfe6caacb792ab54586e39c46b476de48b0be1a1859238ec8::devecho {
    struct DEVECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AXVE3QZjvbhtCPAxGunJcyKm43kH4Ro61GPapAybpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEVECHO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEVECHO     ")))), trim_right(b"DEVECHO AI                      "), trim_right(x"41492d506f776572656420436f6c6c61626f726174696f6e20666f7220536d617274657220446576656c6f706d656e740a4465764563686f20697320616e2041492d64726976656e20646576656c6f706d656e7420687562207468617420626f6f737473207465616d2070726f647563746976697479207769746820736d6172742073756767657374696f6e732c206175746f6d6174656420636f646520726576696577732c20616e64207365616d6c6573732076657273696f6e20636f6e74726f6c68656c70696e6720796f7520636f64652c20636f6c6c61626f726174652c20616e64206465706c6f79206661737465722e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVECHO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVECHO>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

