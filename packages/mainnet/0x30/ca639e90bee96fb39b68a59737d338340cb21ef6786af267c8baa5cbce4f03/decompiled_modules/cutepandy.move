module 0x30ca639e90bee96fb39b68a59737d338340cb21ef6786af267c8baa5cbce4f03::cutepandy {
    struct CUTEPANDY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CUTEPANDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CUTEPANDY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CUTEPANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CUTEPANDY>(arg0, 9, b"CutePandy", b"Sui Cute Pandy", b"Sui Cute Pandy Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CUTEPANDY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTEPANDY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTEPANDY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CUTEPANDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CUTEPANDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CUTEPANDY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

