module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::moments {
    struct SuiCreaturesPOAP1 has drop {
        dummy_field: bool,
    }

    struct SuiCreaturesPOAP2 has drop {
        dummy_field: bool,
    }

    struct SuiCreaturesPOAPComplete has drop {
        dummy_field: bool,
    }

    struct SuiEcosystemPartyLiveCreate1 has drop {
        dummy_field: bool,
    }

    struct SuiEcosystemPartyLiveCreate2 has drop {
        dummy_field: bool,
    }

    struct SuiEcosystemPartyLiveCreate3 has drop {
        dummy_field: bool,
    }

    struct Platform<phantom T0> has key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    struct Public<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    struct Event<phantom T0> has store, key {
        id: 0x2::object::UID,
        expiration: u64,
    }

    public fun add_field<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::add_field<T0>(arg1);
    }

    public fun mint_and_transfer_platform<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &Event<T0>, arg2: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.expiration > 0x2::clock::timestamp_ms(arg4), 1);
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg2), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::incr_counter<T0>(arg2);
        let v0 = Platform<T0>{
            id          : 0x2::object::new(arg5),
            mint_number : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::num_minted<T0>(arg2),
        };
        0x2::transfer::transfer<Platform<T0>>(v0, arg3);
    }

    public fun mint_and_transfer_public<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &Event<T0>, arg2: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.expiration > 0x2::clock::timestamp_ms(arg4), 1);
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg2), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::incr_counter<T0>(arg2);
        let v0 = Public<T0>{
            id          : 0x2::object::new(arg5),
            mint_number : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::num_minted<T0>(arg2),
        };
        0x2::transfer::transfer<Public<T0>>(v0, arg3);
    }

    public fun new_event<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Event<T0> {
        Event<T0>{
            id         : 0x2::object::new(arg3),
            expiration : 0x2::clock::timestamp_ms(arg2) + arg1,
        }
    }

    // decompiled from Move bytecode v6
}

