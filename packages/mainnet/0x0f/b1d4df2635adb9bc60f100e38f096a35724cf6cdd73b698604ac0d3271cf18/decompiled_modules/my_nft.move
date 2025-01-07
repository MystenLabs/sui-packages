module 0xfb1d4df2635adb9bc60f100e38f096a35724cf6cdd73b698604ac0d3271cf18::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"wenchao13547_my_nft"),
            image_url : 0x1::string::utf8(b"https://th.bing.com/th/id/OIP.lmmCSF58ToGg5yqFOQqh8wHaHa?w=198&h=198&c=7&r=0&o=5&pid=1.7"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"wenchao13547_my_nft"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint2(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"wenchao13547_my_nft"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_nft(arg0: MyNFT, arg1: address) {
        0x2::transfer::transfer<MyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

