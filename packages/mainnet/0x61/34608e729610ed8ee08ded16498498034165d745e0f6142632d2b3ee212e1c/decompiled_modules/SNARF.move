module 0x6134608e729610ed8ee08ded16498498034165d745e0f6142632d2b3ee212e1c::SNARF {
    struct SNARF has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNARF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SNARF>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SNARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SNARF>(arg0, 6, b"SNARF", b"Sui Snarf", b"Snarf is the diamond paw cat, ready to fuss it out in the sui meme space, while snarfing with other cats on sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmU3mckpeZcyWvxr4JG5nWdRNZpUQTUiUf7gLhXBFoATnP?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNARF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SNARF>>(0x2::coin::mint<SNARF>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNARF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SNARF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<SNARF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SNARF>>(0x2::coin::mint<SNARF>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNARF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SNARF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

