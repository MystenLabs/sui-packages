module 0x9e3167ef56fd43a85fa5464a1df3bf573997aa6189cd65cb2eee62ab3a8d0621::cba {
    struct CBA has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CBA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CBA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CBA>(arg0, 9, b"CBA", b"CBA", b"CBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CBA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<CBA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CBA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

