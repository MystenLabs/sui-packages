module 0xd0eec840e0397c299878a923d7c407e05f811072520e97ae7b12600ff37252e0::constants {
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

