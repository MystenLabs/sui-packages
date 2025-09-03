module 0xfb6c0a18431aa642f824dfa8e34901023f1728454b7a27fb24f5e506e6f4ae0d::ttt454 {
    struct TTT454 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT454>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTT454>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTT454, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeihq76qqcr5goab7d3irlftbtef2emhrvd6dpvy5slragnqjmvmt3a";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeihq76qqcr5goab7d3irlftbtef2emhrvd6dpvy5slragnqjmvmt3a"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTT454>(arg0, 9, b"TTT454", b"TTT454", b"Dont Buy This Token its just a test for: Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT454>>(0x2::coin::mint<TTT454>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT454>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTT454>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT454>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

