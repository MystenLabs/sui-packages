module 0x9fc36f49ce52b040be9bb7b46d8e54be405a53fcf65f38367190513f37949589::pepercy {
    struct PEPERCY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPERCY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPERCY>>(0x2::coin::mint<PEPERCY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GkCbszv6MMeDXeuoqCk3XHXZzkvLwsoKh5qPoAwYiHdw.png?size=lg&key=009d70                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPERCY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPERCY ")))), trim_right(b"PEPE PERCY                      "), trim_right(b"Elon Musks \"Percy Verence\" $PEPERCY signals an unyielding truth: champions dont fall; they rise anew. This is resilience redefinedfailure is just the forge for stronger beginnings.                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPERCY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPERCY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPERCY>>(0x2::coin::mint<PEPERCY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

