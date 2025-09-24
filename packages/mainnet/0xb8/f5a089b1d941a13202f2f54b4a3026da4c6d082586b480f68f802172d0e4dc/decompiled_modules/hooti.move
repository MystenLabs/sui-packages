module 0xb8f5a089b1d941a13202f2f54b4a3026da4c6d082586b480f68f802172d0e4dc::hooti {
    struct HOOTI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOOTI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOOTI>>(0x2::coin::mint<HOOTI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HOOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/5f446f2c0bfc9a66033d9a851c0fc3f1f145e0ab49b4889de9a51154b8a850b0?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOOTI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HOOTI   ")))), trim_right(b"HOOTI                           "), trim_right(b"Behold $HOOTI  the owl that watched Doge chase its tail, Shiba dig holes, and Pepe drown in his own memes then calmly decided to fly straight past the circus.                                                                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOTI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOOTI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOOTI>>(0x2::coin::mint<HOOTI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

