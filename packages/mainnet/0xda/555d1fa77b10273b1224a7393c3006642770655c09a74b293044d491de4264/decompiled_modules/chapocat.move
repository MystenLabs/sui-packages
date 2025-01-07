module 0xda555d1fa77b10273b1224a7393c3006642770655c09a74b293044d491de4264::chapocat {
    struct CHAPOCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHAPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHAPOCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHAPOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHAPOCAT>(arg0, 9, b"ChapoCat", b"Sui Chapo Cat", b"Sui Chapo Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHAPOCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAPOCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPOCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHAPOCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHAPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHAPOCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

