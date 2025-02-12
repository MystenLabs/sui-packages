module 0x801aa980f43bfd2e4779c18e98caba4527518bebe0382a81c75b3cc42065551d::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5N2farV817EhTzhawT33scRYd8Vv69pMkFEbEeThpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CT          ")))), trim_right(b"CIRCUMCISED TRUMP               "), trim_right(x"2043495243554d4349534544205452554d50200a2043495243554d4349534544205452554d50204953204c49564520203130305820504f54454e5449414c21200a20446f6e2774204d697373204f757420204561726c79204275796572732057696e2042494721200a0a20544f4b454e204e414d453a2043495243554d4349534544205452554d500a2043413a20354e32666172563831374568547a68617754333373635259643856763639704d6b4645624565546870756d700a204445583a20354e32666172563831374568547a68617754333373635259643856763639704d6b4645624565546870756d700a20426c6f636b636861696e3a20536f6c616e610a20547769747465722f583a20436972637472756d700a2054656c656772616d2047726f75703a204043495243554d43495345445452554d500a0a20576879"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CT>>(v4);
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

