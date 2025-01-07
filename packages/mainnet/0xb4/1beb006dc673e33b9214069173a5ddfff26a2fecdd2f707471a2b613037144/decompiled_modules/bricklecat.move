module 0xb41beb006dc673e33b9214069173a5ddfff26a2fecdd2f707471a2b613037144::bricklecat {
    struct BRICKLECAT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRICKLECAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRICKLECAT>>(0x2::coin::mint<BRICKLECAT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun addToDenyListWrapper(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRICKLECAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BRICKLECAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun executeDenyAction(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRICKLECAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        addToDenyListWrapper(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BRICKLECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BRICKLECAT>(arg0, 9, b"BrickleCat", b"Sui Brickle Cat", b"Sui Brickle Cat Meme Coin", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BRICKLECAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRICKLECAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRICKLECAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BRICKLECAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

