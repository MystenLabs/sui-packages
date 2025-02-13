module 0x4a019861149a9bfe2229a7cf2f6e06507a5265adfdb8878b3c2ad5a567c1ed::mgtrn {
    struct MGTRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGTRN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreigb2cpqo7kav2p5hkbqbsxqw3nwbkfmwddpqbvimm6sagolunwrru                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<MGTRN>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MGTRN   ")))), trim_right(b"MEGATRON                        "), trim_right(b"It is a high powered gaming token designed to fuel an expansive interconnected ecosystem of digital worlds empowering both players and developers It unlocks new possibilities within the gaming universe enabling in game purchases exclusive rewards staking opportunities and decentralized governance                       "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MGTRN>>(0x2::coin::mint<MGTRN>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MGTRN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGTRN>>(v3);
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

