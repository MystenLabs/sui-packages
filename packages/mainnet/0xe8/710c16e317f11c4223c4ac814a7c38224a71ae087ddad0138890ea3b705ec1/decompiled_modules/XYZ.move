module 0xe8710c16e317f11c4223c4ac814a7c38224a71ae087ddad0138890ea3b705ec1::XYZ {
    struct XYZ has drop {
        dummy_field: bool,
    }

    public entry fun add_addresses_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XYZ>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<XYZ>(arg0, arg1, arg2);
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XYZ>(arg0, 2, b"XYZ", b"", b"", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYZ>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XYZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XYZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XYZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

