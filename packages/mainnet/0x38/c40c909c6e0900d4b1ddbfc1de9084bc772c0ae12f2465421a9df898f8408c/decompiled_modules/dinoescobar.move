module 0x38c40c909c6e0900d4b1ddbfc1de9084bc772c0ae12f2465421a9df898f8408c::dinoescobar {
    struct DINOESCOBAR has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DINOESCOBAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DINOESCOBAR>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DINOESCOBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DINOESCOBAR>(arg0, 9, b"DinoEscobar", b"Dino Escobar", b"Dino Escobar Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DINOESCOBAR>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINOESCOBAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOESCOBAR>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DINOESCOBAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DINOESCOBAR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DINOESCOBAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

