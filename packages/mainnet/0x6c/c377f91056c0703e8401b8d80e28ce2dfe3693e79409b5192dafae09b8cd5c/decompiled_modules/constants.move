module 0x6cc377f91056c0703e8401b8d80e28ce2dfe3693e79409b5192dafae09b8cd5c::constants {
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

