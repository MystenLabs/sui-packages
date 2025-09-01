module 0x921f80d4b42ee5f0a0e5257f3803ff870bbf70d0a1cfb99c6e4461c4820a3018::ttttt {
    struct TTTTT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTTTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTTTT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeicsdnaczd47sflg3axmhtjlwc753hp2a35w4isbsgyez6cqwut664";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeicsdnaczd47sflg3axmhtjlwc753hp2a35w4isbsgyez6cqwut664"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTTTT>(arg0, 9, b"TTTTT", b"TTTTT", b"TTTTT Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTTTT>>(0x2::coin::mint<TTTTT>(&mut v5, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTTT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTTTT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTTTT>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

