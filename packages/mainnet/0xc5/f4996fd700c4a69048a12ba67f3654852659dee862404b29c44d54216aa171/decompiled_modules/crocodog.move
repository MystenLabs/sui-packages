module 0xc5f4996fd700c4a69048a12ba67f3654852659dee862404b29c44d54216aa171::crocodog {
    struct CROCODOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CROCODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CROCODOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CROCODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CROCODOG>(arg0, 9, b"CrocoDog", b"CrocoDog", b"CrocoDog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CROCODOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROCODOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCODOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CROCODOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CROCODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CROCODOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

