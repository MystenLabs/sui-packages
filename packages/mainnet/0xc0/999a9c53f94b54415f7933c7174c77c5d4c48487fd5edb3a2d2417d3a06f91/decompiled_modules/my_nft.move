module 0xc0999a9c53f94b54415f7933c7174c77c5d4c48487fd5edb3a2d2417d3a06f91::my_nft {
    struct My_nft has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        name: vector<u8>,
        description: vector<u8>,
    }

    public fun burn(arg0: My_nft, arg1: &mut 0x2::tx_context::TxContext) {
        let My_nft {
            id          : v0,
            url         : _,
            name        : _,
            description : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = My_nft{
            id          : 0x2::object::new(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/92988539?s=400&v=4"),
            name        : b"digot-dream-ntf",
            description : b"used for letmove task",
        };
        0x2::transfer::public_transfer<My_nft>(v0, @0x7b8e0864967427679b4e129f79dc332a885c6087ec9e187b53451a9006ee15f2);
    }

    // decompiled from Move bytecode v6
}

