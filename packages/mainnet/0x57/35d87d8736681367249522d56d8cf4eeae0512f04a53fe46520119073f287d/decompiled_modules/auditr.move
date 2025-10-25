module 0x5735d87d8736681367249522d56d8cf4eeae0512f04a53fe46520119073f287d::auditr {
    struct AUDITR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUDITR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ea3b1fa53df94b2c7aa865a7771a57a5c563c6b67d8e65a6ba9e314e47a77691                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AUDITR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AUDITR      ")))), trim_right(b"Auditr                          "), trim_right(x"536d61727420436f6e7472616374205365637572697479204d6164652053696d706c650a0a50726f66657373696f6e616c2041492d706f77657265642061756469747320666f7220536f6c616e6120616e642045564d20636f6e7472616374732e20436f6d70726568656e7369766520736563757269747920616e616c7973697320706f776572656420627920414920616e6420696e6475737472792d6c656164696e6720746f6f6c732e202431303020666c617420726174652e20526573756c747320696e206d696e757465732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUDITR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUDITR>>(v4);
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

