module 0x20f3ca529465687b260595ecb0a79b2ec563758f2beaf05e5644c90e7e3f885a::kitaa {
    struct KITAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8879afa5d0a3060c69f257d0a3d22d3624c355908ef6d4b90af6c14835ee0791                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KITAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Kita        ")))), trim_right(b"KITA                            "), trim_right(x"20244b4954412020536f6c616e617320416c69656e204d656d652077697468205265616c205574696c6974790a0a4e6f74206a757374206120746f6b656e2020612066756c6c2065636f73797374656d20706f77657265642062792074686520234b49544141726d793a0a0a20547269706c6520506f6f6c732c20547269706c6520506f7765720a0a5261796469756d20534f4c20506f6f6c20205370656564202620566f6c756d6520206c696768746e696e672d66617374207472616465732c207075726520536f6c616e6120656e657267792e0a0a5261796469756d205553444320506f6f6c202053746162696c6974792026204c69717569646974792020636c65616e20656e7472792f65786974207769746820737461626c65636f696e206261636b696e672e0a0a4f70656e426f6f6b204d61726b6574202050726f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITAA>>(v4);
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

