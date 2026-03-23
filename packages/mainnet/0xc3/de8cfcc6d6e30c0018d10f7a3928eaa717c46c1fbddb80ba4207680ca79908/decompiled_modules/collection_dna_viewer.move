module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection_dna_viewer {
    public fun get_collection_dna_values(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection) : (vector<u8>, vector<u8>) {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection_dna::get_dna_values(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id(arg0))
    }

    public fun has_collection_dna(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection) : bool {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection_dna::has_dna(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id(arg0))
    }

    // decompiled from Move bytecode v6
}

