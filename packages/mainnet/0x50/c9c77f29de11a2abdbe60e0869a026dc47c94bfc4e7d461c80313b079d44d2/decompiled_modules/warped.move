module 0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped {
    struct WARPED has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<WARPED>,
    }

    public fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<WARPED>) {
        0x2::coin::burn<WARPED>(&mut arg0.cap, arg1);
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<WARPED>(&arg0.cap)
    }

    fun init(arg0: WARPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARPED>(arg0, 9, b"WARPED", b"Warped", b"Warped Utility Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.warped.games/warped.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARPED>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARPED>>(v1);
        let v3 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<Treasury>(v3);
    }

    // decompiled from Move bytecode v6
}

