module 0xa5019054b5d31c2cdf285a883f540d7f9dc3766cf2b31af6aa99df42fa953fdd::crazy {
    struct CRAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5ZA7sx5DH5pN6oQAdYUBR34dv518aoQ3ciydeDrVmoon.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CRAZY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CRAZY       ")))), trim_right(b"CRAZY                           "), trim_right(x"244352415a59206973207468652066616365206f662074686174206372656570696e6720646f75627420796f752074727920746f2069676e6f72652e20546865206665656c696e6720796f7520676574207269676874206265666f726520736869742068697473207468652066616e2e0a0a546865206d656d65207468617420706572666563746c792063617074757265733a0a22576169742e2e2e2e20776173204920726967687420616c6c20616c6f6e673f2220202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZY>>(v4);
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

