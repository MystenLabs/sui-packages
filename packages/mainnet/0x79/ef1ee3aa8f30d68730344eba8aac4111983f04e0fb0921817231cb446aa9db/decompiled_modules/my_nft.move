module 0x79ef1ee3aa8f30d68730344eba8aac4111983f04e0fb0921817231cb446aa9db::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"sunyun12 NFT"),
            image_url : 0x1::string::utf8(b"https://s1.aigei.com/src/img/png/2c/2c4d5b8dbda34062b22d46365b573bda.png?imageMogr2/auto-orient/thumbnail/!282x282r/gravity/Center/crop/282x282/quality/85/%7CimageView2/2/w/282&e=2051020800&token=P7S2Xpzfz11vAkASLTkfHN7Fw-oOZBecqeJaxypL:eU088z6GP5H7T9Ic_kuK354spBI="),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

