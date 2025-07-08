module 0x3::validator_wrapper {
    struct ValidatorWrapper has store {
        inner: 0x2::versioned::Versioned,
    }

    public(friend) fun destroy(arg0: ValidatorWrapper) : 0x3::validator::Validator {
        upgrade_to_latest(&arg0);
        let ValidatorWrapper { inner: v0 } = arg0;
        0x2::versioned::destroy<0x3::validator::Validator>(v0)
    }

    fun version(arg0: &ValidatorWrapper) : u64 {
        0x2::versioned::version(&arg0.inner)
    }

    public(friend) fun create_v1(arg0: 0x3::validator::Validator, arg1: &mut 0x2::tx_context::TxContext) : ValidatorWrapper {
        ValidatorWrapper{inner: 0x2::versioned::create<0x3::validator::Validator>(1, arg0, arg1)}
    }

    public(friend) fun load_validator_maybe_upgrade(arg0: &mut ValidatorWrapper) : &mut 0x3::validator::Validator {
        upgrade_to_latest(arg0);
        0x2::versioned::load_value_mut<0x3::validator::Validator>(&mut arg0.inner)
    }

    fun upgrade_to_latest(arg0: &ValidatorWrapper) {
        assert!(version(arg0) == 1, 0);
    }

    // decompiled from Move bytecode v6
}

