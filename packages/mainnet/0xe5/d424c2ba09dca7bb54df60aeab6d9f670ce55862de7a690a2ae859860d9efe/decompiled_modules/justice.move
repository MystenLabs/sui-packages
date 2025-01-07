module 0xe5d424c2ba09dca7bb54df60aeab6d9f670ce55862de7a690a2ae859860d9efe::justice {
    struct JUSTICE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUSTICE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JUSTICE>>(0x2::coin::mint<JUSTICE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JUSTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DGagMywvLG3DwffZHX4eWWE6svnoJpiod3dSNBDwpump.png?size=lg&key=40c02c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JUSTICE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JUSTICE ")))), trim_right(b"Justice for Pnut and Fred       "), trim_right(b"This is more than just another meme coin. Backed by Mark Longo, the Dad of Pnut and Fred, this project seeks JUSTICE and recognition for their story.                                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTICE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUSTICE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<JUSTICE>>(0x2::coin::mint<JUSTICE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

