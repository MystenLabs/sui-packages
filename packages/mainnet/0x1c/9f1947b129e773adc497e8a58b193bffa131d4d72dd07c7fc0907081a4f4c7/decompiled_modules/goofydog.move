module 0x1c9f1947b129e773adc497e8a58b193bffa131d4d72dd07c7fc0907081a4f4c7::goofydog {
    struct GOOFYDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOOFYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GOOFYDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: GOOFYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GOOFYDOG>(arg0, 9, b"GOOFY", b"GOOFY DOG", b"GOOFY DOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GOOFYDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOFYDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFYDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GOOFYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOOFYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GOOFYDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

