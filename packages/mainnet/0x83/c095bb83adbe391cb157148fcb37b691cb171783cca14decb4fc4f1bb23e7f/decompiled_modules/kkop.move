module 0x83c095bb83adbe391cb157148fcb37b691cb171783cca14decb4fc4f1bb23e7f::kkop {
    struct KKOP has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<KKOP>, arg1: vector<0x2::coin::Coin<KKOP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<KKOP>(0x2::coin::supply_mut<KKOP>(arg0), 0x2::coin::into_balance<KKOP>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<KKOP>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KKOP>, arg1: vector<0x2::coin::Coin<KKOP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KKOP>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<KKOP>(arg1, arg2, arg3));
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<KKOP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KKOP>>(arg0);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<KKOP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: KKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKOP>(arg0, 9, b"KKOP", b"KKOP", b"Seapad launchpad foundation token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://w7.pngwing.com/pngs/191/109/png-transparent-person-swimming-logo-open-water-swimming-marathon-swimming-sport-swimming-marine-mammal-logo-sports.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<KKOP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KKOP>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

