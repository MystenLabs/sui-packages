module 0x3::validator_cap {
    struct UnverifiedValidatorOperationCap has store, key {
        id: 0x2::object::UID,
        authorizer_validator_address: address,
    }

    struct ValidatorOperationCap has drop {
        authorizer_validator_address: address,
    }

    public(friend) fun into_verified(arg0: &UnverifiedValidatorOperationCap) : ValidatorOperationCap {
        ValidatorOperationCap{authorizer_validator_address: arg0.authorizer_validator_address}
    }

    public(friend) fun new_unverified_validator_operation_cap_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x0 || v0 == arg0, 0);
        let v1 = UnverifiedValidatorOperationCap{
            id                           : 0x2::object::new(arg1),
            authorizer_validator_address : arg0,
        };
        0x2::transfer::public_transfer<UnverifiedValidatorOperationCap>(v1, arg0);
        0x2::object::id<UnverifiedValidatorOperationCap>(&v1)
    }

    public(friend) fun unverified_operation_cap_address(arg0: &UnverifiedValidatorOperationCap) : &address {
        &arg0.authorizer_validator_address
    }

    public(friend) fun verified_operation_cap_address(arg0: &ValidatorOperationCap) : &address {
        &arg0.authorizer_validator_address
    }

    // decompiled from Move bytecode v6
}

