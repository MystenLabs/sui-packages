module 0x815c98ee710c2c3bd4a0953beefd98638848d5dbbc1b6a2fa848d212bb14a5ba::pepo {
    struct PEPO has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<PEPO>, arg1: vector<0x2::coin::Coin<PEPO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<PEPO>(0x2::coin::supply_mut<PEPO>(arg0), 0x2::coin::into_balance<PEPO>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<PEPO>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPO>, arg1: vector<0x2::coin::Coin<PEPO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PEPO>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<PEPO>(arg1, arg2, arg3));
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<PEPO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPO>>(arg0);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<PEPO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: PEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPO>(arg0, 9, b"PEPO", b"PEPO", b"All pets love PEPO @peposuii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/WcJVJq4/718qe-Mix-Bh-L.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<PEPO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPO>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

