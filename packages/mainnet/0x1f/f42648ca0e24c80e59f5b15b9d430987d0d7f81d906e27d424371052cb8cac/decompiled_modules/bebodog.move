module 0x1ff42648ca0e24c80e59f5b15b9d430987d0d7f81d906e27d424371052cb8cac::bebodog {
    struct BEBODOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEBODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BEBODOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BEBODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BEBODOG>(arg0, 9, b"BeboDog", b"Bebo Dog", b"Bebo Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BEBODOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBODOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBODOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BEBODOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEBODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BEBODOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

