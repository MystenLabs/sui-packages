module 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles {
    struct Roles has store, key {
        id: 0x2::object::UID,
        owner: 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole>,
        mint_controller: address,
    }

    struct OwnerRole has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Roles {
        let v0 = OwnerRole{dummy_field: false};
        Roles{
            id              : 0x2::object::new(arg2),
            owner           : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole>(v0, arg0),
            mint_controller : arg1,
        }
    }

    public fun mint_controller(arg0: &Roles) : address {
        arg0.mint_controller
    }

    public fun owner(arg0: &Roles) : address {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole>(&arg0.owner)
    }

    public(friend) fun owner_role_mut(arg0: &mut Roles) : &mut 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole> {
        &mut arg0.owner
    }

    public fun pending_owner(arg0: &Roles) : 0x1::option::Option<address> {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::pending_address<OwnerRole>(&arg0.owner)
    }

    public(friend) fun update_mint_controller(arg0: &mut Roles, arg1: address) {
        arg0.mint_controller = arg1;
    }

    // decompiled from Move bytecode v7
}

