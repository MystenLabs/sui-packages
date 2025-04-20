module 0x5eac2721a1299a8a85abe6e6c7bd7d0c516c0c9948ebbcd0b620be48a004494a::eggza {
    struct EGGZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EYo8a84URq6pEgnb9LtCwdAoEMjUZVwm1SXo3L1Fxnaj.png?claimId=CfdUhPrdZFM56724                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EGGZA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EGGZ        ")))), trim_right(b"$Eggzilla                       "), trim_right(x"546865206d656d6520636f696e207468617420637261636b65642074686520536f6c616e6120636861727473200a426f726e20746f20726169642c206275696c7420746f206d6f6f6e2020244547475a20697320706f7765726564206279207075726520636f6d6d756e69747920656e6572677920616e64206d656d65206d6f6d656e74756d2e0a4e6f20796f6c6b732c206a7573742076696265732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGZA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGZA>>(v4);
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

