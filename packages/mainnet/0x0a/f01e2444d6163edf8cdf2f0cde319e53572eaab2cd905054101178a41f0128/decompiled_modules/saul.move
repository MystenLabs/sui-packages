module 0xaf01e2444d6163edf8cdf2f0cde319e53572eaab2cd905054101178a41f0128::saul {
    struct SAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2xJNHd6Mtopy68yrE6cJ7AD152LNREFiU24QZVMRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAUL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAUL        ")))), trim_right(b"Bettor Called Saul              "), trim_right(x"506c61636520796f757220626574732077697468205341554c0a0a54686520666972737420646563656e7472616c697a65642073706f7274732062657474696e672070726f746f636f6c206f6e20536f6c616e6120776974682070726f7661626c792066616972206f6464732c207a65726f20666565732c20616e6420696e7374616e74207061796f7574732e0a0a4167656e7469632062657474696e672c206163726f737320616c6c206d61726b6574730a0a245341554c202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUL>>(v4);
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

