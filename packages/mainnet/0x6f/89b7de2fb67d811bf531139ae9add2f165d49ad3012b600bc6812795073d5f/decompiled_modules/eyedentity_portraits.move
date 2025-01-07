module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits {
    struct KlausMueller has drop {
        dummy_field: bool,
    }

    struct HaydenMichael has drop {
        dummy_field: bool,
    }

    struct Zack has drop {
        dummy_field: bool,
    }

    struct Janky has drop {
        dummy_field: bool,
    }

    struct Coolman has drop {
        dummy_field: bool,
    }

    struct Spesh has drop {
        dummy_field: bool,
    }

    struct Portrait<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun add_field<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::add_field<T0>(arg1);
    }

    public(friend) fun initial_minting(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_and_transfer<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::incr_counter<T0>(arg1);
        let v0 = Portrait<T0>{
            id          : 0x2::object::new(arg3),
            mint_number : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::num_minted<T0>(arg1),
        };
        0x2::transfer::public_transfer<Portrait<T0>>(v0, arg2);
    }

    public fun mint_and_transfer_hayden_michael_portrait(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_and_transfer_klaus_muller_portrait(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_number<T0>(arg0: &Portrait<T0>) : u64 {
        arg0.mint_number
    }

    // decompiled from Move bytecode v6
}

