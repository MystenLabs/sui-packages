module 0x6250bc0233b9daebff05b22b4eb62a68da66c4bc6c5d94c90c09e7cac0697152::minitrump {
    struct MINITRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINITRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MINITRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MINITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MINITRUMP>(arg0, 9, b"MiniTrump", b"MiniTrump", b"MiniTrump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MINITRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINITRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINITRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MINITRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINITRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MINITRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

