module 0x3af54903f5f2b43ef10b8bc20d116407afa64e64cc2156f93243684ff1f9dbcf::sltx {
    struct SLTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"pUhV_o9-EQiUtY5K                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SLTX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SLTX        ")))), trim_right(b"SolTax                          "), trim_right(x"20534f4c544158204749564541574159532020594f5552204c415354204348414e4345204245464f5245205441582044415921200d0a0d0a43727970746f2074726164657273206172652050414e49434b494e47206f766572207468656972207461782062696c6c732062757420534f4c5441582028534c5458292068617320796f7572206261636b21204974732074696d6520746f20666c69702074617820736561736f6e20696e746f20796f75722070726f66697420736561736f6e20776974682048554745207765656b6c792067697665617761797320616e642061206c6173742d6d696e757465206a61636b706f742e0d0a0d0a20544158504159455253204241494c4f555420205745454b4c5920534c5458204341534820474956454157415953200d0a476f742061206d617373697665207461782062696c6c3f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLTX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLTX>>(v4);
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

