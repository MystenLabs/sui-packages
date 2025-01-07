module 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::validator {
    struct UnverifiedValidatorOperationCap has store, key {
        id: 0x2::object::UID,
        authorizer_validator_address: address,
    }

    struct ValidatorOperationCap has drop {
        authorizer_validator_address: address,
    }

    public(friend) fun new_from_unverified(arg0: &UnverifiedValidatorOperationCap) : ValidatorOperationCap {
        ValidatorOperationCap{authorizer_validator_address: arg0.authorizer_validator_address}
    }

    public(friend) fun new_unverified_validator_operation_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : UnverifiedValidatorOperationCap {
        UnverifiedValidatorOperationCap{
            id                           : 0x2::object::new(arg1),
            authorizer_validator_address : arg0,
        }
    }

    public fun transfer_unverified_validator_operation_cap(arg0: UnverifiedValidatorOperationCap, arg1: address) {
        0x2::transfer::public_transfer<UnverifiedValidatorOperationCap>(arg0, arg1);
    }

    public(friend) fun unverified_operation_cap_address(arg0: &UnverifiedValidatorOperationCap) : &address {
        &arg0.authorizer_validator_address
    }

    public(friend) fun verified_operation_cap_address(arg0: &ValidatorOperationCap) : &address {
        &arg0.authorizer_validator_address
    }

    // decompiled from Move bytecode v6
}

