module 0x5173be597c0413bf842e2b6227e8a9ab06fa5586d00517108cf01bb16f6948ed::SuibaReward {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: Ticket, arg1: address) {
        0x2::transfer::transfer<Ticket>(arg0, arg1);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

