module 0x52991043cf15d0e3a5aea94384dbd084846c2619b5bf3286357b28c0723b14b0::otc {
    struct OTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"41c78c79409d161da62d83344bc0fc2571139a2869e876b59f4c8911586b3654                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OTC         ")))), trim_right(b"OrionToolsCoin                  "), trim_right(x"4f72696f6e20546f6f6c7320436f696e20284f54432920697320746865206f6666696369616c207574696c69747920746f6b656e20706f776572696e6720746865204f72696f6e20546f6f6c732065636f73797374656d2c2061206e6578742d67656e65726174696f6e20706c6174666f726d2064657369676e656420746f2068656c702063726561746f72732c206275696c646572732c20616e6420646576656c6f70657273206c61756e636820616e64206d616e61676520746f6b656e73206f6e2074686520536f6c616e6120626c6f636b636861696e207769746820656173652e0a0a4f544320756e6c6f636b73207265616c207574696c6974792077697468696e20746865204f72696f6e20546f6f6c7320706c6174666f726d2c20696e636c7564696e6720646973636f756e74656420746f6f6c20616363657373"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTC>>(v4);
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

