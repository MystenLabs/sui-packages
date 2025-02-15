module 0xf3dc941a96e7241ce9a0e1a4ff5ff14a35ac9e7e05c17d2b459fb1f6fa663e9c::arghhh {
    struct ARGHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4tRN4nCsqZJp4vMYfqBYSwbxaN2zxdgMbt2B67K8pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ARGHHH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ARGHHH      ")))), trim_right(b"Arjeetina                       "), trim_right(x"57544620417267656e74696e61213f0a0a596f7520736169642c20224c65747320656e636f75726167652067726f77746820616e642073686f772074686520776f726c6420737570706f72747320417267656e74696e6121222042757420696e73746561642c20796f752072756767656420666173746572207468616e2061207363616c706572206f6e206c61756e63682064617921204d6f7265206c696b652041724a4545454554696e612c20616d6972697465213f200a0a5765206a75737420676f74204861776b20547561686420627920616e20656e7469726520636f756e7472792e0a0a205461726966662045766572797468696e672e20527567204e6f7468696e672e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGHHH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGHHH>>(v4);
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

