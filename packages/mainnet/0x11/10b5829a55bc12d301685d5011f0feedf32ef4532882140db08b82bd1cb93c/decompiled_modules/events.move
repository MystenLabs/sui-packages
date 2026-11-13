module 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::events {
    struct SignerCreated has copy, drop {
        signer_id: 0x2::object::ID,
        owner: address,
        policy_id: 0x2::object::ID,
    }

    struct AllowanceIssued has copy, drop {
        signer_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        spender: address,
    }

    struct SpenderRotated has copy, drop {
        signer_id: 0x2::object::ID,
        allowance_id: 0x2::object::ID,
        new_spender: address,
    }

    struct SpendOccurred has copy, drop {
        signer_id: 0x2::object::ID,
        allowance_id: 0x2::object::ID,
        spender: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        connector: 0x1::option::Option<0x1::type_name::TypeName>,
        intent_hash: vector<u8>,
    }

    struct SettingsChanged has copy, drop {
        signer_id: 0x2::object::ID,
    }

    public(friend) fun allowance_issued(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = AllowanceIssued{
            signer_id : arg0,
            coin      : arg1,
            spender   : arg2,
        };
        0x2::event::emit<AllowanceIssued>(v0);
    }

    public(friend) fun settings_changed(arg0: 0x2::object::ID) {
        let v0 = SettingsChanged{signer_id: arg0};
        0x2::event::emit<SettingsChanged>(v0);
    }

    public(friend) fun signer_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID) {
        let v0 = SignerCreated{
            signer_id : arg0,
            owner     : arg1,
            policy_id : arg2,
        };
        0x2::event::emit<SignerCreated>(v0);
    }

    public(friend) fun spend_occurred(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: vector<u8>) {
        let v0 = SpendOccurred{
            signer_id    : arg0,
            allowance_id : arg1,
            spender      : arg2,
            coin         : arg3,
            amount       : arg4,
            connector    : arg5,
            intent_hash  : arg6,
        };
        0x2::event::emit<SpendOccurred>(v0);
    }

    public(friend) fun spender_rotated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = SpenderRotated{
            signer_id    : arg0,
            allowance_id : arg1,
            new_spender  : arg2,
        };
        0x2::event::emit<SpenderRotated>(v0);
    }

    // decompiled from Move bytecode v7
}

