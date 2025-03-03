module 0x967d2728778b483053fdd2af23e00eb977513879027b1b22d78fa8c227d66d08::pmpa {
    struct PMPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4TYK5ojqkG7EREAmn2gbuHBocUXfNth32Mp3F84Q28fp.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PMPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PMP         ")))), trim_right(b"Pepes Money Printer             "), trim_right(b"PepeMoneyPrinter ($PMP) - A memecoin thats more than just a laugh! Hold $PMP and watch your wallet grow with juicy rewards paid out in SOL. this Pepe-inspired token combines meme culture with real utility. Stake it, hold it, and let the money printer go brrr!                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMPA>>(v4);
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

