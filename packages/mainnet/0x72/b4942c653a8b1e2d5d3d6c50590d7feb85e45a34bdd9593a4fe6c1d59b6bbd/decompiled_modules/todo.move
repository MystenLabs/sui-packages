module 0x72b4942c653a8b1e2d5d3d6c50590d7feb85e45a34bdd9593a4fe6c1d59b6bbd::todo {
    struct TODO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TODO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TODO>>(0x2::coin::mint<TODO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TODO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/AT47l9ToXWp-8NPZ?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TODO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TODO    ")))), trim_right(b"TODO                            "), trim_right(b"$TODO was born in a workshop where space launch platforms were created. Due to the number of hours of work carried out, $TODO is a robot who is quite angry with the reality that surrounds him, he is antisocial, he doesn't like ice cream and above all, he never sleeps.                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TODO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TODO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TODO>>(0x2::coin::mint<TODO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

