module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gamisodes {
    struct GAMISODES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMISODES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAMISODES>(arg0, arg1);
        let v1 = 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::new(arg1);
        let v2 = 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::new(arg1);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::display::setup_display(&v0, arg1);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::initial_minting(&v1, &mut v2, arg1);
        0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_gameplay_items_display::setup_inspector_gadget_display(&v0, arg1);
        0x2::transfer::public_transfer<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter>(v2);
    }

    // decompiled from Move bytecode v6
}

