module 0x648434341cab15c1ecbbd03378e326973e9c3b5972575ef2473b8f50bde13fe4::my_nft {
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

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MY_NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

