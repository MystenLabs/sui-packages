module 0xbab2b910f22d8aa9840c81ad5588ffcc3ef0da8e4cea448cb82097d746438f79::pnutbunny {
    struct PNUTBUNNY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTBUNNY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PNUTBUNNY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PNUTBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PNUTBUNNY>(arg0, 9, b"PnutBunny", b"Sui Pnut Bunny", b"Sui Pnut Bunny Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.tiktokemoji.com/202410/17/32r1UPeX.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PNUTBUNNY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTBUNNY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTBUNNY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PNUTBUNNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTBUNNY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PNUTBUNNY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

