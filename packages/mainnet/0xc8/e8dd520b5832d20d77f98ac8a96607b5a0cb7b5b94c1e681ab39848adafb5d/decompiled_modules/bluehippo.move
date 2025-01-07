module 0xc8e8dd520b5832d20d77f98ac8a96607b5a0cb7b5b94c1e681ab39848adafb5d::bluehippo {
    struct BLUEHIPPO has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEHIPPO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEHIPPO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUEHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEHIPPO>(arg0, 9, b"BlueHippo", b"Sui Blue Hippo", b"Sui Blue Hippo Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/blue-hippo_7122-19.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEHIPPO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEHIPPO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEHIPPO>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEHIPPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEHIPPO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEHIPPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

