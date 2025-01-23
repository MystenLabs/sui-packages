module 0xd3015d8d7f9b8a85707181727832fde913f186ad6a685eaa273c8dd851e2fe00::kaida {
    struct KAIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/34xtE4vUQ6gpJEqsBkFtzgSedFrhx55jBrn9XDydpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAIDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KAIDA       ")))), trim_right(b"Kaida                           "), trim_right(x"414749206973206e6f742061207465787420626f780a0a54686973206973204149207468652077617920796f752077616e742069742e200a4561737920746f207573652c206561737920746f20637573746f6d697a6520616e64206d61646520666f7220796f7520616e6420796f757220636c6f736520667269656e64732e200a0a4e6f2070726f6d7074732c206a7573742074617020616e64206c6574204b61696461206272696e67732069646561732c20696e737069726174696f6e2c20616e6420636f6e74656e74207461696c6f726564206a75737420666f7220796f752e0a0a2f4b616964612f206163726f6e796d0a0a4b6e6f776c6564676561626c65206175746f6e6f6d6f757320696e74656c6c6967656e74206461696c79206170706c69636174696f6e202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAIDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAIDA>>(v4);
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

