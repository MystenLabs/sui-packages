module 0xbd021c61ce8706ab5b1c6ebbc01d632f788ee250ca64ba34f6e3eb12e0571234::meme {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ControlledTreasury<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct ControlledTreasuryCap has store, key {
        id: 0x2::object::UID,
        for_object: 0x2::object::ID,
    }

    struct MintEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct MEME has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury<T0>, arg2: 0x2::coin::Coin<T0>) {
        let v0 = BurnEvent<T0>{amount: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<BurnEvent<T0>>(v0);
        0x2::coin::burn<T0>(treasury_cap_mut<T0>(arg1), arg2);
    }

    public fun mint<T0>(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = treasury_cap_mut<T0>(arg1);
        assert!(0x2::coin::total_supply<T0>(v0) + arg2 <= 10000000000000000, 0);
        let v1 = MintEvent<T0>{amount: arg2};
        0x2::event::emit<MintEvent<T0>>(v1);
        0x2::coin::mint<T0>(treasury_cap_mut<T0>(arg1), arg2, arg3)
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"NEMO", b"$SUINEMO", b"$SUINEMO is digital cleaner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GcK6t4PasAE-umj?format=jpg&name=medium")), arg1);
        let v2 = v0;
        let v3 = ControlledTreasury<MEME>{id: 0x2::object::new(arg1)};
        let v4 = ControlledTreasuryCap{
            id         : 0x2::object::new(arg1),
            for_object : 0x2::object::uid_to_inner(&v3.id),
        };
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<MEME>>(&mut v3.id, v5, v2);
        0x2::transfer::share_object<ControlledTreasury<MEME>>(v3);
        0x2::transfer::public_transfer<ControlledTreasuryCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::mint<MEME>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun treasury_cap_mut<T0>(arg0: &mut ControlledTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

