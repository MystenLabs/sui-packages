module 0x3e57f3020d4a239cafe437be0659034f14535ad18d16b5903d32c63ce2d0d06a::mgtrn {
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
        let (v2, v3) = 0x2::coin::create_currency<MGTRN>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MGTRN   ")))), trim_right(b"MEGATRON                        "), trim_right(x"544f4b454e204445534352495054494f4e0a0a49742069732061206869676820706f77657265642067616d696e6720746f6b656e2064657369676e656420746f206675656c20616e20657870616e7369766520696e746572636f6e6e65637465642065636f73797374656d206f66206469676974616c20776f726c647320656d706f776572696e6720626f746820706c617965727320616e6420646576656c6f7065727320497420756e6c6f636b73206e657720706f73736962696c69746965732077697468696e207468652067616d696e6720756e69766572736520656e61626c696e6720696e2067616d6520707572636861736573206578636c75736976652072657761726473207374616b696e67206f70706f7274756e697469657320616e6420646563656e7472616c697a656420676f7665726e616e636520202020"), v1, arg1);
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

