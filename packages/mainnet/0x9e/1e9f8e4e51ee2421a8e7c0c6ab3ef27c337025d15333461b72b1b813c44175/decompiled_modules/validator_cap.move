module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap {
    struct ValidatorCap has store, key {
        id: 0x2::object::UID,
        validator_id: 0x2::object::ID,
    }

    struct ValidatorOperationCap has store, key {
        id: 0x2::object::UID,
        validator_id: 0x2::object::ID,
    }

    struct ValidatorCommissionCap has store, key {
        id: 0x2::object::UID,
        validator_id: 0x2::object::ID,
    }

    struct VerifiedValidatorCap has drop {
        validator_id: 0x2::object::ID,
    }

    struct VerifiedValidatorOperationCap has drop {
        validator_id: 0x2::object::ID,
    }

    struct VerifiedValidatorCommissionCap has drop {
        validator_id: 0x2::object::ID,
    }

    public fun create_verified_validator_cap(arg0: &ValidatorCap, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : VerifiedValidatorCap {
        VerifiedValidatorCap{validator_id: arg0.validator_id}
    }

    public fun create_verified_validator_commission_cap(arg0: &ValidatorCommissionCap, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : VerifiedValidatorCommissionCap {
        VerifiedValidatorCommissionCap{validator_id: arg0.validator_id}
    }

    public fun create_verified_validator_operation_cap(arg0: &ValidatorOperationCap, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : VerifiedValidatorOperationCap {
        VerifiedValidatorOperationCap{validator_id: arg0.validator_id}
    }

    public fun new_validator_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : ValidatorCap {
        ValidatorCap{
            id           : 0x2::object::new(arg1),
            validator_id : arg0,
        }
    }

    public fun new_validator_commission_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : ValidatorCommissionCap {
        ValidatorCommissionCap{
            id           : 0x2::object::new(arg1),
            validator_id : arg0,
        }
    }

    public fun new_validator_operation_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : ValidatorOperationCap {
        ValidatorOperationCap{
            id           : 0x2::object::new(arg1),
            validator_id : arg0,
        }
    }

    public fun validator_commission_cap_validator_id(arg0: &ValidatorCommissionCap) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun validator_id(arg0: &ValidatorCap) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun validator_operation_cap_validator_id(arg0: &ValidatorOperationCap) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun verified_validator_cap_validator_id(arg0: &VerifiedValidatorCap) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun verified_validator_commission_cap_validator_id(arg0: &VerifiedValidatorCommissionCap) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun verified_validator_operation_cap_validator_id(arg0: &VerifiedValidatorOperationCap) : 0x2::object::ID {
        arg0.validator_id
    }

    // decompiled from Move bytecode v6
}

