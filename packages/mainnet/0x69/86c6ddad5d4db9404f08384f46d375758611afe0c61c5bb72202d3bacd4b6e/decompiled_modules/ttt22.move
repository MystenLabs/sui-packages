module 0x6986c6ddad5d4db9404f08384f46d375758611afe0c61c5bb72202d3bacd4b6e::ttt22 {
    struct TTT22 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT22>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTT22>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTT22, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeifts3mz3us6n6oxzu5zgrtnfeuzdvtpfvoxnbgt2bzva55zzfsegy";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeifts3mz3us6n6oxzu5zgrtnfeuzdvtpfvoxnbgt2bzva55zzfsegy"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTT22>(arg0, 9, b"TTT22", b"TTT22", b"ok Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT22>>(0x2::coin::mint<TTT22>(&mut v5, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT22>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTT22>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT22>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

