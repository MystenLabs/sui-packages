module 0x57397cb46abbc21cd4399e6a6d4fcce538f3b6934d2208e55d8041f89ad9c3f4::unlizhaonft {
    struct UnlizhaoNft has store, key {
        id: 0x2::object::UID,
        idx: u64,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct UnlizhaoNftCap has store, key {
        id: 0x2::object::UID,
        cur_supply: u64,
    }

    public entry fun transfer(arg0: UnlizhaoNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<UnlizhaoNft>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UnlizhaoNftCap{
            id         : 0x2::object::new(arg0),
            cur_supply : 0,
        };
        0x2::transfer::public_transfer<UnlizhaoNftCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_nft(arg0: &mut UnlizhaoNftCap, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.cur_supply = arg0.cur_supply + 1;
        let v0 = UnlizhaoNft{
            id          : 0x2::object::new(arg1),
            idx         : arg0.cur_supply,
            description : 0x1::string::utf8(b"unlizhao nft"),
            url         : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/25890413?v=4"),
        };
        assert!(arg0.cur_supply <= 237, 0);
        0x2::transfer::public_transfer<UnlizhaoNft>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

