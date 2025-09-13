module 0x8085a1bf427dac400d4fdc3be1c97fa1af0045040c577206cc284dcedc3d143b::wizb {
    struct WIZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a2bd11a02841519a85319fead20961b4934320b2bad796104f7db568332a9fae                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WIZB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WIZB        ")))), trim_right(b"The Wizard of Buyback           "), trim_right(x"546865206669727374206578706572696d656e74616c2073747265616d20746f6b656e2066756c6c792064656469636174656420746f206275796261636b732e2044657369676e656420746f207468726f772067617320746f2074686520666972652e2e2e204e6f2067726565647920646576732c206e6f20727567732026206e6f206661726d696e67204a75737420676f6f6420746f6b656e6f6d69637320616e6420736f6d65206d616769632e0a0a393025204275796261636b203130252046656520202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZB>>(v4);
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

