module 0xb8c173398d12c9e7535be79adfe3ea0c96c3a0634f35ef22a423b51a472d4501::constants {
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

