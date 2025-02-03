module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers {
    struct XP<phantom T0> has key {
        id: 0x2::object::UID,
        points: u64,
    }

    struct UpgradeObject<phantom T0> has key {
        id: 0x2::object::UID,
        points: u64,
    }

    public fun mint_and_transfer_xp<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = XP<T0>{
            id     : 0x2::object::new(arg3),
            points : arg1,
        };
        0x2::transfer::transfer<XP<T0>>(v0, arg2);
    }

    public fun mint_and_transfer_xp_upgrade<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = UpgradeObject<T0>{
            id     : 0x2::object::new(arg3),
            points : arg1,
        };
        0x2::transfer::transfer<UpgradeObject<T0>>(v0, arg2);
    }

    public fun update_xp<T0>(arg0: &mut XP<T0>, arg1: UpgradeObject<T0>) {
        arg0.points = arg0.points + arg1.points;
        let UpgradeObject {
            id     : v0,
            points : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

