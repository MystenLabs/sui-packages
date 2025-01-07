module 0xce972b8d5fad5055ac9779718a0857639efec5d3f55a4af49f8edef8ec1fb290::vault {
    struct Vaults has store, key {
        id: 0x2::object::UID,
        other: 0x2::object_bag::ObjectBag,
    }

    struct InVault has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct OutVault has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Vaults, 0x2::object::ID) {
        let v0 = Vaults{
            id    : 0x2::object::new(arg0),
            other : 0x2::object_bag::new(arg0),
        };
        (v0, *0x2::object::uid_as_inner(uid(&v0)))
    }

    public(friend) fun deposit<T0>(arg0: &mut Vaults, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce972b8d5fad5055ac9779718a0857639efec5d3f55a4af49f8edef8ec1fb290::utils::get_full_type<T0>();
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, 0x2::coin::zero<T0>(arg2));
        };
        0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        let v1 = InVault{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            amount   : 0x2::coin::value<T0>(&arg1),
            sender   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<InVault>(v1);
    }

    public(friend) fun uid(arg0: &Vaults) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vaults, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, 0xce972b8d5fad5055ac9779718a0857639efec5d3f55a4af49f8edef8ec1fb290::utils::get_full_type<T0>()), arg1, arg2, arg3);
        let v0 = OutVault{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            amount   : arg1,
            sender   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OutVault>(v0);
    }

    // decompiled from Move bytecode v6
}

