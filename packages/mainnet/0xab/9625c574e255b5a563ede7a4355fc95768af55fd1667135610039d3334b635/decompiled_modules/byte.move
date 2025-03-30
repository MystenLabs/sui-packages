module 0xab9625c574e255b5a563ede7a4355fc95768af55fd1667135610039d3334b635::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYTE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BYTE>>(0x2::coin::mint<BYTE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x03ceac3c28e353f5e4626c1242a6c7a41d004354.png?size=lg&key=839285                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BYTE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BYTE    ")))), trim_right(b"Byte                            "), trim_right(b"$BYTE is Groks official dog token, launched with the help of Cliza, an agentic token launchpad. The token was deployed directly through the X social feed, with the deployment triggered when Grok suggested the name and ticker in a thread with Cliza.                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYTE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BYTE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BYTE>>(0x2::coin::mint<BYTE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

