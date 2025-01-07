module 0x6873f4c7fa8a1108f43883cf6ecb070e1b85ae55f7694216301f5add385bb74f::mikky {
    struct MIKKY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIKKY>>(0x2::coin::mint<MIKKY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIKKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8D7DtJjrePKiHjueoNkqu2WTwoPerZNpqVtMTKECpump.png?size=lg&key=3e807d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIKKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MIKKY   ")))), trim_right(b"Mikky                           "), trim_right(x"4d494b4b593a2041206c6974746c652074726f75626c656d616b657220776974682062696720647265616d7320616e6420616e206576656e2062696767657220736d696c65212048657320626c75652c20626f756e63792c20616e6420616c7761797320757020666f7220616e20616476656e747572652e20576974682068697320676f6f6679206772696e20616e6420656e646c65737320656e657267792c204d696b6b792073707265616473206a6f7920776865726576657220686520676f65730020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKKY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIKKY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIKKY>>(0x2::coin::mint<MIKKY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

