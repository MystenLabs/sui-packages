module 0xfd37a84cc10c71269d023238f633c5b22ff463a6c97d61bd0b3218dc2caeb3f3::trumpybear {
    struct TRUMPYBEAR has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPYBEAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPYBEAR>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPYBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPYBEAR>(arg0, 9, b"TrumpyBear", b"Trumpy Bear", b"Trumpy Bear Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPYBEAR>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPYBEAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPYBEAR>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPYBEAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPYBEAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPYBEAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

