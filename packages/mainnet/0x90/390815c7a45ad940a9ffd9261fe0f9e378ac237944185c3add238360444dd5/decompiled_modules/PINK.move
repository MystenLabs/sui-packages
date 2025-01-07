module 0x90390815c7a45ad940a9ffd9261fe0f9e378ac237944185c3add238360444dd5::PINK {
    struct PINK has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PINK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PINK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PINK>(arg0, 9, b"PINK", b"Pink Cat burst", b"Pink Cat burst sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4_2a8ZsK0ec-A7FvREq-8-0E5Q2a-wYUC8w&s")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PINK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PINK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PINK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

