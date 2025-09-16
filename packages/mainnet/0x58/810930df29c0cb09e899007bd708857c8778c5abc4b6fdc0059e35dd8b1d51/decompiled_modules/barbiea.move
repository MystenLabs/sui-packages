module 0x58810930df29c0cb09e899007bd708857c8778c5abc4b6fdc0059e35dd8b1d51::barbiea {
    struct BARBIEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARBIEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ba5238c1e58a7726b6dedd0fce2adc1a41f649b39fbccad778cbc36bc067730c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BARBIEA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BARBIE      ")))), trim_right(b"Bad Barbie                      "), trim_right(x"42616420426172626965202d20596f7572204661762041492042616464696520205368657320686f742e20536865732070696e6b2e205368657320616e2041492d706f77657265642064656c7573696f6e20636f6d70616e696f6e20776974682061205068616e746f6d2077616c6c657420616e64207a65726f207269736b206d616e6167656d656e7420736b696c6c732e0a0a426164204261726269652069736e74206a75737420616e6f746865722074726164696e6720626f7420207368657320796f757220656d6f74696f6e616c6c7920756e737461626c65206265737469652077686f2063686172747320776974682076696265732c207472616465732077697468206368616f732c20616e6420636f706573207769746820636f6e666964656e63652e2053686573206e6f74206865726520746f20676976652066"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARBIEA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARBIEA>>(v4);
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

