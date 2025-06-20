module 0x8d65745f4e6d803c80ab2243ae40dcb8d7e8faee23aec1581acc0523be81eb1a::nui {
    struct NUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HJyuf8BT9erNj925KoPvSVjfHgrj9rxLLNKyHNBZ4Ve1.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NUI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NUI         ")))), trim_right(b"NativeUI Cloud                  "), trim_right(b"NativeUI is the next-generation UI framework that lets you build high-performance, truly native interfaces from a single codebase. Unlike hybrid solutions that rely on web views, NativeUI compiles directly to system-level APIs like Swift or Kotlin, delivering pixel-perfect UX and full access to native features. Its bla"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUI>>(v4);
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

