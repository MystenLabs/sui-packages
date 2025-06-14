module 0x70b9626c66d2cce8e59340d1dbf6d133e2ad0bc5569e3850e75a0390b2a34f45::core {
    struct Name has drop, store {
        pub: vector<u8>,
        owner: address,
    }

    struct Mizt has store, key {
        id: 0x2::object::UID,
        names: 0x2::table::Table<0x1::string::String, Name>,
        name_owners: 0x2::table::Table<address, 0x1::string::String>,
        ephemeral_pubs: 0x2::table_vec::TableVec<vector<u8>>,
    }

    struct NewEphemeralPub has copy, drop {
        ephemeral_pub: vector<u8>,
        addr: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Mizt{
            id             : 0x2::object::new(arg0),
            names          : 0x2::table::new<0x1::string::String, Name>(arg0),
            name_owners    : 0x2::table::new<address, 0x1::string::String>(arg0),
            ephemeral_pubs : 0x2::table_vec::empty<vector<u8>>(arg0),
        };
        0x2::transfer::share_object<Mizt>(v0);
    }

    fun new_ephemeral_pub(arg0: &mut Mizt, arg1: vector<u8>, arg2: address) {
        0x2::table_vec::push_back<vector<u8>>(&mut arg0.ephemeral_pubs, arg1);
        let v0 = NewEphemeralPub{
            ephemeral_pub : arg1,
            addr          : arg2,
        };
        0x2::event::emit<NewEphemeralPub>(v0);
    }

    public fun register_name(arg0: &mut Mizt, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, Name>(&arg0.names, arg1), 13906834376206843905);
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.name_owners, 0x2::tx_context::sender(arg3))) {
            0x2::table::remove<0x1::string::String, Name>(&mut arg0.names, 0x2::table::remove<address, 0x1::string::String>(&mut arg0.name_owners, 0x2::tx_context::sender(arg3)));
        };
        let v0 = Name{
            pub   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::table::add<0x1::string::String, Name>(&mut arg0.names, arg1, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.name_owners, 0x2::tx_context::sender(arg3), arg1);
    }

    public fun transfer_coin_in<T0>(arg0: &mut Mizt, arg1: address, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg1);
        new_ephemeral_pub(arg0, arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

