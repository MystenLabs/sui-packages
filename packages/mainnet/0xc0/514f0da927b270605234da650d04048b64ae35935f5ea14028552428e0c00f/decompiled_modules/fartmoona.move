module 0xc0514f0da927b270605234da650d04048b64ae35935f5ea14028552428e0c00f::fartmoona {
    struct FARTMOONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTMOONA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4ZVN9j4PrKVWQF8CgyQjNAcqNegFuGPvTLryo1bPpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTMOONA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTMOON    ")))), trim_right(b"First fart on the moon          "), trim_right(x"4a6f686e20596f756e672c20616e20617374726f6e617574206f6e207468652041706f6c6c6f203136206d697373696f6e2c2069732066616d6f75736c79207361696420746f2068617665206a6f6b65642061626f75742070617373696e6720676173207768696c65206f6e20746865204d6f6f6e2064756520746f206f72616e6765206a7569636520696e20746865697220646965742e200a54686520666972737420666172746572206f6e20746865206d6f6f6e2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTMOONA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTMOONA>>(v4);
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

