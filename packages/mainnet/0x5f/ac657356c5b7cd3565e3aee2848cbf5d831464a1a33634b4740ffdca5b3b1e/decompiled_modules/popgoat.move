module 0x5fac657356c5b7cd3565e3aee2848cbf5d831464a1a33634b4740ffdca5b3b1e::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POPGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POPGOAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POPGOAT>(arg0, 9, b"POPGOAT Army", b"POPGOAT", b"The big hype arount Goat now on SUI POPGOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/smile-cartoon-goat-generated-by-ai_979320-61.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POPGOAT>(&mut v3, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPGOAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPGOAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POPGOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POPGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<POPGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

