module 0x759367ac96b646c4dae894cff049104bb41b85519919831ae77d82821f7748f3::pepofrog {
    struct PEPOFROG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPOFROG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPOFROG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEPOFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPOFROG>(arg0, 9, b"PEPO", b"PEPO THE FROG", b"PEPO THE FROG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEPOFROG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPOFROG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPOFROG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPOFROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPOFROG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEPOFROG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

