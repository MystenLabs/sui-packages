module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission {
    public(friend) fun e_ticket_create() : vector<u8> {
        b"e_ticket:create"
    }

    public(friend) fun e_ticket_delete() : vector<u8> {
        b"e_ticket:delete"
    }

    public(friend) fun e_ticket_publish() : vector<u8> {
        b"e_ticket:publish"
    }

    public(friend) fun e_ticket_unpublish() : vector<u8> {
        b"e_ticket:unpublish"
    }

    public(friend) fun e_ticket_update() : vector<u8> {
        b"e_ticket:update"
    }

    public(friend) fun nft_collection_create() : vector<u8> {
        b"nft_collection:create"
    }

    public(friend) fun nft_collection_delete() : vector<u8> {
        b"nft_collection:delete"
    }

    public(friend) fun nft_collection_update() : vector<u8> {
        b"nft_collection:update"
    }

    public(friend) fun stamp_rally_create() : vector<u8> {
        b"stamp_rally:create"
    }

    public(friend) fun stamp_rally_delete() : vector<u8> {
        b"stamp_rally:delete"
    }

    public(friend) fun stamp_rally_publish() : vector<u8> {
        b"stamp_rally:publish"
    }

    public(friend) fun stamp_rally_unpublish() : vector<u8> {
        b"stamp_rally:unpublish"
    }

    public(friend) fun stamp_rally_update() : vector<u8> {
        b"stamp_rally:update"
    }

    public(friend) fun super_admin() : vector<u8> {
        b"*"
    }

    // decompiled from Move bytecode v6
}

