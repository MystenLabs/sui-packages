module 0x2007899406129ed88fa44cac4d37e5940b4bc7769562348d3f236418de938cbf::bonexp {
    struct BONEXP has drop {
        dummy_field: bool,
    }

    struct BonexpVault has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BONEXP>,
    }

    public(friend) fun burn(arg0: &mut BonexpVault, arg1: 0x2::coin::Coin<BONEXP>) {
        0x2::coin::burn<BONEXP>(&mut arg0.cap, arg1);
    }

    public(friend) fun mint_balance(arg0: &mut BonexpVault, arg1: u64) : 0x2::balance::Balance<BONEXP> {
        0x2::coin::mint_balance<BONEXP>(&mut arg0.cap, arg1)
    }

    public fun total_supply(arg0: &BonexpVault) : u64 {
        0x2::coin::total_supply<BONEXP>(&arg0.cap)
    }

    public(friend) fun burn_balance(arg0: &mut BonexpVault, arg1: 0x2::balance::Balance<BONEXP>) {
        0x2::balance::decrease_supply<BONEXP>(0x2::coin::supply_mut<BONEXP>(&mut arg0.cap), arg1);
    }

    fun init(arg0: BONEXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONEXP>(arg0, 9, b"BONEXP", b"Bonsai Experience", b"Unbanked energy siphoned from stationed Bonsai, spent on the weekly leaderboard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hashbonsai-assets.wal.app/bonexp-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONEXP>>(v1);
        let v2 = BonexpVault{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<BonexpVault>(v2);
    }

    // decompiled from Move bytecode v7
}

