module 0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ControlledTreasury has key {
        id: 0x2::object::UID,
    }

    struct ControlledTreasuryCap has store, key {
        id: 0x2::object::UID,
        for_object: 0x2::object::ID,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    struct TIMES has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury, arg2: 0x2::coin::Coin<TIMES>) {
        let v0 = BurnEvent{amount: 0x2::coin::value<TIMES>(&arg2)};
        0x2::event::emit<BurnEvent>(v0);
        0x2::coin::burn<TIMES>(treasury_cap_mut(arg1), arg2);
    }

    fun init(arg0: TIMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMES>(arg0, 5, b"$TIMES", b"TIMES", b"$TIMES is the token for the DARKTIMES game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.playdarktimes.com/images/icons/darktimes_logo.png")), arg1);
        let v2 = v0;
        let v3 = ControlledTreasury{id: 0x2::object::new(arg1)};
        let v4 = ControlledTreasuryCap{
            id         : 0x2::object::new(arg1),
            for_object : 0x2::object::uid_to_inner(&v3.id),
        };
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<TIMES>>(&mut v3.id, v5, v2);
        0x2::transfer::share_object<ControlledTreasury>(v3);
        0x2::transfer::public_transfer<ControlledTreasuryCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TIMES>>(0x2::coin::mint<TIMES>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun treasury_cap_mut(arg0: &mut ControlledTreasury) : &mut 0x2::coin::TreasuryCap<TIMES> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<TIMES>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

