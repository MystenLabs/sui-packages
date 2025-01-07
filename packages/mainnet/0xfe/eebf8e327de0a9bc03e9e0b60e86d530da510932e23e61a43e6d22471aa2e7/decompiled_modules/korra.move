module 0xfeeebf8e327de0a9bc03e9e0b60e86d530da510932e23e61a43e6d22471aa2e7::korra {
    struct KORRA has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<KORRA>, arg1: vector<0x2::coin::Coin<KORRA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<KORRA>(0x2::coin::supply_mut<KORRA>(arg0), 0x2::coin::into_balance<KORRA>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<KORRA>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KORRA>, arg1: vector<0x2::coin::Coin<KORRA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KORRA>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<KORRA>(arg1, arg2, arg3));
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<KORRA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KORRA>>(arg0);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<KORRA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: KORRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORRA>(arg0, 9, b"KORRA", b"KORRA", b"Following Aang's death 53 years after his youthful adventures, the next Avatar, Korra, was born in the Southern Water Tribe. In the present day, seventy years after the end of the Hundred Years War, Korra, a stubborn seventeen-year-old girl is driven to complete her training and fulfill her role as the Avatar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/PrRRfgDp/pixlr-image-generator-2d1e5887-ee1f-4c94-ab16-51ae4301b775.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KORRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<KORRA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KORRA>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

