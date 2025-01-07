module 0x5baac089874d78e3a4ee396df938d8992b98ea4ffee2df2f5d4cecde39c36bd3::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HONEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HONEY>>(0x2::coin::mint<HONEY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x70d9e6df4ec90f9e73d51d4d61e93d62db035570.png?size=lg&key=a636dc                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HONEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HONEY   ")))), trim_right(b"Justice For Honey               "), trim_right(x"486f6e65792c20612032372d796561722d6f6c6420626c61636b206265617220616e6420737461722061747472616374696f6e20617420612073746174652d6c6963656e73656420616e696d616c20726566756765206f6e204c6f6e672049736c616e64207761732065757468616e697a6564206c617374206d6f6e7468206166746572207768617420616e696d616c206164766f636174657320616c6c65676520776173207965617273206f6620686f727269666963206e65676c65637420616e64206c61636b206f66206d65646963616c2063617265206174207468652074617870617965722d66756e64656420666163696c6974792e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HONEY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HONEY>>(0x2::coin::mint<HONEY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

