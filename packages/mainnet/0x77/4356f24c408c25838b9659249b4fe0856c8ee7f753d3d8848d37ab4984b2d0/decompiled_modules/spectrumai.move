module 0x774356f24c408c25838b9659249b4fe0856c8ee7f753d3d8848d37ab4984b2d0::spectrumai {
    struct SPECTRUMAI has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPECTRUMAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPECTRUMAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPECTRUMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPECTRUMAI>(arg0, 9, b"SpectrumAI", b"SpectrumAI Protocol", b"SpectrumAI Protocol Official Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPECTRUMAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPECTRUMAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPECTRUMAI>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPECTRUMAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPECTRUMAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPECTRUMAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

