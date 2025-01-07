module 0x6eb58bc73b3da22f2df640cebf4de72bda2f3021997fbd8bf62b736cf2d3a84d::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MANAGED>,
    }

    public fun burn(arg0: &mut TreasuryAccess, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 9, b"GIFT", x"66e296aa20434f494e532057454e20f09f94b84e4557", x"e296aa20434f494e20f09f94b84e4557", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-file.cubicgames.xyz/cubic_icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        let v2 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryAccess>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryAccess, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

