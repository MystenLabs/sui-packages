module 0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::constants {
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

