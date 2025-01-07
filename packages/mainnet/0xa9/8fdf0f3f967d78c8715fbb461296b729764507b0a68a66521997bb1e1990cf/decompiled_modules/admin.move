module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_treasury<T0, T1>(arg0: &AdminCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::CustodianKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::Custodian<T0, T1>>(arg2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new_custodian_key<T0, T1>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::sub_treasury_balance<T0, T1>(v0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::treasury_amount<T0, T1>(v0)), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xfdab8ca73c9eecba705890f48293e57574f866fb5e59a1a3de4f33b0681ea368);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &AdminCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::operator::new_operator(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

