module 0xf3e87877c5e1ca33589b3d5c0e83410f858d49e017b13c963ed39a1c5cf0abc6::stlmntst {
    struct STLMNTST has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STLMNTST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STLMNTST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: STLMNTST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreigeybra44gvii7ebuxt63afxy3ttjyq4edcdjxsjv3pm6bto5shra";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigeybra44gvii7ebuxt63afxy3ttjyq4edcdjxsjv3pm6bto5shra"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<STLMNTST>(arg0, 6, b"STLMNTST", b"STLMNTST", b"Dont buy unless youre willing to throw away your money. Just running a Test. SuitokenLauncher.app - Do not buy this coin please. You will only lose whatever you put in and I'm testing the liquidity stuff throughout so it might fluctuate. Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<STLMNTST>>(0x2::coin::mint<STLMNTST>(&mut v5, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STLMNTST>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<STLMNTST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STLMNTST>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

