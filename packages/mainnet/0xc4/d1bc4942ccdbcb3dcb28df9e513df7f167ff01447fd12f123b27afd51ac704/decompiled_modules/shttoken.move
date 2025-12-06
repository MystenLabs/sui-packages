module 0xc4d1bc4942ccdbcb3dcb28df9e513df7f167ff01447fd12f123b27afd51ac704::shttoken {
    struct SHTTOKEN has drop {
        dummy_field: bool,
    }

    struct NestMintCap has store, key {
        id: 0x2::object::UID,
    }

    struct SharedTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SHTTOKEN>,
    }

    public entry fun burn(arg0: &mut SharedTreasury, arg1: 0x2::coin::Coin<SHTTOKEN>) {
        0x2::coin::burn<SHTTOKEN>(&mut arg0.treasury_cap, arg1);
    }

    public fun total_supply(arg0: &SharedTreasury) : u64 {
        0x2::coin::total_supply<SHTTOKEN>(&arg0.treasury_cap)
    }

    public entry fun create_shared_treasury(arg0: 0x2::coin::TreasuryCap<SHTTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<SharedTreasury>(v0);
    }

    fun init(arg0: SHTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHTTOKEN>(arg0, 9, b"SHT", b"Sweet Hatch Tonic", b"Utility token designed to fuel Duck Dynasty ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://duckdynasty.io/sht.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHTTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHTTOKEN>>(0x2::coin::mint<SHTTOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = NestMintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<NestMintCap>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHTTOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_for_nest(arg0: &NestMintCap, arg1: &mut SharedTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHTTOKEN> {
        0x2::coin::mint<SHTTOKEN>(&mut arg1.treasury_cap, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

