module 0x827d54575e93ed1a3fbf57b4850399ad9fbda5947807dd900aeb477d3dac8a25::neuro {
    struct NEURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HSkH8nbWR9vyjfUz1m5yimKPwnmstmKg4jaNRWJmpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEURO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEURO       ")))), trim_right(b"NeuroAI                         "), trim_right(x"4e6575726f41492069732061206e6578742d67656e206d656e74616c2077656c6c6e65737320706c6174666f726d20636f6d62696e696e672041492d706f7765726564206d6f6f6420616e616c797369732c20706572736f6e616c697a656420746865726170792063686174626f74732c207265616c2d74696d6520656d6f74696f6e616c20747261636b696e672c20616e6420626c6f636b636861696e2d7365637572656420707269766163792e0a0a5265696d6167696e696e6720686f7720776520756e6465727374616e6420616e6420737570706f7274206d656e74616c2077656c6c2d6265696e672e0a0a546865206d6f737420616476616e63656420746f6f6c20746f20636865636b20796f757220656d6f74696f6e616c207374617465206265666f7265206d616b696e67206465636973696f6e732e20202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURO>>(v4);
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

