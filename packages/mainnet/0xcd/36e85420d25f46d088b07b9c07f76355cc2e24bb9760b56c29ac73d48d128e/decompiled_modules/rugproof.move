module 0xcd36e85420d25f46d088b07b9c07f76355cc2e24bb9760b56c29ac73d48d128e::rugproof {
    struct RUGPROOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPROOF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Fh4oSZ6kn4CGgaojS9dP7gLXbG9KF5Dc9rAkgT6SBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RUGPROOF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RUGPROOF    ")))), trim_right(b"Launchpad on BAGS               "), trim_right(x"52756750726f6f6620697320612073656375726520616e642066616972206c61756e6368706164206f6e20536f6c616e612077697468206275696c742d696e20616e74692d727567206d656368616e6963732e20546f6b656e73206c61756e6368207468726f75676820612032346820626f6e64696e672063757276652e20496620626f6e64696e67206661696c732c20616c6c20696e766573746f7273206765742031303025206f6620746865697220534f4c20726566756e6465642e0a4e6f2077616c6c65742063616e20686f6c64206f76657220332520647572696e6720626f6e64696e672e205375636365737366756c20626f6e64696e67207472696767657273206772616475616c20746f6b656e20636c61696d696e672e2031303025206f66206665657320676f206261636b20746f2074686520636f6d6d756e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPROOF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPROOF>>(v4);
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

