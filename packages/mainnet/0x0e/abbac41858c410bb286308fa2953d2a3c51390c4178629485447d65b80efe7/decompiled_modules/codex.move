module 0xeabbac41858c410bb286308fa2953d2a3c51390c4178629485447d65b80efe7::codex {
    struct CODEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GKTP98LYQDZkMrsKCYLG136dfMUCdYMDvw6GwkZspump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CODEX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CODEX       ")))), trim_right(b"CODEX AI                        "), trim_right(x"456d706f776572696e6720596f757220436f646520776974682041492d506f776572656420507265636973696f6e0a436f646578436f64652070726f76696465732063757474696e672d6564676520414920736f6c7574696f6e7320746f20656e68616e636520796f757220636f64696e6720657870657269656e63652c2073747265616d6c696e6520646576656c6f706d656e742c20616e6420626f6f73742070726f6475637469766974792e205768657468657220796f757265206120626567696e6e6572206f7220616e206578706572742c206f75722041492d64726976656e20746f6f6c73206172652064657369676e656420746f2061737369737420796f752065766572792073746570206f6620746865207761792e20202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODEX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODEX>>(v4);
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

