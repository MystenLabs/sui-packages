module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::stashed_airdrop {
    struct Airdrop has key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun mint_and_transfer(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_and_transfer_v2(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version() == 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::version(arg1), 0);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::incr_counter<Airdrop>(arg1);
        let v0 = Airdrop{
            id          : 0x2::object::new(arg3),
            mint_number : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2::num_minted<Airdrop>(arg1),
        };
        0x2::transfer::transfer<Airdrop>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

