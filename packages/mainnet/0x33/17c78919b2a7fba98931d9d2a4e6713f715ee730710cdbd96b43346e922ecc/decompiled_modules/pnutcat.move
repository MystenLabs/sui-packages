module 0x3317c78919b2a7fba98931d9d2a4e6713f715ee730710cdbd96b43346e922ecc::pnutcat {
    struct PNUTCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PNUTCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PNUTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PNUTCAT>(arg0, 9, b"PnutCat", b"Sui Pnut Cat", b"Sui Pnut Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PNUTCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PNUTCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PNUTCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

