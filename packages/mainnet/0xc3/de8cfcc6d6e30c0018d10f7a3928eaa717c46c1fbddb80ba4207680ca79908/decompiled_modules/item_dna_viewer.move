module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item_dna_viewer {
    public fun get_item_dna_values(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: 0x2::object::ID) : (vector<u8>, vector<u8>) {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item_dna::get_dna_values(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id(arg0), arg1)
    }

    public fun has_item_dna(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: 0x2::object::ID) : bool {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item_dna::has_dna(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

