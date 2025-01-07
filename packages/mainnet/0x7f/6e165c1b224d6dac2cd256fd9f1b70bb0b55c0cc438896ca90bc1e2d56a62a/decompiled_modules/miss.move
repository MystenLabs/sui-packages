module 0x7f6e165c1b224d6dac2cd256fd9f1b70bb0b55c0cc438896ca90bc1e2d56a62a::miss {
    struct MISS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MISS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MISS>>(0x2::coin::mint<MISS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MISS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MISS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MISS>(arg0, 0, b"MISS", b"Dev is Missing", b"Dev is Missing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1708369409796-052ef0cc27f9f85b5fe257254561c9eb.jpg"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MISS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MISS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MISS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

