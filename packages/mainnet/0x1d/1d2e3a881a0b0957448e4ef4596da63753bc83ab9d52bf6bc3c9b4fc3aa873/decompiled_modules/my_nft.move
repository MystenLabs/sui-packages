module 0x1d1d2e3a881a0b0957448e4ef4596da63753bc83ab9d52bf6bc3c9b4fc3aa873::my_nft {
    struct MY_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_NFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Ch1hiro"),
            image_url : 0x1::string::utf8(b"https://oss-of-ch1hiro.oss-cn-beijing.aliyuncs.com/imgs/202407082229562.jpg"),
        };
        0x2::transfer::public_transfer<MY_NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_NFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MY_NFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

