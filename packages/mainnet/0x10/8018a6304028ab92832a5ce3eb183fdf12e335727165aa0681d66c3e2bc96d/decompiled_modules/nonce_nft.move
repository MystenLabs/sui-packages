module 0x108018a6304028ab92832a5ce3eb183fdf12e335727165aa0681d66c3e2bc96d::nonce_nft {
    struct Nonce has key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_nonce_bytes(arg0: &Nonce) : vector<u8> {
        0x2::object::id_bytes<Nonce>(arg0)
    }

    public fun mint_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Nonce{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Nonce>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

