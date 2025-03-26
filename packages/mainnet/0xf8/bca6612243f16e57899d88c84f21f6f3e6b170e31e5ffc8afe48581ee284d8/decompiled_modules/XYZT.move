module 0xf8bca6612243f16e57899d88c84f21f6f3e6b170e31e5ffc8afe48581ee284d8::XYZT {
    struct XYZT has drop {
        dummy_field: bool,
    }

    public entry fun add_addresses_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XYZT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<XYZT>(arg0, arg1, arg2);
    }

    fun init(arg0: XYZT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XYZT>(arg0, 2, b"XYZT", b"", b"", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYZT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XYZT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XYZT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XYZT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

