module 0xb49953b24d44746a0baa8c98abd4bca81fe2d2f49e6101bf64111e4b04da20f3::nyanmas {
    struct NYANMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NYANMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NYANMAS>>(0x2::coin::mint<NYANMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NYANMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4rbAQqN2z5VCNe6AgvxnXC8muXoghEXEyADxdmXipump.png?size=lg&key=c70655                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NYANMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NYANMAS ")))), trim_right(b"Christmas's Nyan Cat            "), trim_right(x"57656c636f6d6520746f204e59414e4d41532c20737072656164696e67206665737469766520636865657220776974682074686520686f6c69646179206d61676963206f66204e79616e204361742120496e737069726564206279207468652069636f6e696320706f702d746172742066656c696e6520616e6420696e66757365642077697468204368726973746d6173207370697269742c206f757220746f6b656e206272696e6773206a6f792c206e6f7374616c6769612c20616e64206120737072696e6b6c65206f6620737461726c697420776f6e64657220746f2074686520736561736f6e2e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYANMAS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NYANMAS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NYANMAS>>(0x2::coin::mint<NYANMAS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

