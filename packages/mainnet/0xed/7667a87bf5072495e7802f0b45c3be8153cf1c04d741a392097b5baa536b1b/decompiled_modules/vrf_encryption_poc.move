module 0xed7667a87bf5072495e7802f0b45c3be8153cf1c04d741a392097b5baa536b1b::vrf_encryption_poc {
    struct AddressBook has store, key {
        id: 0x2::object::UID,
        contacts: 0x2::table::Table<address, vector<u8>>,
    }

    public entry fun add_contact(arg0: &mut AddressBook, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, vector<u8>>(&mut arg0.contacts, arg1, arg2);
    }

    public entry fun create_address_book(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AddressBook{
            id       : 0x2::object::new(arg0),
            contacts : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::transfer<AddressBook>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_contact(arg0: &mut AddressBook, arg1: address) {
        0x2::table::remove<address, vector<u8>>(&mut arg0.contacts, arg1);
    }

    // decompiled from Move bytecode v6
}

