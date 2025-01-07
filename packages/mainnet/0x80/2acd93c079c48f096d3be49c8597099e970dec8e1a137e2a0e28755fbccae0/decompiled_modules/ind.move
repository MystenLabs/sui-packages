module 0x802acd93c079c48f096d3be49c8597099e970dec8e1a137e2a0e28755fbccae0::ind {
    struct IND has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IND>, arg1: vector<0x2::coin::Coin<IND>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<IND>>(&mut arg1);
        0x2::pay::join_vec<IND>(&mut v0, arg1);
        0x2::coin::burn<IND>(arg0, 0x2::coin::split<IND>(&mut v0, arg2, arg3));
        if (0x2::coin::value<IND>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<IND>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<IND>(v0);
        };
    }

    fun init(arg0: IND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZwaX32oQLrgkVKtvTZqb72js54W3iKoEH3uXQSwVWb6c"));
        let (v2, v3) = 0x2::coin::create_currency<IND>(arg0, 6, b"IND", b"IND", b"Internet Dogs", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IND>>(v3);
        0x2::coin::mint_and_transfer<IND>(&mut v4, 210000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IND>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IND>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IND>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<IND>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IND>>(arg0);
    }

    // decompiled from Move bytecode v6
}

