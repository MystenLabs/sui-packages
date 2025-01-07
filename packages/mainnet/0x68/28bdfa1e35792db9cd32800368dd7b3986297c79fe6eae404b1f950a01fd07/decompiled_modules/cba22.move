module 0x6828bdfa1e35792db9cd32800368dd7b3986297c79fe6eae404b1f950a01fd07::cba22 {
    struct CBA22 has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CBA22>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CBA22>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CBA22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CBA22>(arg0, 9, b"CBA22", b"CBA22", b"CBA22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBA22>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CBA22>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<CBA22>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA22>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CBA22>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CBA22>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

