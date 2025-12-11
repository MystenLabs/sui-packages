module 0x25bffef941168af0c96a8e934a3eca8986d2fe38cab832c817de87873e486f65::contacts {
    struct Contacts has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        wallet: address,
        owner: address,
    }

    struct ContactCreatedEvent has copy, drop {
        owner: address,
        name: 0x1::string::String,
        wallet: address,
    }

    struct ContactDeletedEvent has copy, drop {
        owner: address,
        contact_id: address,
    }

    entry fun create_contact(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Contacts{
            id     : 0x2::object::new(arg2),
            name   : arg0,
            wallet : arg1,
            owner  : v0,
        };
        let v2 = ContactCreatedEvent{
            owner  : v0,
            name   : v1.name,
            wallet : arg1,
        };
        0x2::event::emit<ContactCreatedEvent>(v2);
        0x2::transfer::transfer<Contacts>(v1, v0);
    }

    entry fun delete_profile(arg0: Contacts, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = ContactDeletedEvent{
            owner      : 0x2::tx_context::sender(arg1),
            contact_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<ContactDeletedEvent>(v0);
        let Contacts {
            id     : v1,
            name   : _,
            wallet : _,
            owner  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

