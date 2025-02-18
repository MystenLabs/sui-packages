module 0xb7390c0968ae1dcb5959c86cbb3ce76e03f9fc51ccf6e2c76a6330317d915bf8::my_nft {
    struct MYNTF has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    public entry fun mint_to_others(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MYNTF{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/65163370?v=4"),
        };
        0x2::transfer::transfer<MYNTF>(v0, arg1);
    }

    public entry fun mint_to_self(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MYNTF{
            id        : 0x2::object::new(arg1),
            name      : arg0,
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/65163370?v=4"),
        };
        0x2::transfer::transfer<MYNTF>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

