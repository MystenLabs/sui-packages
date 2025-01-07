module 0x53ea65486497b95aa759b67f06704a0658d66d7d700fe057eda30699150af9f0::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<SPT>, arg1: vector<0x2::coin::Coin<SPT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<SPT>(0x2::coin::supply_mut<SPT>(arg0), 0x2::coin::into_balance<SPT>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<SPT>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPT>, arg1: vector<0x2::coin::Coin<SPT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SPT>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<SPT>(arg1, arg2, arg3));
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<SPT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPT>>(arg0);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<SPT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 9, b"SPT", b"SPT", b"Seapad launchpad foundation token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/TEST/public/media/images/logo_1679906850804.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<SPT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPT>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

