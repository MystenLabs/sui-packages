module 0xa557a1f82d2d931d5c6d8abe76922b04d2929979b734ce6140fdb1dc704ba293::carv {
    struct CARV has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CARV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CARV>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CARV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CARV>(arg0, 6, b"carv", b"CARV", b"Dev at work, carving carving carving......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1728331700/DALL_E_2024-10-07_21.06.53_-_A_creative_logo_inspired_by_the_Sui_blockchain_logo._The_logo_features_two_spanners_crossing_each_other_in_the_center_symbolizing_development_and_wor_ypvsme.webp")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARV>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CARV>>(0x2::coin::mint<CARV>(&mut v3, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARV>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CARV>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CARV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CARV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

