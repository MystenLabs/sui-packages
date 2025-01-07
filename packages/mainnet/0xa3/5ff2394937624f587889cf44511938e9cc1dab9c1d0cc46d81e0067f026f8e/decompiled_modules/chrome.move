module 0xa35ff2394937624f587889cf44511938e9cc1dab9c1d0cc46d81e0067f026f8e::chrome {
    struct CHROME has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun add_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHROME>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_add<CHROME>(arg0, arg1, arg2, arg4);
    }

    fun init(arg0: CHROME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHROME>(arg0, 9, b"Chrome", b"https://x.com/0xchromium", b"https://pbs.twimg.com/profile_images/1743605246348115971/y8suP3kL_400x400.jpg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1743605246348115971/y8suP3kL_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHROME>>(v2);
        0x2::coin::mint_and_transfer<CHROME>(&mut v3, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHROME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHROME>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = Owner{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Owner>(v4, 0x2::tx_context::sender(arg1));
    }

    fun is_owner(arg0: &0x2::tx_context::TxContext, arg1: &Owner) : bool {
        0x2::tx_context::sender(arg0) == arg1.owner
    }

    public fun rm_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHROME>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_remove<CHROME>(arg0, arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

