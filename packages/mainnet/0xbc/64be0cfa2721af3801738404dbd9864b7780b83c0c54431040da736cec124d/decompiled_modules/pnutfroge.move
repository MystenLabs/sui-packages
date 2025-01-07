module 0xbc64be0cfa2721af3801738404dbd9864b7780b83c0c54431040da736cec124d::pnutfroge {
    struct PNUTFROGE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTFROGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PNUTFROGE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PNUTFROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PNUTFROGE>(arg0, 9, b"PnutFroge", b"PnutFroge", b"PnutFroge Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PNUTFROGE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTFROGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTFROGE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PNUTFROGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTFROGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PNUTFROGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

