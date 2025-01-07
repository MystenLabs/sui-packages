module 0x68e4581fce730187b58dfcb443ca8fddb2f1d71c6f53f5dfa882769e384a0999::addresses_obj {
    struct AddressesObj<phantom T0> has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
        creator: address,
        fee: u64,
    }

    public entry fun add_addresses<T0>(arg0: &mut AddressesObj<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::append<address>(&mut arg0.addresses, arg1);
    }

    public entry fun clear<T0>(arg0: &mut AddressesObj<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.addresses = 0x1::vector::empty<address>();
    }

    public entry fun create<T0>(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AddressesObj<T0>{
            id        : 0x2::object::new(arg1),
            addresses : arg0,
            creator   : 0x2::tx_context::sender(arg1),
            fee       : 0,
        };
        0x2::transfer::transfer<AddressesObj<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun finalize<T0>(arg0: &mut AddressesObj<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.fee = arg1;
    }

    public fun getCreator<T0>(arg0: &AddressesObj<T0>) : address {
        arg0.creator
    }

    public fun getFee<T0>(arg0: &AddressesObj<T0>) : u64 {
        arg0.fee
    }

    public fun getParticipants<T0>(arg0: &AddressesObj<T0>) : vector<address> {
        arg0.addresses
    }

    public fun update_adresses_and_return_old<T0>(arg0: &mut AddressesObj<T0>, arg1: vector<address>) : vector<address> {
        arg0.addresses = arg1;
        arg0.addresses
    }

    // decompiled from Move bytecode v6
}

