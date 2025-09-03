module 0x96b2395c162406d62d287e69f7d61e4051a57767b74738e9b69eb4d1ee26422a::ttt777 {
    struct TTT777 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT777>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTT777>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTT777, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreidldues5yuhrwueobsiuskuyunaphzq2s5t23zsdbxhtyo656xnam";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreidldues5yuhrwueobsiuskuyunaphzq2s5t23zsdbxhtyo656xnam"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTT777>(arg0, 9, b"TTT777", b"TTT777", b"TTT777 token on SUI blockchain Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT777>>(0x2::coin::mint<TTT777>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT777>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTT777>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT777>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

