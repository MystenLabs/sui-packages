module 0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::ol {
    struct Ol has store, key {
        id: 0x2::object::UID,
        children: vector<0x2::object::ID>,
    }

    public fun add_child(arg0: 0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::li::Li, arg1: &mut Ol) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.children, 0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::li::id(&arg0));
        0x2::transfer::public_transfer<0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::li::Li>(arg0, 0x2::object::uid_to_address(&arg1.id));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Ol {
        Ol{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    // decompiled from Move bytecode v6
}

