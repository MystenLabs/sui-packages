module 0xf3fd7fd6349a25ff70ef9c798cc69e6db6688526bcc6a95bb718536f8959ddc::bitcoinnetwork {
    struct BITCOINNETWORK has drop {
        dummy_field: bool,
    }

    public entry fun add_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITCOINNETWORK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BITCOINNETWORK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BITCOINNETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BITCOINNETWORK>(arg0, 2, b"BITCOINNETWORK", b"BITCOIN NETWORK SUI", b"THIS IS BITCOIN NETWORK SUI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOINNETWORK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINNETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BITCOINNETWORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCOINNETWORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITCOINNETWORK>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITCOINNETWORK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BITCOINNETWORK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

