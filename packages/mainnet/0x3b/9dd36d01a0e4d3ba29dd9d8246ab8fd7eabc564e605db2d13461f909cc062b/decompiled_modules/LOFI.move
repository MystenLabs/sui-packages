module 0x3b9dd36d01a0e4d3ba29dd9d8246ab8fd7eabc564e605db2d13461f909cc062b::LOFI {
    struct LOFI has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOFI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LOFI>(arg0, arg1, arg2, arg3);
    }

    fun create_logo_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fM8QZXh/LOFI-PFP.png")
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LOFI>(arg0, 6, b"LOFI", b"LOFI", b"Lofi is everyone's favorite Yeti on Sui", 0x1::option::some<0x2::url::Url>(create_logo_url()), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v2);
        0x2::coin::mint_and_transfer<LOFI>(&mut v3, 1000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LOFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOFI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LOFI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

