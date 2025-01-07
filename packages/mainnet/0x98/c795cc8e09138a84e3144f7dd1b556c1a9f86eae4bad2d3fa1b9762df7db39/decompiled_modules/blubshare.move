module 0x456ec6eb105abef7bc4f70f8e7b8fe32e95567ffd96e18a9e947492e586932d6::blubshare {
    struct BLUBSHARE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUBSHARE>, arg1: 0x2::coin::Coin<BLUBSHARE>) {
        0x2::coin::burn<BLUBSHARE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUBSHARE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUBSHARE>>(0x2::coin::mint<BLUBSHARE>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBSHARE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUBSHARE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUBSHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUBSHARE>(arg0, 2, b"BLUBSHARE", b"BLUB Share", b"BLUB Share of Huski Platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgs-8qx.pages.dev/blubshare.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUBSHARE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = &mut v3;
        mint(v5, 420690000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBSHARE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUBSHARE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBSHARE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUBSHARE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

