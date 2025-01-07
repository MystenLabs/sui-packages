module 0x8e1060d3d3853e21b5828e968a4f236e946a80d2be3dbb6ccbc614424ec1a0f3::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCKEY>>(0x2::coin::mint<DUCKEY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xdc69c06e796ddbe2ca5e3d99f6fd8c40dfd9584a.png?size=lg&key=1a4eb9                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DUCKEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Duckey  ")))), trim_right(b"DUCKEY                          "), trim_right(b"Duckey is more than just a cute figure; he's a mix of whimsy and deep introspection. With Furies signature touch, Ducky brings out a world where innocence meets complexityperfect for the wild ride of crypto! Whimsical yet Dark, Just like Crypto!                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKEY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DUCKEY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCKEY>>(0x2::coin::mint<DUCKEY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

