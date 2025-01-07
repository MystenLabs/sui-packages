module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::roles {
    struct Roles has store, key {
        id: 0x2::object::UID,
        owner: 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole>,
        pauser: address,
        token_controller: address,
    }

    struct OwnerRole has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Roles {
        let v0 = OwnerRole{dummy_field: false};
        Roles{
            id               : 0x2::object::new(arg3),
            owner            : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole>(v0, arg0),
            pauser           : arg1,
            token_controller : arg2,
        }
    }

    public fun owner(arg0: &Roles) : address {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole>(&arg0.owner)
    }

    public fun owner_role(arg0: &Roles) : &0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole> {
        &arg0.owner
    }

    public(friend) fun owner_role_mut(arg0: &mut Roles) : &mut 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole> {
        &mut arg0.owner
    }

    public fun pauser(arg0: &Roles) : address {
        arg0.pauser
    }

    public fun pending_owner(arg0: &Roles) : 0x1::option::Option<address> {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::pending_address<OwnerRole>(&arg0.owner)
    }

    public fun token_controller(arg0: &Roles) : address {
        arg0.token_controller
    }

    public(friend) fun update_pauser(arg0: &mut Roles, arg1: address) {
        arg0.pauser = arg1;
    }

    public(friend) fun update_token_controller(arg0: &mut Roles, arg1: address) {
        arg0.token_controller = arg1;
    }

    // decompiled from Move bytecode v6
}

