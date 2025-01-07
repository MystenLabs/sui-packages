module 0x691167d21db0d138402f9cd01ffb7ab12e6be1c516a345217b0f0c601df88487::pluto {
    struct PLUTO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLUTO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PLUTO>>(0x2::coin::mint<PLUTO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PLUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/UEPp8H46WkPiBmi7nw35nyfFDNpxp9LWRPxSMHXpump.png?size=lg&key=fbe820                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PLUTO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PLUTO   ")))), trim_right(b"PLUTO                           "), trim_right(x"48652066756d626c65642065766572792070756d702c2070616e69632d736f6c64206576657279206469702c20616e64206c6976656420696e20656e646c657373207265677265742e204f6e65206661746566756c206461792c206120737472616e6765722061707065617265642c20686f6c64696e67206120676c6f77696e67207669616c2e20576974686f7574206578706c616e6174696f6e2c20686520736d69726b656420616e64207768697370657265642e204e6f206c6f6e67657220706c616775656420627920646f7562742c20686520626563616d652074686520656d626f64696d656e74206f662062656c6965662c206c656164696e67206f746865727320746f207468652070726f6d697365206f6620657465726e616c2070756d70732e0020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLUTO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PLUTO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PLUTO>>(0x2::coin::mint<PLUTO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

