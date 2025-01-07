module 0x480ac4c5fa50299ae40f21e3c40a9948cd7b647459d6c640aaa1c1a4b7bda0e7::spacelemon {
    struct SPACELEMON has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACELEMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPACELEMON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPACELEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPACELEMON>(arg0, 9, b"SpaceLemon", b"SPACE LEMON", b"SPACE LEMON MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPACELEMON>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACELEMON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACELEMON>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPACELEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACELEMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPACELEMON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

