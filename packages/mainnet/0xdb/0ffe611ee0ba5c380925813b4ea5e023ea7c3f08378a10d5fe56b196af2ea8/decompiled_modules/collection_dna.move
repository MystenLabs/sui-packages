module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection_dna {
    struct CollectionDnaKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CollectionDnaAdded has copy, drop {
        collection_id: 0x2::object::ID,
    }

    struct COLLECTION_DNA has drop {
        dummy_field: bool,
    }

    public(friend) fun add_dna_internal(arg0: &mut 0x2::object::UID, arg1: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna, arg2: 0x2::object::ID) {
        let v0 = CollectionDnaKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<CollectionDnaKey>(arg0, v0), 2);
        let v1 = CollectionDnaKey{dummy_field: false};
        0x2::dynamic_field::add<CollectionDnaKey, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna>(arg0, v1, arg1);
        let v2 = CollectionDnaAdded{collection_id: arg2};
        0x2::event::emit<CollectionDnaAdded>(v2);
    }

    public fun get_dna(arg0: &0x2::object::UID) : &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna {
        let v0 = CollectionDnaKey{dummy_field: false};
        0x2::dynamic_field::borrow<CollectionDnaKey, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna>(arg0, v0)
    }

    public fun get_dna_values(arg0: &0x2::object::UID) : (vector<u8>, vector<u8>) {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::get_dna_values(get_dna(arg0))
    }

    public fun has_dna(arg0: &0x2::object::UID) : bool {
        let v0 = CollectionDnaKey{dummy_field: false};
        0x2::dynamic_field::exists_<CollectionDnaKey>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

