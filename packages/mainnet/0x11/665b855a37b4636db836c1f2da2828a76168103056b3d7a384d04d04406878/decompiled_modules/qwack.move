module 0x11665b855a37b4636db836c1f2da2828a76168103056b3d7a384d04d04406878::qwack {
    struct QWACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ci29P8UHBaQVX752CRhD3btuqDh4mA4Mzqb1Ucjpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QWACK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QWACK       ")))), trim_right(b"Peeking Duck                    "), trim_right(x"5065656b696e67204475636b3a20546865204d656d6520436f696e20546861747320416c77617973205761746368696e670a0a24515741434b20697320696e73706972656420627920616e61746964616570686f6269617468652066656172207468617420736f6d6577686572652c20736f6d65686f772c2061206475636b206973207761746368696e6720796f752e2057697468205065656b696e67204475636b2c207468617420706172616e6f6961206265636f6d657320796f757220706f7765722e0a0a4b656570206f6e6520657965206f6e20746865206475636b7320696e2074686520706f6e6420616e6420746865206f74686572206f6e20746865206368617274732c20617320776520656d627261636520746865206162737572642c206c61756768206174206f75722066656172732c20616e642024515741"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWACK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWACK>>(v4);
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

