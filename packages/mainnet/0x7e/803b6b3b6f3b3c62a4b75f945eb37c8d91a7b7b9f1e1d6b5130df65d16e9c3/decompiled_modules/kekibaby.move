module 0x7e803b6b3b6f3b3c62a4b75f945eb37c8d91a7b7b9f1e1d6b5130df65d16e9c3::kekibaby {
    struct KEKIBABY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KEKIBABY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIBABY>>(0x2::coin::mint<KEKIBABY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KEKIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HbSGfB21xLAE4AVsFhM3p4Xmtb4v4w9hNJUuT6XASnqA.png?size=lg&key=048d33                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KEKIBABY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KEKIBABY")))), trim_right(b"BABY KEKIUS                     "), trim_right(b"Baby Kekius Maximus is a young hero clad in miniature armor, full of courage and charm. With a legendary spirit and iconic visuals, he embarks on an epic journey with his community, bringing a new, adorable heroic tale to life!                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIBABY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKIBABY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIBABY>>(0x2::coin::mint<KEKIBABY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

