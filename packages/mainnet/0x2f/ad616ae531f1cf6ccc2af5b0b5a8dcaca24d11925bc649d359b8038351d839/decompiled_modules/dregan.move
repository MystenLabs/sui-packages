module 0x2fad616ae531f1cf6ccc2af5b0b5a8dcaca24d11925bc649d359b8038351d839::dregan {
    struct DREGAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9556a6adb5f263f71aea57e23015cead7f535fa5ca04ad9189236db1d98c2747                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DREGAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DREGAN      ")))), trim_right(b"DREGEN AI                       "), trim_right(x"44524547414e204149202d20536f6c616e612773204d6f73742042756c6c697368205574696c697479204d656d650a0a5468652041492d706f7765726564207574696c697469657320706c6174666f726d2064657369676e656420666f7220747261646572732077686f206d65616e20627573696e6573732e205265616c20746f6f6c732e205265616c207969656c64732e204c696768746e696e6720666173742e0a0a436f72652046656174757265733a0a20536e6970657220426f74202d204175746f2d736e697065207769746820707265636973696f6e20656e7472792f657869740a20414920486f6e6579706f7420446574656374696f6e202d204964656e746966792072756773206265666f726520796f75206c6f73650a204368617274204f7261636c65204149202d2041492d706f7765726564206368617274"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREGAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREGAN>>(v4);
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

