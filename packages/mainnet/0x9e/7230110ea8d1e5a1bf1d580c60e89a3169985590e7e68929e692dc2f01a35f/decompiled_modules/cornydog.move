module 0x9e7230110ea8d1e5a1bf1d580c60e89a3169985590e7e68929e692dc2f01a35f::cornydog {
    struct CORNYDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORNYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CORNYDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CORNYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CORNYDOG>(arg0, 9, b"CORNY", b"SUI CORNY DOG", b"SUI CORNY DOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CORNYDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORNYDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNYDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CORNYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORNYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CORNYDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

