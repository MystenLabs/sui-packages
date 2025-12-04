module 0x1fb11de412a9a817b6baaddb16af48f2cbfa7aa8bbf14682bb40e7002d74c011::plotting {
    struct PLOTTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOTTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"21b84120d6740f4340973625318657795d3b78fe87b8fb0363437f700d4a2505                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PLOTTING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Plotting    ")))), trim_right(b"Im plotting on your rise bro    "), trim_right(x"496d20706c6f7474696e67206f6e20796f757220726973652062726f2e200a0a496d206c69746572616c6c7920757020696e20746865206c616220736368656d696e67206f6e2062656175746966756c206162756e64616e636520666f7220796f752e200a0a496d20636f6f6b696e67207570207761797320666f72206120726973696e67207469646520746f206c69667420616c6c206f757220626f6174732e200a0a496d2070726179696e6720666f7220796f7572206761696e732e200a0a496d206c69676874696e6720612063616e646c6520746f20796f757220696e6576697461626c652073706c656e646f757220647564652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOTTING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOTTING>>(v4);
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

