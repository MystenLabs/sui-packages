module 0x18e54524441fe61c403d03e48e36d457ff734140ce868f1a72b2a7c003321082::ngi {
    struct NGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GAWZ9XMb761p1ALkbXzS53LiPeaaKue6bCY2tmRzpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NGI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NGI         ")))), trim_right(b"Northrop Grumman Inu            "), trim_right(x"4e4749206973206d6f7265207468616e2061206d656d653a2069747320612073796d626f6c206f6620737465616c746820616e6420706f7765722c20696e737069726564206279204e6f727468726f70204772756d6d616e20616e6420746865206c6567656e6461727920422d322053706972697420537465616c746820426f6d6265722e0a0a4c696b652074686520422d322c204e474920666c69657320756e6465722074686520726164617220616e6420737472696b6573207769746820707265636973696f6e207768656e206c656173742065787065637465642e0a0a537465616c74682d64726f7070696e6720422d32206d656d6573207374726169676874206f6e746f20796f757220626167732e0a0a4e6f727468726f70204772756d6d616e20496e752e20696e76697369626c6520746f2072616461722c2076"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGI>>(v4);
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

