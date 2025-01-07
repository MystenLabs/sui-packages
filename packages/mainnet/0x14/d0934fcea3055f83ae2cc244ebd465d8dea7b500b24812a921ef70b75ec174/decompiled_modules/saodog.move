module 0x14d0934fcea3055f83ae2cc244ebd465d8dea7b500b24812a921ef70b75ec174::saodog {
    struct SAODOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SAODOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SAODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SAODOG>(arg0, 9, b"SAODOG", b"SUI SAO DOG", b"SUI SAO DOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SAODOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAODOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAODOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SAODOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SAODOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

