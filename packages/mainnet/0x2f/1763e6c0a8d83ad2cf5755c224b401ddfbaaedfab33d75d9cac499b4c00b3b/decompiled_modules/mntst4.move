module 0x2f1763e6c0a8d83ad2cf5755c224b401ddfbaaedfab33d75d9cac499b4c00b3b::mntst4 {
    struct MNTST4 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNTST4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MNTST4>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MNTST4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeifp5u722ndvoio4v53jkvyfi4fvnj3vgcd4yf2zun5ar25x56mwbu";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeifp5u722ndvoio4v53jkvyfi4fvnj3vgcd4yf2zun5ar25x56mwbu"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MNTST4>(arg0, 9, b"MNTST4", b"MNTST4", b"DONT BUY Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MNTST4>>(0x2::coin::mint<MNTST4>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTST4>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MNTST4>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNTST4>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

