module 0x104cc1b40b078ab5aa7fd25eb1e79e0a5caa498bf082453d8bbfdabad5bc2dfb::oswald {
    struct OSWALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSWALD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CAZm4pVTLjxFLtB8aRQRe1K3KfQb6L7CepAVvSvgJvEx.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OSWALD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OSWALD      ")))), trim_right(b"Lee Harvey Oswald               "), trim_right(x"4172652077652061626f757420746f207265777269746520686973746f72793f0a0a466f72206f7665722036302079656172732c207468652074727574682061626f7574204a464b7320617373617373696e6174696f6e20686173206265656e206c6f636b656420617761792e204c656520486172766579204f7377616c642077617320636861726765642c2062757420776173206865207265616c6c7920746865206c6f6e652067756e6d616e6f72206a7573742061207061776e20696e2061206d756368206269676765722067616d653f2054686520636f6e73706972616379207468656f72696573206861766520726167656420666f7220646563616465732c20627574206e6f772c207468652077616974206973206f7665722e0a0a5468652066696e616c204a464b2066696c657320617265206265696e67207265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSWALD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSWALD>>(v4);
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

