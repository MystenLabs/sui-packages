module 0xd1bfc2a73aa2b7a5f5bb870d64bea9e7a83efe8d14f80ad6960eaffb9b637580::managed {
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
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 9, b"NFT", x"e29aa12020535549424f58", x"e29aa12020535549424f58", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/LJXZRtb/01e68-Nkw-SK4-ZOwphxes-PVHi-NA9-O4-Dh-e-MPk9-JAg-Yn-LMk-B8-IDpimg-BO095-Rean-Qe4-JRv-QEagi-JCh-Mbbxz.gif")), arg1);
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

