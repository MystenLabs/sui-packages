module 0xbaa4526cce666ab4b12aa773d15f4fbbcd4eca41f50b3a705311e5c801ac0c82::ttt555 {
    struct TTT555 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT555>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTT555>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTT555, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeia5ezg6p3lh2u4nytkm7vcmmm7kxdhktppdcs2nebhvoqe3rtacru";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeia5ezg6p3lh2u4nytkm7vcmmm7kxdhktppdcs2nebhvoqe3rtacru"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTT555>(arg0, 9, b"TTT555", b"TTT555", b"Do Not buy. This is test. Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT555>>(0x2::coin::mint<TTT555>(&mut v5, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT555>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTT555>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT555>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

