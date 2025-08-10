module 0xbc078d0be0c341bed6ede3e5746ce273b17a2ec552f21d17438105d0e899c1d0::flb {
    struct FLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/D3JjQzhET8mssgu1nTkA3npsXKju1RQswa5daAwobonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLB         ")))), trim_right(b"Flappy Bonk                     "), trim_right(b"Join the ultimate mobile gaming revolution with $FLB the native utility token powering the Flappy Bonk ecosystem. Built on Solana for lightning-fast transactions and minimal fees, $FLB bridges the gap between classic arcade gaming and modern Web3 innovation.                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLB>>(v4);
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

