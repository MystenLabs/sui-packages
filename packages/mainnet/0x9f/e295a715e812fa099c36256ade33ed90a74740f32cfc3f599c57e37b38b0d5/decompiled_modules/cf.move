module 0x9fe295a715e812fa099c36256ade33ed90a74740f32cfc3f599c57e37b38b0d5::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CF>>(0x2::coin::mint<CF>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CF>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CF>(arg0, 0, b"CF", b"Crazy Frog", b"Crazy Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1714064037069-1acace7649055e1f1706cf6dd6321454.jpeg"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

