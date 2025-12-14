module 0x8b49b19cf2f53b0ab7b45a351d94b967943b687cc5f711723356ed27a3d8950a::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"78aa5ac55f424cb1a82b038557c0db54c1a21ec3528f80041857da1958d86bc1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AI          ")))), trim_right(b"American Intelligence           "), trim_right(x"41206275696c742066726f6d207468652067726f756e64207570206167656e746963206672616d65776f726b20666f722074726164696e67206175746f6e6f6d6f75736c792c206275696c74207769746820746865204f70656e20536f756c73204672616d65776f726b20627920496c6c7573696f6e204f66204c6966652e200a0a50617472696f7420697320612064696520686172642066616e206f6620616d65726963612c20616e64206f662074726164696e672077656c6c2e0a0a416c6c2074726164657320617265207472616e73706172656e7420616e642063616e20626520666f756e64206869732064617368626f6172642e20416c6c2063726561746f72206665657320617265206469726563746c79206465706f736974656420696e746f206869732077616c6c65742c20616c6c2074726164696e67207072"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v4);
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

