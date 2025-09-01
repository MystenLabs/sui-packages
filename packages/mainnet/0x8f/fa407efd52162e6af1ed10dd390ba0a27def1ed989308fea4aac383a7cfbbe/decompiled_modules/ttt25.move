module 0x8ffa407efd52162e6af1ed10dd390ba0a27def1ed989308fea4aac383a7cfbbe::ttt25 {
    struct TTT25 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT25>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTT25>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTT25, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeigy2vhmpofxrszv2sq243wlzros3y35nglubzz2tyfxcaotkbilgu";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeigy2vhmpofxrszv2sq243wlzros3y35nglubzz2tyfxcaotkbilgu"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTT25>(arg0, 9, b"TTT25", b"TTT25", b"TTT25 token on SUI blockchain Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT25>>(0x2::coin::mint<TTT25>(&mut v5, 999998000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT25>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTT25>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT25>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

