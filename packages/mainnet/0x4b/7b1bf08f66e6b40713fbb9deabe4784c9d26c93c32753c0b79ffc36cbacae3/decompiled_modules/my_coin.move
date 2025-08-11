module 0x4b7b1bf08f66e6b40713fbb9deabe4784c9d26c93c32753c0b79ffc36cbacae3::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg0, arg1);
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MY_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MY_COIN>(arg0, 2, b"GLUB", b"GLUB", b"The GLUB Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/FwRo1fWWwAEeuIU.jpg")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MY_COIN>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MY_COIN>>(v1, v4);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MY_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

