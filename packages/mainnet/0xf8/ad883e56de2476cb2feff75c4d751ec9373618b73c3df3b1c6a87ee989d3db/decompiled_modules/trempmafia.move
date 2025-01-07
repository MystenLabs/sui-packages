module 0xf8ad883e56de2476cb2feff75c4d751ec9373618b73c3df3b1c6a87ee989d3db::trempmafia {
    struct TREMPMAFIA has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TREMPMAFIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TREMPMAFIA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TREMPMAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TREMPMAFIA>(arg0, 9, b"TrempMafia", b"TrempMafia", b"TrempMafia Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TREMPMAFIA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREMPMAFIA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMPMAFIA>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TREMPMAFIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TREMPMAFIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TREMPMAFIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

