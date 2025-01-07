module 0x5c7719d22684468e6fc5b0c72cbfe00e8a4cd01080d3ee85159ff3ec72789927::oliverxl_nft {
    struct Oliverxl_Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oliverxl_Nft{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"oliverxl nft"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/20931572?v=4"),
        };
        0x2::transfer::public_transfer<Oliverxl_Nft>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Oliverxl_Nft{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<Oliverxl_Nft>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Oliverxl_Nft{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<Oliverxl_Nft>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

