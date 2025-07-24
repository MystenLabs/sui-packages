module 0x103a5484e7b3b42bc5b684a2249fda06857b481765c3486b5f7f3a425df85618::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ECesgiZHYtJuGjTib64CdEhWfNr9qKUrkFT6MNsfbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHIBI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Chibi       ")))), trim_right(b"Chibi                           "), trim_right(b"Chibi, is an art style originating in Japan, and common in anime and manga where characters are drawn in an exaggerated way, typically small and chubby with stubby limbs, oversized heads, and minimal detail. The style has found its way into the anime and manga fandom through its usage in manga works and merchandising. "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBI>>(v4);
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

