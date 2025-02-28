module 0xa4414a5b4fd2249f7826882bf6defc34f8e0a7351adfca40b509c19abc9fc245::vrf_encryption_poc {
    struct AddressBook has store, key {
        id: 0x2::object::UID,
        contacts: 0x2::table::Table<address, vector<u8>>,
    }

    public entry fun add_contact(arg0: &mut AddressBook, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ecvrf::ecvrf_verify(&arg3, &arg4, &arg5, &arg6), 0);
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

