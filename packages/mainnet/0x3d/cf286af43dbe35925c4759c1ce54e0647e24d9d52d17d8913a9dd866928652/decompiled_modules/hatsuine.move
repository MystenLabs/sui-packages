module 0x3dcf286af43dbe35925c4759c1ce54e0647e24d9d52d17d8913a9dd866928652::hatsuine {
    struct HATSUINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATSUINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/Qmb7ZBsUDXqgh5WDvJYXCfcXugtjkJYi25yznEy2S8UDYJ                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HATSUINE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HATSUINE")))), trim_right(b"HatSUIne Miku                   "), trim_right(x"4861745355496e65204d696b75206973206120636f6d6d756e6974792064726976656e20746f6b656e206261736564206f6e2073686172696e6720746865206d7573696320666f722065766572796f6e65210a4a6f696e207468652062616e64206f6e207468652077617920746f20746865206d6f6f6e2077697468207573210a4279206372656174696e67206120666f756e646174696f6e616c20616e6420756e6971756520746f6b656e206f6e20535549204861745355496e652061696d7320746f2070726f7669646520616e2065636f73797374656d20746861742065766572796f6e652063616e2075736520616e64206265206170617274206f662e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATSUINE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATSUINE>>(v4);
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

