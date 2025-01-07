module 0x88a7c4813cd42697e3fab108f4b2e3ea1ac1c4067bde82d1ed3ef73d1379f1de::regcoin {
    struct REGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGCOIN>(arg0, 6, b"BUBO", b"Bubo The Frog", b"The Official Bubo on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmbzKrru54s7mjWeaJpMXb3g9ZS1hdsSjnC3cL9XhSVfVJ?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGCOIN>>(0x2::coin::mint<REGCOIN>(&mut v3, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

