module 0x3a70005b229044ce3a024f5e3c83a6156ac7c6e65ffa81d45474b73d05fb8f9c::virgin {
    struct VIRGIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRGIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"41929cb4e38e7c01e71b468d570286858e3bb4e0c48453b5eddf5e306db53aac                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIRGIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Virgin      ")))), trim_right(b"Virgin                          "), trim_right(b"The well known virgin vs chad meme has over 1.8m+ visits on knowyourmeme, while chad has flourished, Virgin has yet to be meme'd properly, largely due to lack of content. Virgin encompasses everything opposite of chad. It's time to make a stand.                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRGIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRGIN>>(v4);
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

