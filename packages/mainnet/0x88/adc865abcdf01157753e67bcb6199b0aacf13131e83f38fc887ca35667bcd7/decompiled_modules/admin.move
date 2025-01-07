module 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xdfda63ad61f8ad5176c1107cb4a8377e3da14221221c3890d7f5a71a800dbbff);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &AdminCap, arg1: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg1);
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::operator::new_operator(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

