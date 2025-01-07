module 0xb683c69924d449819c7dcca3c89275b811ce2baa1e64527d31012b9b6ea1db::psycat {
    struct PSYCAT has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun add_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PSYCAT>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_add<PSYCAT>(arg0, arg1, arg2, arg4);
    }

    fun init(arg0: PSYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PSYCAT>(arg0, 9, b"PSYCAT", b"PSY Cat Coin", b"Psy was born in the crypto trenches - a virtual cat with the ambition of a lion, who grew up among crypto degens and gamblers, here to paint the digital world. Website: https://www.psycatcoin.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://quicknode.quicknode-ipfs.com/ipfs/QmWYuUFwjFgfJdJwL2DYNBazMDKJQPodqMsZ1CGfyzJJjB"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSYCAT>>(v2);
        0x2::coin::mint_and_transfer<PSYCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYCAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PSYCAT>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = Owner{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Owner>(v4, 0x2::tx_context::sender(arg1));
    }

    fun is_owner(arg0: &0x2::tx_context::TxContext, arg1: &Owner) : bool {
        0x2::tx_context::sender(arg0) == arg1.owner
    }

    public fun rm_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PSYCAT>, arg2: address, arg3: &Owner, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg4, arg3), 0);
        0x2::coin::deny_list_v2_remove<PSYCAT>(arg0, arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

