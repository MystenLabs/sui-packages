module 0x76cbe3f14ed1b2213d53b8f128d8f933d8a7538dd1306b12be3ab21b6e290434::aaatremp {
    struct AAATREMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAATREMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAATREMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAATREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAATREMP>(arg0, 9, b"AAATremp", b"AAATremp", b"AAATremp Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AAATREMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAATREMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAATREMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAATREMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAATREMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AAATREMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

