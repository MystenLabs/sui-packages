module 0x843d70ab515da6adbb4a38bcd8fa59cb45ffc66b1e0e1f46b382ed088aaac9ae::npcs {
    struct NPCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5ToDNkiBAK6k697RRyngTburU7yZNFZFx7jzsD1Uc7pK.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NPCS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NPCS        ")))), trim_right(b"NPC Solana                      "), trim_right(x"244e504353202d204e6f6e2d506c617961626c6520436f696e206f6e20536f6c616e612e2041204d656d6520466f7220414c4c20536f6c616e61204e504327732e200a0a446567656e277320756e6974652e2054686973206973206e6f2070756d7020616e642064756d702c207468697320697320746865206e657874206772656174657374206d656d6520636f696e206f6e20746865206d61726b65742c206261736564206f6666206f6e65206f662074686520776f726c642773206d6f7374207265636f676e697a61626c65206d656d6527732e202431626e206d61726b6574636170206265636b6f6e732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPCS>>(v4);
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

