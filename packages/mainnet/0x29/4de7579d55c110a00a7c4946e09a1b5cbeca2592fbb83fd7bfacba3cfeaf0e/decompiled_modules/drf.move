module 0x294de7579d55c110a00a7c4946e09a1b5cbeca2592fbb83fd7bfacba3cfeaf0e::drf {
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

    struct DRF has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury<T0>, arg2: 0x2::coin::Coin<T0>) {
        let v0 = BurnEvent<T0>{amount: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<BurnEvent<T0>>(v0);
        0x2::coin::burn<T0>(treasury_cap_mut<T0>(arg1), arg2);
    }

    public fun mint<T0>(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = treasury_cap_mut<T0>(arg1);
        assert!(0x2::coin::total_supply<T0>(v0) + arg2 <= 1000000000000000, 0);
        let v1 = MintEvent<T0>{amount: arg2};
        0x2::event::emit<MintEvent<T0>>(v1);
        0x2::coin::mint<T0>(treasury_cap_mut<T0>(arg1), arg2, arg3)
    }

    fun init(arg0: DRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DRF>(arg0, 6, b"DRF", b"$DRF", b"$DRF is Drife's token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://firebasestorage.googleapis.com/v0/b/drife-dubai-prod.appspot.com/o/drife_logo_round.png?alt=media&token=cb96bd23-5a08-4015-b1d2-e89114434d4f")), true, arg1);
        let v3 = v0;
        let v4 = ControlledTreasury<DRF>{id: 0x2::object::new(arg1)};
        let v5 = ControlledTreasuryCap{
            id         : 0x2::object::new(arg1),
            for_object : 0x2::object::uid_to_inner(&v4.id),
        };
        let v6 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<DRF>>(&mut v4.id, v6, v3);
        0x2::transfer::share_object<ControlledTreasury<DRF>>(v4);
        0x2::transfer::public_transfer<ControlledTreasuryCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DRF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DRF>>(0x2::coin::mint<DRF>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun treasury_cap_mut<T0>(arg0: &mut ControlledTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

