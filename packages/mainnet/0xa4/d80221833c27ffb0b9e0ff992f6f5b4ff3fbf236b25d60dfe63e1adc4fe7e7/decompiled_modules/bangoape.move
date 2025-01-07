module 0xa4d80221833c27ffb0b9e0ff992f6f5b4ff3fbf236b25d60dfe63e1adc4fe7e7::bangoape {
    struct BANGOAPE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BANGOAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BANGOAPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BANGOAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BANGOAPE>(arg0, 9, b"BANGO", b"BANGO APE", b"BANGO APE MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BANGOAPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANGOAPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANGOAPE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BANGOAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BANGOAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BANGOAPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

