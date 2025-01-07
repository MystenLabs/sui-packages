module 0x48460dc6c15c1e707c9e76b65c291888ccef1fa9d5750da423cc413487e5e5ef::minipandy {
    struct MINIPANDY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIPANDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MINIPANDY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MINIPANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MINIPANDY>(arg0, 9, b"MiniPandy", b"Mini Pandy", b"Mini Pandy Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MINIPANDY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIPANDY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIPANDY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MINIPANDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIPANDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MINIPANDY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

