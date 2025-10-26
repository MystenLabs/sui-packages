module 0xaf630ce4a8eae44f82aae764ae762ed45a803ac0f1c49be70614a0c5ef994967::dexter {
    struct DEXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"08f8e9c8512281c42cca8814670c7d6d834ef90592ab6d05e9a478f95e1700eb                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEXTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEXTER      ")))), trim_right(b"Dexter AI                       "), trim_right(x"4d65657420446578746572202063727970746f73206669727374206e61746976652043686174475054204170702c20436c6175646520436f6e6e6563746f722c20616e6420736563757265207265616c74696d6520766f696365206167656e742e0a0a2044657874657220436f6e6e6563746f7273206c696e6b20796f75722061757468656e74696361746564204149206167656e7420746f20796f757220536f6c616e612077616c6c65747320736f20796f752063616e207265736561726368206d61726b6574732c2065786563757465207472616465732c20616e64206d6f6e69746f7220796f757220706f7274666f6c696f202a2a6469726563746c7920696e73696465204368617447505420616e6420436c617564652a2a2c206e6f20746563686e6963616c2073657475702072657175697265642e0a0a436c6963"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEXTER>>(v4);
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

