module 0x7e7270b4a5478381cc128a05bb32a78a645bf220649933b9c73ef5f35e5696c::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TARZAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TARZAN>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TARZAN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TARZAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TARZAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

