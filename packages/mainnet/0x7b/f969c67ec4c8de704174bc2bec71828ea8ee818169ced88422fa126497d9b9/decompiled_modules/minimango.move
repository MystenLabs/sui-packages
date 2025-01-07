module 0x7bf969c67ec4c8de704174bc2bec71828ea8ee818169ced88422fa126497d9b9::minimango {
    struct MINIMANGO has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIMANGO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MINIMANGO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MINIMANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MINIMANGO>(arg0, 9, b"MiniMango", b"MiniMango", b"MiniMango Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MINIMANGO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIMANGO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIMANGO>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MINIMANGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIMANGO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MINIMANGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

