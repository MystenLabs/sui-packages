module 0xd7c56ef5c86dc656c243a4d4102bb77895e15ef6882a82bb191f7e3abc0b9543::maiko {
    struct MAIKO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAIKO>, arg1: vector<0x2::coin::Coin<MAIKO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MAIKO>>(&mut arg1);
        0x2::pay::join_vec<MAIKO>(&mut v0, arg1);
        0x2::coin::burn<MAIKO>(arg0, 0x2::coin::split<MAIKO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MAIKO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MAIKO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MAIKO>(v0);
        };
    }

    fun init(arg0: MAIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/Qmdarc4m8L1mQ7gYN6hdPheMhidUFPjhrAABmgmAYoUWdC"));
        let (v2, v3) = 0x2::coin::create_currency<MAIKO>(arg0, 7, b"MK", b"MAIKO", b"MAIKO", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIKO>>(v3);
        0x2::coin::mint_and_transfer<MAIKO>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIKO>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAIKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAIKO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MAIKO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAIKO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

