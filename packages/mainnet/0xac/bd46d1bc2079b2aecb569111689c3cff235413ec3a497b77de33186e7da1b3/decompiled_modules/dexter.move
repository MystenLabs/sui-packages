module 0xacbd46d1bc2079b2aecb569111689c3cff235413ec3a497b77de33186e7da1b3::dexter {
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
        let (v3, v4) = 0x2::coin::create_currency<DEXTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEXTER      ")))), trim_right(b"Dexter AI                       "), trim_right(x"444558544552200a0a5b66756c6c20737461636b20783430325d0a44657874657220414920697320626f7468206120766572746963616c6c792d696e7465677261746564206f7065726174696e672073797374656d20616e6420616e20783430322d62617365642065636f6e6f6d7920666f7220696e746572616374697665204149206167656e74732e20446578746572277320666163696c697461746f7220636861726765732072656475636564206665657320666f72207472616e73616374696f6e73207369676e656420627920446578746572206167656e74732e0a0a5b6f6e6520627261696e2c20657665727920737572666163655d0a596f752063616e20776f726b207769746820796f757220446578746572206167656e74206f6e20582c20436861744750542c20436c617564652c2054656c656772616d2c20"), v2, arg1);
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

