module 0x33af5047f2da528280820cb2454464769c22a6d28bfe64547d6a528d24035889::frogg {
    struct FROGG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FROGG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FROGG>>(0x2::coin::mint<FROGG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FROGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/97078477e3dd7e29dfd41afeca637d123e32e8ce756e1612153ad7c7fc1007f1?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FROGG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FROGG   ")))), trim_right(b"Snoop Frogg                     "), trim_right(b"Hip hoppin' round the blockchain. The original double G meme coin on Solana. Let's send this                                                                                                                                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FROGG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FROGG>>(0x2::coin::mint<FROGG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

