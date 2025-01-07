module 0x60cea112ab74106087f3d8ccd783af45cceca73a0c3d250ffe9451ac91c081e6::my_nft {
    struct MYNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MYNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"CreatorYuan NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/15226478?v=4"),
        };
        0x2::transfer::public_transfer<MYNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MYNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MYNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

