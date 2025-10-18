module 0xd93274425c8673d78fefea41e176d2bad936afd529533acff4678159c67792c0::usdugc {
    struct USDUGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDUGC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d84a39c521b5a2f55c35f89c54a4748e48eb0ec9506ff5e6e1e41378c21675c9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDUGC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDUGC      ")))), trim_right(b"Unstable Gold Coin              "), trim_right(x"4649525354202455534455474320474f4c4420544f4b454e204f4e20534f4c414e410a0a54484520474f4c44204d455441204953204f4e204649524520414e44205448495320495320544845204e455854204249472052554e4e45522d2031303025204f5247414e494320414e442054484520415254574f524b20495320412050455246454354205553445543204d415443482e0a0a242020425559202d20484f4c44202d2054454c4c20465249454e44532020240a0a414e4420434f4d4520462a434b205749544820555320464f52205245414c20414e44204a4f494e20544845205820434f4d4d554e49545921202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDUGC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDUGC>>(v4);
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

