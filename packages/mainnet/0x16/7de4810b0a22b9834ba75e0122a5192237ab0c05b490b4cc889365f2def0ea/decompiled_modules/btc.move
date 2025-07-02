module 0x167de4810b0a22b9834ba75e0122a5192237ab0c05b490b4cc889365f2def0ea::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2XYgocKz9MvkNVVyj85kdM2VxsUwrJeQUZVD4qmD4dYT.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTC         ")))), trim_right(b"Bobby The Cat                   "), trim_right(x"424f4242592054484520434154202d2024425443200a0a57484f275320424f42425920544845204341543f200a426f6262792069736e74206a75737420616e792066656c696e6568657320746865206c6976696e672c2070757272696e67207061726f6479206f6620736f6d657468696e672077617920746f6f20736572696f75732e205768696c65206f74686572732061726775652061626f75742063686172747320616e6420636f696e732c20426f626279206e617073206f6e206b6579626f6172647320616e64206163636964656e74616c6c79206275797320736e61636b73207769746820736f6d656f6e65732063726564697420636172642e2054686174732072696768742e20244254432069736e74207768617420796f75207468696e6b6974207374616e647320666f7220426f62627920546865204361742e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v4);
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

