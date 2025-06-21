module 0x5cfd67f5e1be3ff2dd8de9b0cc0253588e86e2ab7ad3ae9fe142a974e8a7bc2c::maskfi {
    struct MASKFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASKFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9jTanZaRFKkJxpKjs5zYhEQxdV3Z6qqZsuFDe6upump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MASKFI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MaskFi      ")))), trim_right(b"Maskify                         "), trim_right(b"You can send anonymous or masked solana right on X, claim unregistered assets, and snipe your favorite tokens for max profit. Hit your next 100x with $MaskFI.                                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASKFI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASKFI>>(v4);
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

