module 0xc81ef8726c6f9b02a700efb65ed287e76f8ea9d8c0854dea573aca798d1ed887::trumpwifmusk {
    struct TRUMPWIFMUSK has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPWIFMUSK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPWIFMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPWIFMUSK>(arg0, 9, b"TrumpWifMusk", b"TrumpWifMusk", b"TrumpWifMusk Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPWIFMUSK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIFMUSK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIFMUSK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPWIFMUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPWIFMUSK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

