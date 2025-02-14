module 0x5538e9c188259eea87532369e5ace2b8f848a8a2d4bf76fb416392c3e9dfa1d3::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HHbkmJw49HLJehxPh2M16EFuF5CKFNxY1HeBYNY4pump.png?claimId=WSJVZrn1qpAfMxzt                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHIBA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHIB        ")))), trim_right(b"SHIB on SOL                     "), trim_right(x"53686962206f6e20536f6c2020546865206e6577204f472120546869732043544f20697320706179696e67207472696275746520746f207768617420536869622077617320696e20323032312e200a0a412066756e2c20756e61706f6c6f6765746963206d656d65207468617420646f65736e742074616b6520697473656c6620746f6f20736572696f75736c79202d206261636b65642062792061207465616d206f662072656c656e746c657373206772696e6465727320616e64206d61726b6574696e6720677572757320746861742077696c6c206769766520746865206f726967696e616c205368696220612072756e20666f7220697473206d6f6e65792e20536f6c616e61206e6565647320536869622e2045766572796f6e65206e6565647320536869622e0a0a41206e657720626567696e6e696e672073746172"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBA>>(v4);
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

