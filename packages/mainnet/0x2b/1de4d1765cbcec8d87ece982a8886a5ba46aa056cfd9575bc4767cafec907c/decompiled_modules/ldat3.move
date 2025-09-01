module 0x2b1de4d1765cbcec8d87ece982a8886a5ba46aa056cfd9575bc4767cafec907c::ldat3 {
    struct LDAT3 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT3>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreiezqgibdnanukuueqwjswosdzuunvsbomjdo5apxbobnactqp7hqy";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiezqgibdnanukuueqwjswosdzuunvsbomjdo5apxbobnactqp7hqy"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT3>(arg0, 9, b"LDAT3", b"LDAT3", b"dont buy these are test tokens Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT3>>(0x2::coin::mint<LDAT3>(&mut v5, 999998000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT3>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT3>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT3>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

