module 0x766668092a22afcc946ddf91ae186e508bdfce5bba7a97a6248b1a9a8225c668::suibattles {
    struct SUIBATTLES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBATTLES>, arg1: vector<0x2::coin::Coin<SUIBATTLES>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIBATTLES>>(&mut arg1);
        0x2::pay::join_vec<SUIBATTLES>(&mut v0, arg1);
        0x2::coin::burn<SUIBATTLES>(arg0, 0x2::coin::split<SUIBATTLES>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIBATTLES>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIBATTLES>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIBATTLES>(v0);
        };
    }

    fun init(arg0: SUIBATTLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXbH3zeK891U85Woiq7K9g3mFL2FFLbpSTq1143m7x1gk"));
        let (v2, v3) = 0x2::coin::create_currency<SUIBATTLES>(arg0, 7, b"BATTLE", b"SuiBattles", b"X: https://x.com/Sui_Battles  -----  TG: https://t.me/Sui_Battles", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBATTLES>>(v3);
        0x2::coin::mint_and_transfer<SUIBATTLES>(&mut v4, 150000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBATTLES>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBATTLES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBATTLES>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIBATTLES>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIBATTLES>>(arg0);
    }

    // decompiled from Move bytecode v6
}

