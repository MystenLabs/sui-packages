module 0x7ffff87961f321a151b52fef78ee4d073e7597cdfcaf4d12c4b1d3eccb3f3659::bubacat {
    struct BUBACAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUBACAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUBACAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BUBACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUBACAT>(arg0, 9, b"BubaCat", b"Sui Buba Cat", b"Sui Buba Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BUBACAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBACAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBACAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUBACAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUBACAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUBACAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

