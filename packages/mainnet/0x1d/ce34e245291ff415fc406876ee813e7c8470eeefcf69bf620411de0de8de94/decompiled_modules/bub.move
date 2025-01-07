module 0x1dce34e245291ff415fc406876ee813e7c8470eeefcf69bf620411de0de8de94::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUB>(arg0, 9, b"BUB", b"BubCat", b"The BubCat $BUB token is a cryptocurrency with a total supply of 2,236,246,453 BUB. It features zero taxes (0/0) and provides a straightforward decentralized approach. The website positions BUBCAT as a simple, meme-driven token for crypto bros.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,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")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BUB>(&mut v3, 2236246453000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

