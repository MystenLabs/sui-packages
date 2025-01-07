module 0x8da3efe1c88e2d0ebb355cde5b00ec83d316ce6ea90ecb7f35701953a963f770::regcoin {
    struct REGCOIN has drop {
        dummy_field: bool,
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGCOIN>(arg0, 6, b"REGCOIN", b"REGCOIN", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGCOIN>>(0x2::coin::mint<REGCOIN>(&mut v3, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

