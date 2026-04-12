module 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::constants {
    public(friend) fun collection_name() : vector<u8> {
        b"MegaTowerObjects"
    }

    public(friend) fun creator() : vector<u8> {
        b"@megatower"
    }

    public(friend) fun default_description() : vector<u8> {
        b"https://megatower.com/"
    }

    public(friend) fun min_royalty_amount() : u64 {
        100000000
    }

    public(friend) fun project_url() : vector<u8> {
        b"https://megatower.com/"
    }

    public(friend) fun royalty_bp() : u16 {
        500
    }

    // decompiled from Move bytecode v7
}

