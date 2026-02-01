module 0x7b0c58447ecc512bef1332047d93a15d8df63b557f679230f5c2cf3823657227::gsbank {
    struct GSBANK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GSBANK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GSBANK>>(0x2::coin::mint<GSBANK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GSBANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/dbf723141205ccf430dceadf705e0aae453979bc7cefa0bf3a7202ad3067af7c?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GSBANK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GSBANK  ")))), trim_right(b"GreenlandSilverBank             "), trim_right(b"Greenland Silver Bank is a narrative-driven crypto project inspired by Greenlands silver resources and global geopolitical interest. This project is purely speculative and story-based, with no real-world utility or affiliation.                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSBANK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GSBANK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GSBANK>>(0x2::coin::mint<GSBANK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

