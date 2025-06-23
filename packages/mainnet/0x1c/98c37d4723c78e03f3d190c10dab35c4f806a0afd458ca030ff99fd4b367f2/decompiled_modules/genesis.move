module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::genesis {
    struct OGVipCard has drop {
        dummy_field: bool,
    }

    struct OGVVipCard has drop {
        dummy_field: bool,
    }

    struct CommemorativeCard1 has drop {
        dummy_field: bool,
    }

    struct CommemorativeCard2 has drop {
        dummy_field: bool,
    }

    struct CommemorativeCard3 has drop {
        dummy_field: bool,
    }

    struct CommemorativeCard4 has drop {
        dummy_field: bool,
    }

    struct Genesis<phantom T0> has key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun transfer<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: address, arg2: Genesis<T0>, arg3: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gatekeeper_helper::PublicKeys, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gatekeeper_helper::verify_platform(arg3, arg4, arg5);
        0x2::transfer::transfer<Genesis<T0>>(arg2, arg1);
    }

    public fun add_field<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::add_field<T0>(arg1);
    }

    public fun mint_and_transfer<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter, arg2: address, arg3: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gatekeeper_helper::PublicKeys, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gatekeeper_helper::verify_platform(arg3, arg4, arg5);
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::incr_counter<T0>(arg1);
        let v0 = Genesis<T0>{
            id          : 0x2::object::new(arg6),
            mint_number : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::num_minted<T0>(arg1),
        };
        0x2::transfer::transfer<Genesis<T0>>(v0, arg2);
    }

    public fun mint_number<T0>(arg0: &Genesis<T0>) : u64 {
        arg0.mint_number
    }

    // decompiled from Move bytecode v6
}

