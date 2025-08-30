module 0x6cdca42497f42228b61243a4b5b7a4acd3c69e60de1800ac09383fedcbe7ee9a::suimntst {
    struct SUIMNTST has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMNTST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMNTST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIMNTST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeibw7gk7iyde4kxuegmcoggq73xpn23t7xol7hrwelldljqxw7zqxy";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeibw7gk7iyde4kxuegmcoggq73xpn23t7xol7hrwelldljqxw7zqxy"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SUIMNTST>(arg0, 6, b"SUIMNTST", b"SUI MN Test Token", b"Just Running a Test or two From my app Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMNTST>>(0x2::coin::mint<SUIMNTST>(&mut v5, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMNTST>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIMNTST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMNTST>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

