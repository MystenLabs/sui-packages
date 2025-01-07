module 0x43d625674d186e93aa51e58a22b5ab0996d525491700e2a8721b8f1be1040bd7::suipnutdog {
    struct SUIPNUTDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIPNUTDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIPNUTDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIPNUTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIPNUTDOG>(arg0, 9, b"PnutDog", b"Sui Pnut Dog", b"Sui Pnut Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIPNUTDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPNUTDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPNUTDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIPNUTDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIPNUTDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIPNUTDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

