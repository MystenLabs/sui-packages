module 0x552b4cb5d794713005a26c4c063cee8d54ea0088edbb8d80b90ef0681fa095dd::haruka {
    struct HARUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7uj3UDY8RWP4K7dwv5EyCUsjJH3qm8vz7YnjMkuDpump.png?size=lg&key=596268                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HARUKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HARUKA  ")))), trim_right(b"Haruka                          "), trim_right(b"Haruka, as a meme token, represents the essence of a curious and adventurous mind, always discovering new ideas and sharing them with those around her. Shes the kind of friend who encourages open conversations, fills silences with warmth, and turns casual chats into memorable exchanges.                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARUKA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARUKA>>(v4);
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

