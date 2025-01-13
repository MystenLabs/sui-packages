module 0x3da20c71f338167b6b962497508b090c47fbff6fbd37ad0036123d62b0ba4409::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRM>>(0x2::coin::mint<TRM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/kR1NW3B7ihaIeutC?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRM     ")))), trim_right(b"Taurium AI                      "), trim_right(b"TauriumAI (TRM), an innovative project about to launch and revolutionize the meme coin space. We are starting with a simple yet ambitious vision: to combine the power of artificial intelligence (AI) with the humor and creativity of memes while building a passionate and engaged community.                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRM>>(0x2::coin::mint<TRM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

