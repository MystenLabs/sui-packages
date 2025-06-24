module 0xa42f249eb4e31d276f28a15b845b85b4c9df356a8dbec21231cdf5b751210805::xtrade {
    struct XTRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2vfBxPmHSW2YijUcFCRoMMkAWP9fp8FGWnKxVvJnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XTRADE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XTRADE      ")))), trim_right(b"X Trade AI                      "), trim_right(x"582054726164652041492073706f747320616c70686120616e64206d656d6573206561726c797265616c2d74696d6520696e7369676874732c207472656e64732c20616e6420737461747320696e206f6e6520736d61727420636861742e0a0a582054726164652041492069732074686520696e74656c6c6967656e742063686174626f7420746861742066696c74657273207369676e616c2066726f6d20746865206368616f732e2046726f6d207363616e6e696e67206d656d65207472656e647320746f20616e616c797a696e672074726164696e67207061747465726e732c2069742064656c697665727320736861727020696e73696768747320696e7374616e746c792e204e6f20666c7566662c206a75737420666173742c20616374696f6e61626c6520696e666f2020736f20796f757265206e65766572206c61"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTRADE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XTRADE>>(v4);
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

