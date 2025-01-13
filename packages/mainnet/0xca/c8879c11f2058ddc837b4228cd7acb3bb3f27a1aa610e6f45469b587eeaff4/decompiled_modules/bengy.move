module 0xcac8879c11f2058ddc837b4228cd7acb3bb3f27a1aa610e6f45469b587eeaff4::bengy {
    struct BENGY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BENGY>, arg1: 0x2::coin::Coin<BENGY>) {
        0x2::coin::burn<BENGY>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<BENGY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BENGY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ded7Syr7idwcMx3xPvGewk3HjVVtbXfAkw1mXEMZpump.png?size=lg&key=6c9f6a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BENGY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BENGY     ")))), trim_right(b"BENGY                           "), trim_right(b"$BENGY is a young penguin cub, hardened on the glaciers of the Arctic and inspired by the spirit of Solana. His journey begins by building a solid community of hodlers and crypto-enthusiasts ready to conquer the peaks and change the rules of the game together.                                                            "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENGY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BENGY>>(v5);
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

