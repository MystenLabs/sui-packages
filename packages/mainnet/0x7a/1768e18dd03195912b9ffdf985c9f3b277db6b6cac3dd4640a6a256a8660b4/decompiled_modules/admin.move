module 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x385e3023110b9f5144cb27802656d1ad90802832d90dde915759531e41838ca0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::new(arg0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::new(arg0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::new(arg0);
    }

    public entry fun set_admin(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::operator::new_operator(arg2, arg3);
    }

    public entry fun update_configuration(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &AdminCap, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::Configuration, arg3: u64, arg4: u64) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::update(arg2, arg3, arg4);
    }

    public entry fun withdraw_treasury_balance(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &AdminCap, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

