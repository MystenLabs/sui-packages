module 0x97d15e063d73cecd61858fe471093f690291daf234afe28fd92ac5e9a4e66acf::snakycat {
    struct SNAKYCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNAKYCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SNAKYCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SNAKYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SNAKYCAT>(arg0, 9, b"SnakyCat", b"Snaky Cat", b"Snaky Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SNAKYCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKYCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKYCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SNAKYCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNAKYCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SNAKYCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

